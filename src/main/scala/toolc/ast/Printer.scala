package toolc
package ast

import Trees._
import toolc.analyzer.Symbols

object Printer {
  var i = 0;
  def apply(t: Tree): String = {
    t match {
      
      case Program(main: MainObject, classes: List[ClassDecl]) => 
      	apply(main) + classes.map(apply(_)).mkString
      	
      case main: MainObject =>
        i = i + 1
        val s = "object " + apply(main.id) + " {\n" + 
        indent(i) + "def main() : Unit = {\n" +  
        main.stats.map(apply(_)).mkString + indent(i) + "}\n}\n\n"
        i = i -1
        s
        
      case c: ClassDecl =>
        "class " + apply(c.id) + (c.parent match { case Some(id) => " extends " + apply(id) case None => ""}) +
        " {\n" + c.vars.map(apply(_)).mkString + "\n" + c.methods.map(apply(_)).mkString + "}\n\n"

        
      case v: VarDecl =>
        i = i+1;
        val s = indent(i) + "var " + apply(v.id) + ": "+apply(v.tpe)+";\n"
        i = i-1
        s
        
      case m: MethodDecl =>
        i = i+1
        val s = "\n" + indent(i) + "def " + apply(m.id) + "("+m.args.map(apply(_)).mkString(", ")+") : "+apply(m.retType)+" = {\n"+
          m.vars.map(apply(_)).mkString + "\n" + m.stats.map(apply(_)).mkString + indent(i+1) + "return "+apply(m.retExpr)+";\n"+
        indent(i)+"}\n"
        i = i-1
        s
        
      case f: Formal =>
        apply(f.id) + ": "+apply(f.tpe)
        
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
        val s = indent(i) + apply(id) +  " = " + apply(expr)+";\n"
        i = i-1
        s
        
      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) =>
        i = i+1
        val s = indent(i) + id.value + "#" + id.getSymbol.id + "[" + apply(index) + "] = " + apply(expr)+";\n"
        i = i-1
        s
        
        
      case And(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " && " + apply(rhs) + ")"
        
      case Or(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " || " + apply(rhs) + ")"
        
      case Plus(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " + " + apply(rhs) + ")"
        
      case Minus(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " - " + apply(rhs) + ")"
        
      case Times(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " * " + apply(rhs) + ")"
        
      case Div(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " / " + apply(rhs) + ")"
        
      case LessThan(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " < " + apply(rhs) + ")"
        
      case Equals(lhs: ExprTree, rhs: ExprTree) =>
        "(" + apply(lhs) + " == " + apply(rhs) + ")"
        
      case ArrayRead(arr: ExprTree, index: ExprTree) =>
        apply(arr) + "[" + apply(index) + "]"
        
      case ArrayLength(arr: ExprTree) =>
        apply(arr) + ".length"
        
      case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
        apply(obj) + "." + meth.value + "#" + meth.getSymbol.id + "(" + args.map(apply(_)).mkString(",") +
        ")"
        
      case IntLit(value: Int) =>
        value.toString
        
      case StringLit(value: String) =>
        "\"" + value + "\""
        
      case True() =>
        "true"
        
      case False() =>
        "false"
        
      case id: Identifier =>
        id.value + "#" + id.getSymbol.id //+ id.getType
       
      case thiz: This =>
        "this" + "#" + thiz.getSymbol.id
        
      case NewIntArray(size: ExprTree) =>
        "new Int[" + apply(size) + "]"
        
      case New(tpe: Identifier) =>
        "new " + apply(tpe) + "()"
        
      case Not(expr: ExprTree) =>
        "!" + "(" + apply(expr) + ")"
      	
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
