package toolc
package ast

import Trees._

object Printer {
  var i = 0;
  def apply(t: Tree): String = {
    t match {
      
      case Program(main: MainObject, classes: List[ClassDecl]) => 
      	apply(main) + classes.map(apply(_)).mkString
      	
      case MainObject(id: Identifier, stats: List[StatTree]) =>
        "object " + apply(id) + " {\n" + stats.map(apply(_)).mkString + "}\n\n"
        
      case ClassDecl(id: Identifier, parent: Option[Identifier], vars: List[VarDecl], methods: List[MethodDecl]) =>
        "class " + apply(id) + (parent match { case Some(id) => " extends " + apply(id) case None => ""}) +
        " {\n" + vars.map(apply(_)).mkString + "\n" + methods.map(apply(_)).mkString + "}\n\n"

        
      case VarDecl(tpe: TypeTree, id: Identifier) =>
        i = i+1;
        val s = indent(i)+"var "+apply(id)+": "+apply(tpe)+";\n"
        i = i-1
        s
        
      case MethodDecl(retType: TypeTree, id: Identifier, args: List[Formal],
          vars: List[VarDecl], stats: List[StatTree], retExpr: ExprTree) =>
        i = i+1
        val s = "\n" + indent(i)+"def "+apply(id)+"("+args.map(apply(_)).mkString(", ")+") : "+apply(retType)+" {\n"+
          vars.map(apply(_)).mkString + "\n" + stats.map(apply(_)).mkString + indent(i+1) + "return "+apply(retExpr)+";\n"+
        indent(i)+"}\n"
        i = i-1
        s
        
      case Formal(tpe: TypeTree, id: Identifier) =>
        apply(id)+": "+apply(tpe)
        
      case IntArrayType() => "Int[]"
      case IntType() => "Int"
      case BooleanType() => "Bool"
      case StringType() => "String"
        
      case Block(stats: List[StatTree]) =>
        " {\n" + stats.map(apply(_)).mkString + indent(i) + "}\n"
      
      case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) =>
        i = i+1
        val s = "\n" + indent(i) + "if(" + apply(expr) + ")" + apply(thn) +
        (els match {
          case Some(stmt) =>
          	indent(i) + "else "+apply(stmt)
          case None =>
            ""
        })
        i = i-1
        s
        
      case While(expr: ExprTree, stat: StatTree) =>
        i = i+1
        val s = "\n" + indent(i) + "while(" + apply(expr) + ")" + apply(stat)
        i = i-1
        s
        
      case Println(expr: ExprTree) =>
        i = i+1
        val s = indent(i) + "println("+apply(expr)+");\n"
        i = i-1
        s
        
      case Assign(id: Identifier, expr: ExprTree) =>
        i = i+1
        val s = indent(i) + apply(id) + " = " + apply(expr)+";\n"
        i = i-1
        s
        
      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) =>
        i = i+1
        val s = indent(i) + apply(id) + "[" + apply(index) + "] = " + apply(expr)+";\n"
        i = i-1
        s
        
        
      case And(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " && " + apply(rhs)
        
      case Or(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " || " + apply(rhs)
        
      case Plus(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " + " + apply(rhs)
        
      case Minus(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " - " + apply(rhs)
        
      case Times(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " * " + apply(rhs)
        
      case Div(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " / " + apply(rhs)
        
      case LessThan(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " < " + apply(rhs)
        
      case Equals(lhs: ExprTree, rhs: ExprTree) =>
        apply(lhs) + " == " + apply(rhs)
        
      case ArrayRead(arr: ExprTree, index: ExprTree) =>
        apply(arr) + "[" + apply(index) + "]"
        
      case ArrayLength(arr: ExprTree) =>
        apply(arr) + ".length"
        
      case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
        apply(obj) + "." + apply(meth) + "(" + args.map(apply(_)).mkString(",") +
        ")"
        
      case IntLit(value: Int) =>
        value.toString
        
      case StringLit(value: String) =>
        "\"" + value + "\""
        
      case True() =>
        "true"
        
      case False() =>
        "false"
        
      case Identifier(value: String) =>
       value
       
      case This() =>
        "this"
        
      case NewIntArray(size: ExprTree) =>
        "new Int[" + apply(size) + "]"
        
      case New(tpe: Identifier) =>
        "new " + apply(tpe) + "()"
        
      case Not(expr: ExprTree) =>
        "!" + apply(expr)
      	
      case _ => ""
      
      
    }
  }
  
  def indent(i: Int) : String = {
    var str = ""
    for(k <- 1 to i) {
      str = str+"    "
    }
    str
  }
}
