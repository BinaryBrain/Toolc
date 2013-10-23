package toolc
package ast

import Trees._

object Printer {
  def apply(t: Tree): String = {
    t match {
      
      case Program(main: MainObject, classes: List[ClassDecl]) => 
      	apply(main) + classes.map(cl => apply(cl)).mkString
      	
      case _ => ""
      
      
    }
  }
}
