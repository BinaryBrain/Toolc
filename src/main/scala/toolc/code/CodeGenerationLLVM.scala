package toolc
package code

import ast.Trees._
import analyzer.Symbols._
import analyzer.Types._
import utils._
import java.io.PrintWriter

object CodeGenerationLLVM extends Pipeline[Program, Unit] {

  var lastRegUsed: Int = 0;
  var strConstants: List[String] = List("@.str = private unnamed_addr constant [4 x i8] c\"%s\\0A\\00\"",
    "@.str1 = private unnamed_addr constant [4 x i8] c\"%d\\0A\\00\"");

  def run(ctx: Context)(prog: Program): Unit = {
    import ctx.reporter._;

    // generate LLVM assembly
    val headers = generateHeaders(ctx.file.getName());
    val classes = prog.classes.map(generateClass(_))
    val main = generateMainMethod(prog);
    val declarations = generateDeclarations()

    val code = headers + strConstants.mkString("\n") + "\n\n" + classes.mkString("\n") +
      main + declarations

    // Print for debug purpose
    println(code)

    // output to file
    Some(new PrintWriter(prog.main.id.value + ".ll")).foreach { p => p.write(code); p.close }
  }

  def compileStat(stat: StatTree): List[String] = {
    stat match {

      case Block(stats: List[StatTree]) =>
        stats.flatMap(compileStat)

      case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) => Nil
      case While(expr: ExprTree, stat: StatTree) => Nil

      case Println(expr: ExprTree) =>
        var s = compileExpr(expr)
        if (expr.getType == TInt || expr.getType == TBoolean) {
          s = s :::
            List(freshReg + " = call i32 (i8*, ...)* @printf(i8* getelementptr" +
              " inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 " +
              oldReg + ")")
        } else {
          s = s :::
            List(freshReg + " = call i32 (i8*, ...)* @printf(i8* getelementptr" +
              " inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* " +
              oldReg + ")")
        }

        return s

      case Assign(id: Identifier, expr: ExprTree) => Nil
      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) => Nil
    }
  }

  def compileExpr(expr: ExprTree): List[String] = expr match {
    case And(lhs: ExprTree, rhs: ExprTree) => Nil
    case Or(lhs: ExprTree, rhs: ExprTree) => Nil

    case Plus(lhs: ExprTree, rhs: ExprTree) => // Handle string concatenation (with int too)
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(freshReg + " = add nsw i32 " + savedReg + ", " + oldReg)

    case Minus(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(freshReg + " = sub nsw i32 " + savedReg + ", " + oldReg)

    case Times(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(freshReg + " = mul nsw i32 " + savedReg + ", " + oldReg)

    case Div(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(freshReg + " = sdiv i32 " + savedReg + ", " + oldReg)

    case LessThan(lhs: ExprTree, rhs: ExprTree) => Nil
    case Equals(lhs: ExprTree, rhs: ExprTree) => Nil
    case ArrayRead(arr: ExprTree, index: ExprTree) => Nil
    case ArrayLength(arr: ExprTree) => Nil
    case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) => Nil

    case IntLit(value: Int) =>
      freshReg + " = alloca i32, align 4" ::
        "store i32 " + value + ", i32* " + lastReg + ", align 4" ::
        List(freshReg + " = load i32* " + oldReg + ", align 4")

    case StringLit(value: String) =>
      addStrConstant(value)
      freshReg + " = alloca i8*, align 8" ::
        "store i8* getelementptr inbounds ([" + (value.length() + 1) + " x i8]* " +
        "@.str" + (strConstants.size - 1) + ", i32 0, i32 0), i8** " + lastReg + ", align 8" ::
        List(freshReg + " = load i8** " + oldReg + ", align 8")

    case True() =>
      freshReg + " = alloca i32, align 4" ::
        "store i32 " + 1 + ", i32* " + lastReg + ", align 4" ::
        List(freshReg + " = load i32* " + oldReg + ", align 4")

    case False() =>
      freshReg + " = alloca i32, align 4" ::
        "store i32 " + 0 + ", i32* " + lastReg + ", align 4" ::
        List(freshReg + " = load i32* " + oldReg + ", align 4")

    case Identifier(value: String) => Nil
    case This() => Nil
    case NewIntArray(size: ExprTree) => Nil
    case New(tpe: Identifier) => Nil
    case Not(expr: ExprTree) => Nil
  }

  def generateClass(cl: ClassDecl): String = {
    var s: String = ""
    val className = cl.id.value

    // struct for the class with fields and a vtable
    s = s +
      "%struct." + className + " = type { " +
      "%struct." + className + "_vtable* " +
      "}\n"
    // TODO add fields

    // struct for the vtable
    s = s +
      "%struct." + className + "_vtable = type { " +
      cl.methods.map(methodSignature(cl, _)).mkString(", ") +
      "}\n"

    // global vtable
    s = s +
      "@" + className + "_vtable = global %struct." +
      className + "_vtable { " +
      cl.methods.map(methodSignatureWithName(cl, _)).mkString(", ") +
      "}, align 8\n\n"

    return s
  }

  def methodSignature(cl: ClassDecl, m: MethodDecl): String = {
    typeOf(m.retType) + " (" + typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* "
  }

  def methodSignatureWithName(cl: ClassDecl, m: MethodDecl): String = {
    typeOf(m.retType) + " (" + typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* " +
      "@" + m.id.value + " "
  }

  def typeOf(t: TypeTree): String = t match {
    case IntType() => "i32"
    case Identifier(id) => "%struct." + id + "*"
    case _ => "Not yet implemented"
  }

  def typeOf(f: Formal): String = typeOf(f.tpe)

  def generateMethod(cl: ClassDecl, m: MethodDecl): String = {
    return ""
  }

  def generateMainMethod(prog: Program): String = {
    "define i32 @main() nounwind ssp {\n    " +
      prog.main.stats.flatMap(compileStat).mkString("\n    ") +
      "\n    ret i32 0\n" +
      "}\n\n"
  }

  def generateHeaders(sourceName: String): String = {
    "; ModuleID = '" + sourceName + "'\n" +
      "target datalayout = " +
      "\"e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:" +
      "64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0" +
      ":64-s0:64:64-f80:128:128-n8:16:32:64\"\n" +
      "target triple = \"x86_64-apple-macosx10.7.4\"\n\n" //TODO Change OS
  }

  def generateDeclarations(): String = {
    "declare i32 @printf(i8*, ...)\n" +
      "declare i8* @malloc(i64)\n"
  }

  def addStrConstant(str: String): Unit = {
    val indexOfNewElement = strConstants.size;
    strConstants = strConstants :::
      List("@.str" + indexOfNewElement + " = private unnamed_addr constant " +
        "[" + (str.length() + 1) + " x i8] c\"" + str + "\\00\"")
  }

  def oldReg: String = {
    return "%" + (lastRegUsed - 1)
  }

  def lastReg: String = {
    return "%" + lastRegUsed
  }

  def freshReg: String = {
    lastRegUsed = lastRegUsed + 1
    return "%" + lastRegUsed
  }
}
