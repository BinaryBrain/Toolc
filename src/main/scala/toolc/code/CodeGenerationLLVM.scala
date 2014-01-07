package toolc
package code

import ast.Trees._
import analyzer.Symbols._
import analyzer.Types._
import utils._
import java.io.PrintWriter
import code.LLVM._

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

  def compileStat(stat: StatTree): List[Instruction] = {
    stat match {

      case Block(stats: List[StatTree]) =>
        stats.flatMap(compileStat)

      case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) =>
        val cond = compileExpr(expr)
        val condReg = lastReg
        val ifTrueLabel = freshReg
        val thnPart = compileStat(thn)
        var ifFalseLabel = freshReg
        var elsPart = List[Instruction]()
        var ifEndLabel = ifFalseLabel

        if (els.isDefined) {
          elsPart = compileStat(els.get)
          ifEndLabel = freshReg

          cond :::
            List(branch(condReg, ifTrueLabel, ifFalseLabel)) :::
            List(label(ifTrueLabel)) :::
            thnPart :::
            List(jump(ifEndLabel)) :::
            List(label(ifFalseLabel)) :::
            elsPart :::
            List(jump(ifEndLabel)) :::
            List(label(ifEndLabel))

        } else {
          cond :::
            List(branch(condReg, ifTrueLabel, ifFalseLabel)) :::
            List(label(ifTrueLabel)) :::
            thnPart :::
            List(jump(ifEndLabel)) :::
            List(label(ifEndLabel))
        }

      case While(expr: ExprTree, stat: StatTree) => Nil

      case Println(expr: ExprTree) =>
        var s = compileExpr(expr)

        if (expr.getType == TBoolean) {
          s = s :::
            List(zext(freshReg, oldReg, "i1", "i32"))
        }
        if (expr.getType == TInt || expr.getType == TBoolean) {
          s = s :::
            List(call(freshReg, "i32 (i8*, ...)*", "@printf", "i8* getelementptr" +
              " inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 " +
              oldReg))
        } else {
          s = s :::
            List(call(freshReg, "i32 (i8*, ...)*", "@printf", "i8* getelementptr" +
              " inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* " +
              oldReg))
        }

        return s

      case Assign(id: Identifier, expr: ExprTree) =>
        compileExpr(expr) :::
          List(store(lastReg, "%" + id.value, typeOf(expr.getType)))

      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) => Nil
    }
  }

  def compileExpr(expr: ExprTree): List[Instruction] = expr match {
    case And(lhs: ExprTree, rhs: ExprTree) => Nil
    case Or(lhs: ExprTree, rhs: ExprTree) => Nil

    case Plus(lhs: ExprTree, rhs: ExprTree) => // Handle string concatenation (with int too)
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(add(freshReg, savedReg, oldReg))

    case Minus(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(sub(freshReg, savedReg, oldReg))

    case Times(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(mul(freshReg, savedReg, oldReg))

    case Div(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(sdiv(freshReg, savedReg, oldReg))

    case LessThan(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      l ::: r ::: List(lessThan(freshReg, savedReg, oldReg))

    case Equals(lhs: ExprTree, rhs: ExprTree) => Nil
    case ArrayRead(arr: ExprTree, index: ExprTree) => Nil
    case ArrayLength(arr: ExprTree) => Nil

    case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
      val structName = "%struct." + obj.getType
      val objCompiled = compileExpr(obj)
      val objReg = lastReg
      var argsCompiled = List[Instruction]()
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

      if (!args.isEmpty) {
        objCompiled ::: argsCompiled :::
          List(getelementptr(freshReg, structName + "*", objReg)) :::
          List(load(freshReg, oldReg, structName + "$vtable*")) :::
          List(getelementptr(freshReg, structName + "$vtable*", oldReg)) :::
          List(load(freshReg, oldReg, methType + "*")) :::
          List(call(freshReg, typeOf(meth.getType), oldReg, structName + "* " + objReg + ", " +
            argsType.zip(savedArgsReg).map(a => a._1 + " " + a._2).mkString(", ")))
      } else {
        objCompiled :::
          List(getelementptr(freshReg, structName + "*", objReg)) :::
          List(load(freshReg, oldReg, structName + "$vtable*")) :::
          List(getelementptr(freshReg, structName + "$vtable*", oldReg)) :::
          List(load(freshReg, oldReg, methType + "*")) :::
          List(call(freshReg, typeOf(meth.getType), oldReg, structName + "* " + objReg))
      }

    case IntLit(value: Int) =>
      alloca(freshReg, "i32") ::
        store(value.toString, lastReg, "i32") ::
        List(load(freshReg, oldReg, "i32"))

    case StringLit(value: String) =>
      addStrConstant(value)
      alloca(freshReg, "i8*") ::
        store("getelementptr inbounds ([" + (value.length() + 1) + " x i8]* " +
          "@.str" + (strConstants.size - 1) + ", i32 0, i32 0)", lastReg, "i8*") ::
        List(load(freshReg, oldReg, "i8*"))

    case True() =>
      alloca(freshReg, "i1") ::
        store("true", lastReg, "i1") ::
        List(load(freshReg, oldReg, "i1"))

    case False() =>
      alloca(freshReg, "i1") ::
        store("false", lastReg, "i1") ::
        List(load(freshReg, oldReg, "i1"))

    case id: Identifier =>
      val tpe = typeOf(id.getType)
      val tpeDeref = tpe.subSequence(0, tpe.length() - 1)
      List(load(freshReg, "%" + id.value, typeOf(id.getType)))

    case t: This =>
      alloca(freshReg, "%struct." + t.getType + "*") ::
        store("%this", lastReg, "%struct." + t.getType + "*") ::
        List(load(freshReg, oldReg, "%struct." + t.getType + "*"))

    case NewIntArray(size: ExprTree) => Nil
    case New(tpe: Identifier) =>
      List(call(freshReg, "%struct." + tpe.value + "*", "@new$" + tpe.value, ""))
    case Not(expr: ExprTree) => Nil
  }

  def generateClass(cl: ClassDecl): String = {
    var s: String = ""
    val className = cl.id.value

    // struct for the class with fields and a vtable
    val fields = for(field <- cl.vars) yield (typeOf(field.tpe))
    s = s +
      "%struct." + className + " = type { " +
      "%struct." + className + "$vtable*" +
      (if(!fields.isEmpty) ", " else "") +
      fields.mkString(", ") +
      " }\n"

    // struct for the vtable
    s = s +
      "%struct." + className + "$vtable = type { " +
      cl.methods.map(methodSignature(cl, _)).mkString(", ") +
      "}\n"

    // global vtable
    s = s +
      "@" + className + "$vtable = global %struct." +
      className + "$vtable { " +
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
    "define %struct." + className + "* @new$" + className + "() nounwind ssp {\n    " +
      (alloca("%obj", "%struct." + className + "*") ::
        call(freshReg, "i8*", "@malloc", "i64 8") :: // TODO Change arg
        bitcast(freshReg, "i8*", oldReg, "%struct." + className + "*") ::
        store(lastReg, "%obj", "%struct." + className + "*") ::
        load(freshReg, "%obj", "%struct." + className + "*") ::
        getelementptr(freshReg, "%struct." + className + "*", oldReg) ::
        store("@" + className + "$vtable", lastReg, "%struct." + className + "$vtable*") ::
        load(freshReg, "%obj", "%struct." + className + "*") ::
        List(ret("%struct." + className + "*", lastReg))).map(_.asAssembly).mkString("\n    ") +
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
        "@" + cl.id.value + "$" + m.id.value + " "
    } else {
      typeOf(m.retType) + " (" + typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* " +
        "@" + cl.id.value + "$" + m.id.value + " "
    }
  }

  def typeOf(t: TypeTree): String = t match {
    case IntType() => "i32"
    case Identifier(id) => "%struct." + id + "*"
    case BooleanType() => "i1"
    case StringType() => "i8*"
    case _ => "Not yet implemented"
  }

  def typeOf(f: Formal): String = typeOf(f.tpe)

  def typeOf(t: Type): String = t match {
    case TInt => "i32"
    case TObject(id) => "%struct." + id + "*"
    case TBoolean => "i1"
    case TString => "i8*"
    case _ => "Not yet implemented"
  }

  def generateMethod(cl: ClassDecl, m: MethodDecl): String = {
    lastRegUsed = 0

    if (m.args.isEmpty) {
      "define " + typeOf(m.retType) + " @" + cl.id.value + "$" + m.id.value + "(" + typeOf(cl.id) +
        " %this" + ") nounwind ssp {\n    " +
        m.vars.map(generateVarDecl).mkString("\n    ") + "\n    " +
        m.stats.flatMap(compileStat).map(_.asAssembly).mkString("\n    ") +
        "\n    " + compileExpr(m.retExpr).map(_.asAssembly).mkString("\n    ") +
        "\n    ret " + typeOf(m.retType) + " " + lastReg +
        "\n}"
    } else {
      "define " + typeOf(m.retType) + " @" + cl.id.value + "$" + m.id.value + "(" + typeOf(cl.id) +
        " %this, " + m.args.map(arg => typeOf(arg) + " %_" +
          arg.id.value).mkString(", ") + ") nounwind ssp {\n    " +
        m.args.map(generateArg).mkString("\n    ") + "\n    " +
        m.vars.map(generateVarDecl).mkString("\n    ") + "\n    " +
        m.stats.flatMap(compileStat).map(_.asAssembly).mkString("\n    ") +
        "\n    " + compileExpr(m.retExpr).map(_.asAssembly).mkString("\n    ") +
        "\n    ret " + typeOf(m.retType) + " " + lastReg +
        "\n}"
    }
  }

  def generateVarDecl(v: VarDecl): String = {
    alloca("%" + v.id.value, typeOf(v.tpe)).asAssembly
  }

  def generateArg(a: Formal): String = {
    alloca("%" + a.id.value, typeOf(a)).asAssembly + "\n    " +
      store("%_" + a.id.value, "%" + a.id.value, typeOf(a)).asAssembly
  }

  def generateMainMethod(prog: Program): String = {
    lastRegUsed = 0
    "define i32 @main() nounwind ssp {\n    " +
      prog.main.stats.flatMap(compileStat).map(_.asAssembly).mkString("\n    ") +
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
