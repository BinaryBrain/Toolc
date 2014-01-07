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
  var structMap: Map[String, Class] = Map()
  var currentClass: Class = null
  var currentLocals = List[String]()
  var strConstants: List[String] = 
    List("@.str = private unnamed_addr constant [4 x i8] c\"%s\\0A\\00\"",
         "@.str1 = private unnamed_addr constant [4 x i8] c\"%d\\0A\\00\"", 
         "@.str2 = private unnamed_addr constant [3 x i8] c\"%d\\00\"");

  def run(ctx: Context)(prog: Program): Unit = {
    import ctx.reporter._;

    // Record classes structures for further references to find methods or fields index
    prog.classes.foreach { cl =>
      val c = new Class()
      c.tpe = "%struct." + cl.id.value
      c.fields = cl.vars.map(f => f.id.value)
      c.methods = cl.methods.map(m => m.id.value)
      structMap = structMap + (cl.id.value -> c)
    }

    // generate LLVM assembly
    val headers = generateHeaders(ctx.file.getName());
    val classHeaders = prog.classes.map(generateClassHeaders(_))
    val classes = prog.classes.map(generateClass(_))
    val main = generateMainMethod(prog);
    val declarations = generateDeclarations()

    val code = headers + strConstants.mkString("\n") + "\n\n" + classHeaders.mkString("\n") + classes.mkString("\n") +
      main + declarations

    // Print for debug purpose
    println(code)
    //println(structMap)

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

        if (currentLocals.contains(id.value)) {
          compileExpr(expr) :::
            List(store(lastReg, "%" + id.value, typeOf(expr.getType)))
        } else {
          if (!currentClass.fields.contains(id.value)) {
            sys.error("Unknown identifier for assign during code generation")
          }
          val exprCompiled = compileExpr(expr)
          val savedReg = lastReg
          exprCompiled :::
            getelementptr(freshReg, currentClass.tpe + "*", "%this", 1 + currentClass.fields.indexOf(id.value)) ::
            List(store(savedReg, lastReg, typeOf(id.getType)))

        }

      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) => Nil
    }
  }

  def compileExpr(expr: ExprTree): List[Instruction] = expr match {
    case And(lhs: ExprTree, rhs: ExprTree) => Nil
    case Or(lhs: ExprTree, rhs: ExprTree) => Nil

    case Plus(lhs: ExprTree, rhs: ExprTree) =>
      val l = compileExpr(lhs)
      val savedReg = lastReg
      val r = compileExpr(rhs)
      
      if (lhs.getType == TInt && rhs.getType == TInt) {
        l ::: r ::: List(add(freshReg, savedReg, oldReg))
      } else if (lhs.getType == TInt && rhs.getType == TString) {
        l ::: r ::: List(call(freshReg, "i8*", "@$concatIntString", "i32 " + savedReg + ", i8* " + oldReg))
      } else if(lhs.getType == TString && rhs.getType == TInt) {
        l ::: r ::: List(call(freshReg, "i8*", "@$concatStringInt", "i8* " + savedReg + ", i32 " + oldReg))
      } else {
        l ::: r ::: List(call(freshReg, "i8*", "@$concat", "i8* " + savedReg + ", i8* " + oldReg))
      }

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

      val methIndex = structMap(obj.getType.toString()).methods.indexOf(meth.value)

      if (!args.isEmpty) {
        objCompiled ::: argsCompiled :::
          List(getelementptr(freshReg, structName + "*", objReg, 0)) :::
          List(load(freshReg, oldReg, structName + "$vtable*")) :::
          List(getelementptr(freshReg, structName + "$vtable*", oldReg, methIndex)) :::
          List(load(freshReg, oldReg, methType + "*")) :::
          List(call(freshReg, typeOf(meth.getType), oldReg, structName + "* " + objReg + ", " +
            argsType.zip(savedArgsReg).map(a => a._1 + " " + a._2).mkString(", ")))
      } else {
        objCompiled :::
          List(getelementptr(freshReg, structName + "*", objReg, 0)) :::
          List(load(freshReg, oldReg, structName + "$vtable*")) :::
          List(getelementptr(freshReg, structName + "$vtable*", oldReg, methIndex)) :::
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

      if (currentLocals.contains(id.value)) {
        val tpe = typeOf(id.getType)
        val tpeDeref = tpe.subSequence(0, tpe.length() - 1)
        List(load(freshReg, "%" + id.value, typeOf(id.getType)))
      } else {
        if (!currentClass.fields.contains(id.value)) {
          sys.error("Unknow identifier during code generation")
        }

        getelementptr(freshReg, currentClass.tpe + "*", "%this", 1 + currentClass.fields.indexOf(id.value)) ::
          List(load(freshReg, oldReg, typeOf(id.getType)))

      }

    case t: This =>
      alloca(freshReg, "%struct." + t.getType + "*") ::
        store("%this", lastReg, "%struct." + t.getType + "*") ::
        List(load(freshReg, oldReg, "%struct." + t.getType + "*"))

    case NewIntArray(size: ExprTree) => Nil
    case New(tpe: Identifier) =>
      List(call(freshReg, "%struct." + tpe.value + "*", "@new$" + tpe.value, ""))
    case Not(expr: ExprTree) => Nil
  }

  def generateClassHeaders(cl: ClassDecl): String = {
    var s: String = ""
    val className = cl.id.value

    // struct for the class with fields and a vtable
    val fields = for (field <- cl.vars) yield (typeOf(field.tpe))
    s = s +
      "%struct." + className + " = type { " +
      "%struct." + className + "$vtable*" +
      (if (!fields.isEmpty) ", " else "") +
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
      "}, align 8\n"

    s + "\n"
  }

  def generateClass(cl: ClassDecl): String = {
    var s: String = ""
    currentClass = structMap(cl.id.value)
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
        call(freshReg, "i8*", "@malloc", "i64 " + (8 + cl.vars.foldLeft(0)((acc, v) => acc + sizeOf(typeOf(v.tpe)))).toString) :: // TODO Change arg
        bitcast(freshReg, "i8*", oldReg, "%struct." + className + "*") ::
        store(lastReg, "%obj", "%struct." + className + "*") ::
        load(freshReg, "%obj", "%struct." + className + "*") ::
        getelementptr(freshReg, "%struct." + className + "*", oldReg, 0) ::
        store("@" + className + "$vtable", lastReg, "%struct." + className + "$vtable*") ::
        load(freshReg, "%obj", "%struct." + className + "*") ::
        List(ret("%struct." + className + "*", lastReg))).map(_.asAssembly).mkString("\n    ") +
        "\n}"
  }

  def sizeOf(tpe: String): Int = if (tpe == "i32" || tpe == "i1") 4 else 8

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
    case TObject(id) => "%struct." + id.name + "*"
    case TBoolean => "i1"
    case TString => "i8*"
    case _ => "Not yet implemented"
  }

  def generateMethod(cl: ClassDecl, m: MethodDecl): String = {
    lastRegUsed = 0

    currentLocals = m.args.map(_.id.value) ::: m.vars.map(_.id.value)

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

  def generateDeclarations(): String = {
    "declare i32 @printf(i8*, ...)\n" +
      "declare i8* @malloc(i64)\n" +
      """define i8* @$concat(i8* %s, i8* %t) nounwind ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %size = alloca i32, align 4
  %str = alloca i8*, align 8
  store i8* %s, i8** %1, align 8
  store i8* %t, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = call i64 @strlen(i8* %3)
  %5 = load i8** %2, align 8
  %6 = call i64 @strlen(i8* %5)
  %7 = add i64 %4, %6
  %8 = add i64 %7, 1
  %9 = trunc i64 %8 to i32
  store i32 %9, i32* %size, align 4
  %10 = load i32* %size, align 4
  %11 = sext i32 %10 to i64
  %12 = mul i64 %11, 1
  %13 = call i8* @malloc(i64 %12)
  store i8* %13, i8** %str, align 8
  %14 = load i8** %str, align 8
  %15 = call i64 @llvm.objectsize.i64(i8* %14, i1 false)
  %16 = icmp ne i64 %15, -1
  br i1 %16, label %17, label %23

; <label>:17                                      ; preds = %0
  %18 = load i8** %str, align 8
  %19 = load i8** %1, align 8
  %20 = load i8** %str, align 8
  %21 = call i64 @llvm.objectsize.i64(i8* %20, i1 false)
  %22 = call i8* @__strcpy_chk(i8* %18, i8* %19, i64 %21) nounwind
  br label %27

; <label>:23                                      ; preds = %0
  %24 = load i8** %str, align 8
  %25 = load i8** %1, align 8
  %26 = call i8* @__inline_strcpy_chk(i8* %24, i8* %25)
  br label %27

; <label>:27                                      ; preds = %23, %17
  %28 = phi i8* [ %22, %17 ], [ %26, %23 ]
  store i8* %28, i8** %str, align 8
  %29 = load i8** %str, align 8
  %30 = call i64 @llvm.objectsize.i64(i8* %29, i1 false)
  %31 = icmp ne i64 %30, -1
  br i1 %31, label %32, label %38

; <label>:32                                      ; preds = %27
  %33 = load i8** %str, align 8
  %34 = load i8** %2, align 8
  %35 = load i8** %str, align 8
  %36 = call i64 @llvm.objectsize.i64(i8* %35, i1 false)
  %37 = call i8* @__strcat_chk(i8* %33, i8* %34, i64 %36) nounwind
  br label %42

; <label>:38                                      ; preds = %27
  %39 = load i8** %str, align 8
  %40 = load i8** %2, align 8
  %41 = call i8* @__inline_strcat_chk(i8* %39, i8* %40)
  br label %42

; <label>:42                                      ; preds = %38, %32
  %43 = phi i8* [ %37, %32 ], [ %41, %38 ]
  store i8* %43, i8** %str, align 8
  %44 = load i8** %str, align 8
  ret i8* %44
}

declare i64 @strlen(i8*)

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readnone

declare i8* @__strcpy_chk(i8*, i8*, i64) nounwind

define internal i8* @__inline_strcpy_chk(i8* noalias %__dest, i8* noalias %__src) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  store i8* %__dest, i8** %1, align 8
  store i8* %__src, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = load i8** %2, align 8
  %5 = load i8** %1, align 8
  %6 = call i64 @llvm.objectsize.i64(i8* %5, i1 false)
  %7 = call i8* @__strcpy_chk(i8* %3, i8* %4, i64 %6) nounwind
  ret i8* %7
}

declare i8* @__strcat_chk(i8*, i8*, i64) nounwind

define internal i8* @__inline_strcat_chk(i8* noalias %__dest, i8* noalias %__src) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  store i8* %__dest, i8** %1, align 8
  store i8* %__src, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = load i8** %2, align 8
  %5 = load i8** %1, align 8
  %6 = call i64 @llvm.objectsize.i64(i8* %5, i1 false)
  %7 = call i8* @__strcat_chk(i8* %3, i8* %4, i64 %6) nounwind
  ret i8* %7
}

define i8* @$concatStringInt(i8* %s, i32 %i) nounwind ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %str = alloca [15 x i8], align 1
  store i8* %s, i8** %1, align 8
  store i32 %i, i32* %2, align 4
  %3 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %4 = load i32* %2, align 4
  %5 = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %3, i32 0, i64 15, i8* getelementptr inbounds ([3 x i8]* @.str2, i32 0, i32 0), i32 %4)
  %6 = load i8** %1, align 8
  %7 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %8 = call i8* @$concat(i8* %6, i8* %7)
  ret i8* %8
}

declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...)

define i8* @$concatIntString(i32 %i, i8* %s) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %str = alloca [15 x i8], align 1
  store i32 %i, i32* %1, align 4
  store i8* %s, i8** %2, align 8
  %3 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %4 = load i32* %1, align 4
  %5 = call i32 (i8*, i32, i64, i8*, ...)* @__sprintf_chk(i8* %3, i32 0, i64 15, i8* getelementptr inbounds ([3 x i8]* @.str2, i32 0, i32 0), i32 %4)
  %6 = getelementptr inbounds [15 x i8]* %str, i32 0, i32 0
  %7 = load i8** %2, align 8
  %8 = call i8* @$concat(i8* %6, i8* %7)
  ret i8* %8
}"""
  }
}
