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

      case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) =>
        val cond = compileExpr(expr)
        val condReg = lastReg
        val ifTrueLabel = freshReg
        val thnPart = compileStat(thn)
        var ifFalseLabel = freshReg
        var elsPart = List[String]()
        var ifEndLabel = ifFalseLabel

        if (els.isDefined) {
          elsPart = compileStat(els.get)
          ifEndLabel = freshReg

          cond :::
            List("br i1 " + condReg + ", label " + ifTrueLabel + ", label " + ifFalseLabel) :::
            List("\n; <label>: " + ifTrueLabel) :::
            thnPart :::
            List("br label " + ifEndLabel) :::
            List("\n; <label>: " + ifFalseLabel) :::
            elsPart :::
            List("br label " + ifEndLabel) :::
            List("\n; <label>: " + ifEndLabel)

        } else {
          cond :::
            List("br i1 " + condReg + ", label " + ifTrueLabel + ", label " + ifFalseLabel) :::
            List("\n; <label>: " + ifTrueLabel) :::
            thnPart :::
            List("br label " + ifEndLabel) :::
            elsPart :::
            List("\n; <label>: " + ifEndLabel)
        }

      case While(expr: ExprTree, stat: StatTree) => Nil

      case Println(expr: ExprTree) =>
        var s = compileExpr(expr)

        if (expr.getType == TBoolean) {
          s = s :::
            List(freshReg + " = zext i1 " + oldReg + " to i32")
        }
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

      case Assign(id: Identifier, expr: ExprTree) =>
        compileExpr(expr) :::
          List("store " + typeOf(expr.getType) + " " + lastReg +
            ", " + typeOf(expr.getType) + "* %" + id.value + ", align 4")

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

    case LessThan(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r :::
        List(freshReg + " = icmp slt i32 " + savedReg + ", " + oldReg)

    case Equals(lhs: ExprTree, rhs: ExprTree) => Nil
    case ArrayRead(arr: ExprTree, index: ExprTree) => Nil
    case ArrayLength(arr: ExprTree) => Nil

    case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
      val structName = "%struct." + obj.getType
      val objCompiled = compileExpr(obj)
      val objReg = lastReg
      var argsCompiled = List[String]()
      var savedArgsReg = List[String]()
      var argsType = List[String]()

      args.foreach { a =>
        argsCompiled = argsCompiled ::: compileExpr(a)
        savedArgsReg = savedArgsReg ::: List(lastReg)
        argsType = argsType ::: List(typeOf(a.getType))
      }

      var methType: String = ""
      if (!args.isEmpty) {
        methType = typeOf(meth.getType) + " (" + structName + "*, " +
          args.map(a => typeOf(a.getType)).mkString(", ") + ")"
      } else {
        methType = typeOf(meth.getType) + " (" + structName + "*)"
      }

      if(!args.isEmpty) {
      objCompiled ::: argsCompiled :::
        List(freshReg + " = getelementptr inbounds " + structName + "* " + objReg + ", i32 0, i32 0") :::
        List(freshReg + " = load " + structName + "_vtable** " + oldReg + ", align 8") :::
        List(freshReg + " = getelementptr inbounds " + structName + "_vtable* " + oldReg + ", i32 0, i32 0") :::
        List(freshReg + " = load " + methType + "** " + oldReg + ", align 8") :::
        List(freshReg + " = call i32 " + oldReg + "("+structName+"* " + objReg + ", " +
          argsType.zip(savedArgsReg).map(a => a._1 + " " + a._2).mkString(", ") +
          ")")
      } else {
        objCompiled :::
        List(freshReg + " = getelementptr inbounds " + structName + "* " + objReg + ", i32 0, i32 0") :::
        List(freshReg + " = load " + structName + "_vtable** " + oldReg + ", align 8") :::
        List(freshReg + " = getelementptr inbounds " + structName + "_vtable* " + oldReg + ", i32 0, i32 0") :::
        List(freshReg + " = load " + methType + "** " + oldReg + ", align 8") :::
        List(freshReg + " = call i32 " + oldReg + "("+structName+"* " + objReg + ")")
      }

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
      freshReg + " = alloca i1, align 4" ::
        "store i1 true, i1* " + lastReg + ", align 4" ::
        List(freshReg + " = load i1* " + oldReg + ", align 4")

    case False() =>
      freshReg + " = alloca i1, align 4" ::
        "store i1 false, i1* " + lastReg + ", align 4" ::
        List(freshReg + " = load i1* " + oldReg + ", align 4")

    case id: Identifier =>
      List(freshReg + " = load " + typeOf(id.getType) + "* %"+ id.value + ", align 4")

    case t: This =>
      List(freshReg + " = alloca %struct." + t.getType + "*, align 8") :::
      List("store %struct." + t.getType + "* %this , %struct." + t.getType + "** " + lastReg +", align 4") :::
      List(freshReg + " = load %struct." + t.getType + "** "+ oldReg + ", align 8")
      
    case NewIntArray(size: ExprTree) => Nil
    case New(tpe: Identifier) =>
      List(freshReg + " = call %struct." + tpe.value + "* @new_" + tpe.value + "()")
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

    s = s +
      generateNew(cl) + "\n\n"
    // Methods generation
    s = s +
      cl.methods.map(generateMethod(cl, _)).mkString("\n\n")

    s + "\n\n"
  }

  def generateNew(cl: ClassDecl): String = {
    lastRegUsed = 0
    val className = cl.id.value
    "define %struct." + className + "* @new_" + className + "() nounwind ssp {\n    " +
      (("%obj = alloca %struct." + className + "*, align 8") ::
        (freshReg + " = call i8* @malloc(i64 8)") ::
        (freshReg + " = bitcast i8* " + oldReg + " to %struct." + className + "*") ::
        ("store %struct." + className + "* " + lastReg + ", %struct." + className + "** %obj, align 8") ::
        (freshReg + " = load %struct." + className + "** %obj, align 8") ::
        (freshReg + " = getelementptr inbounds %struct." + className + "* " + oldReg + ", i32 0, i32 0") ::
        ("store %struct." + className + "_vtable* @" + className + "_vtable, %struct." + className + "_vtable** %4, align 8") ::
        (freshReg + " = load %struct." + className + "** %obj, align 8") ::
        List(("ret %struct." + className + "*" + lastReg))).mkString("\n    ") +
        "\n}"
  }

  def methodSignature(cl: ClassDecl, m: MethodDecl): String = {
    if (m.args.isEmpty) {
      typeOf(m.retType) + " (" + typeOf(cl.id) + ")* "
    } else {
      typeOf(m.retType) + " (" + typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* "
    }
  }

  def methodSignatureWithName(cl: ClassDecl, m: MethodDecl): String = {
    if (m.args.isEmpty) {
      typeOf(m.retType) + " (" + typeOf(cl.id) + ")* " +
        "@" + m.id.value + " "
    } else {
      typeOf(m.retType) + " (" + typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* " +
        "@" + m.id.value + " "
    }
  }

  def typeOf(t: TypeTree): String = t match {
    case IntType() => "i32"
    case Identifier(id) => "%struct." + id + "*"
    case _ => "Not yet implemented"
  }

  def typeOf(f: Formal): String = typeOf(f.tpe)

  def typeOf(t: Type): String = t match {
    case TInt => "i32"
    case TObject(id) => "%struct." + id + "*"
    case TBoolean => "i1"
    case _ => "Not yet implemented"
  }

  def generateMethod(cl: ClassDecl, m: MethodDecl): String = {
    lastRegUsed = 0

    if (m.args.isEmpty) {
      "define " + typeOf(m.retType) + " @" + m.id.value + "(" + typeOf(cl.id) +
        " %this" + ") nounwind ssp {\n    " +
        m.vars.map(generateVarDecl).mkString("\n    ") + "\n    " +
        m.stats.flatMap(compileStat).mkString("\n    ") +
        "\n    " + compileExpr(m.retExpr).mkString("\n") +
        "\n    ret " + typeOf(m.retType) + " " + lastReg +
        "\n}"
    } else {
      "define " + typeOf(m.retType) + " @" + m.id.value + "(" + typeOf(cl.id) +
        " %this, " + m.args.map(arg => typeOf(arg) + " %_" +
          arg.id.value).mkString(", ") + ") nounwind ssp {\n    " +
        m.args.map(generateArg).mkString("\n    ") + "\n    " +
        m.vars.map(generateVarDecl).mkString("\n    ") + "\n    " +
        m.stats.flatMap(compileStat).mkString("\n    ") +
        "\n    " + compileExpr(m.retExpr).mkString("\n") +
        "\n    ret " + typeOf(m.retType) + " " + lastReg +
        "\n}"
    }
  }

  def generateVarDecl(v: VarDecl): String = {
    "%" + v.id.value + " = alloca " + typeOf(v.tpe) + ", align 4"
  }
  
  def generateArg(a: Formal): String = {
    "%" + a.id.value + " = alloca " + typeOf(a) + ", align 4\n" +
    "    store " + typeOf(a) + " %_" + a.id.value + ", " + typeOf(a) + "* %" + a.id.value + ", align 4"
  }

  def generateMainMethod(prog: Program): String = {
    lastRegUsed = 0
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

  def ancientReg: String = {
    return "%" + (lastRegUsed - 2)
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
