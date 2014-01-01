package toolc
package code

import ast.Trees._
import analyzer.Symbols._
import analyzer.Types._
import utils._

object CodeGenerationLLVM extends Pipeline[Program, Unit] {

  var lastRegUsed = 0;
  var strConstants: List[String] = List("@.str = private unnamed_addr constant [4 x i8] c\"%s\\0A\\00\"");

  def run(ctx: Context)(prog: Program): Unit = {
    import ctx.reporter._;

    // generate assembly
    val headers = generateHeaders(ctx.file.getName());
    val classes = prog.classes.map(generateClass(_))
    val main = generateMainMethod(prog);
    
    // Print the assembly
    println(headers)
    strConstants.foreach(println)
    println()
    classes.foreach(println)
    println(main)
    val declarations = generateDeclarations()
    println(declarations)
  }

  def compileStat(stat: StatTree): String = {
    stat match {

      case Block(stats: List[StatTree]) =>
        stats.foldLeft("")((acc, stat) => acc + compileStat(stat))

      case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) => "Not Impl"
      case While(expr: ExprTree, stat: StatTree) => "Not Impl"
      case Println(expr: ExprTree) =>
        var s = compileExpr(expr)
        s = s +
          freshReg + " = call i32 (i8*, ...)* @printf(i8* getelementptr" +
          " inbounds ([4 x i8]* @.str, i32 0, i32 0), i8* " +
          oldReg + ")\n"
        return s

      case Assign(id: Identifier, expr: ExprTree) => "Not Impl"
      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) => "Not Impl"
    }
  }

  def compileExpr(expr: ExprTree): String = expr match {
    case And(lhs: ExprTree, rhs: ExprTree) => ""
    case Or(lhs: ExprTree, rhs: ExprTree) => ""
    case Plus(lhs: ExprTree, rhs: ExprTree) => ""
    case Minus(lhs: ExprTree, rhs: ExprTree) => ""
    case Times(lhs: ExprTree, rhs: ExprTree) => ""
    case Div(lhs: ExprTree, rhs: ExprTree) => ""
    case LessThan(lhs: ExprTree, rhs: ExprTree) => ""
    case Equals(lhs: ExprTree, rhs: ExprTree) => ""
    case ArrayRead(arr: ExprTree, index: ExprTree) => ""
    case ArrayLength(arr: ExprTree) => ""
    case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) => ""
    case IntLit(value: Int) => ""

    case StringLit(value: String) =>
      addStrConstant(value)
      freshReg + " = alloca i8*, align 8\n" +
        "store i8* getelementptr inbounds ([" + (value.length() + 1) + " x i8]* " +
        "@.str" + (strConstants.size - 1) + ", i32 0, i32 0), i8** " + lastReg + ", align 8\n" +
        freshReg + " = load i8** " + oldReg + ", align 8\n"

    case True() => ""
    case False() => ""
    case Identifier(value: String) => ""
    case This() => ""
    case NewIntArray(size: ExprTree) => ""
    case New(tpe: Identifier) => ""
    case Not(expr: ExprTree) => ""
  }
  
  
  
  def generateClass(cl: ClassDecl): String = {
    var s: String = ""
    val className = cl.id.value
    
    // struct for the class with fields and a vtable
    s = s +
    	"%struct." + className.toUpperCase() + " = type { %struct." +
    	className.toUpperCase() + "_VTABLE* }\n" // TODO add fields
    	
    // struct for the vtable
    s = s +
    	"%struct." + className.toUpperCase() + "_VTABLE = type { " +
    	cl.methods.foldLeft("")((acc, m) => acc + methodSignature(cl, m)) +
    	"}\n"
    	
   // global vtable
   s = s +
   	   "@" + className.toLowerCase() + "_vtable = global %struct." +
   	   className.toUpperCase() + "_VTABLE { " +	
   	   cl.methods.foldLeft("")((acc, m) => acc + methodSignatureWithName(cl, m)) +
   	   "}, align 8\n"
    	
    return s
  }
  
  
  def methodSignature(cl: ClassDecl, m: MethodDecl): String = {
    typeOf(m.retType) + " (" +typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* "
  }
  
  def methodSignatureWithName(cl: ClassDecl, m: MethodDecl): String = {
    typeOf(m.retType) + " (" +typeOf(cl.id) + ", " + m.args.map(typeOf(_)).mkString(", ") + ")* " +
    		"@" + m.id.value + " "
  }
  
  def typeOf(t: TypeTree): String = t match {
    case IntType() => "i32"
    case Identifier(id) => "%struct." + id.toUpperCase() + "*"
    case _  => "Not yet implemented"
  }
  
  def typeOf(f: Formal): String = typeOf(f.tpe)
  
  def generateMethod(cl: ClassDecl, m: MethodDecl): String = {
    return ""
  }

  def generateMainMethod(prog: Program): String = {
    "define i32 @main() nounwind ssp {\n" +
    prog.main.stats.foldLeft("")((acc, stat) => acc + compileStat(stat)) +
    "ret i32 0\n" +
    "}\n"
  }

  def generateHeaders(sourceName: String): String = {
    var headers: String = ""
    headers = "; ModuleID = '" + sourceName + "'\n" +
      "target datalayout = " +
      "\"e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:" +
      "64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0" +
      ":64-s0:64:64-f80:128:128-n8:16:32:64\"\n" +
      "target triple = \"x86_64-apple-macosx10.7.4\"\n" //TODO Change OS
    return headers
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
