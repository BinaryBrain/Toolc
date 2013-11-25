package toolc
package analyzer

import ast.Trees._
import Symbols._
import Types._
import utils._
import toolc.ast.Trees

object TypeChecking extends Pipeline[Program, Program] {
  /**
   * Typechecking does not produce a value, but has the side effect of
   * attaching types to trees and potentially outputting error messages.
   */
  def run(ctx: Context)(prog: Program): Program = {
    import ctx.reporter._

    def tcExpr(expr: ExprTree, expected: Type*): Type = {
      val tpe: Type = expr match {
        case And(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TBool)
          tcExpr(rhs, TBool)
          TBool
        case Or(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TBool)
          tcExpr(rhs, TBool)
          TBool
        case Plus(lhs: ExprTree, rhs: ExprTree) =>
          val tpe1 = tcExpr(lhs, TInt, TString)
          val tpe2 = tcExpr(rhs, TInt, TString)
          if (tpe1 == TString || tpe2 == TString) TString else TInt
        case Minus(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TInt)
          tcExpr(rhs, TInt)
          TInt
        case Times(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TInt)
          tcExpr(rhs, TInt)
          TInt
        case Div(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TInt)
          tcExpr(rhs, TInt)
          TInt
        case LessThan(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TInt)
          tcExpr(rhs, TInt)
          TBool
        case Equals(lhs: ExprTree, rhs: ExprTree) =>
          val tpe1 = tcExpr(lhs, TInt, TIntArray, TBool, TString, Types.anyObject)
          val tpe2 = tcExpr(lhs, TInt, TIntArray, TBool, TString, Types.anyObject)
          if (tpe1 == tpe2 || (tpe1.isSubTypeOf(Types.anyObject) && tpe2.isSubTypeOf(Types.anyObject)))
            TBool
          else
            TError // TODO Check Equals
        case ArrayRead(arr: ExprTree, index: ExprTree) =>
          tcExpr(arr, TIntArray)
          tcExpr(index, TInt)
          TInt
        case ArrayLength(arr: ExprTree) =>
          tcExpr(arr, TIntArray)
          TInt
        case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
          // tcExpr(obj, classe dans laquelle meth est dŽfinie)
          // tcExpr pour chaque argument doit tre de bon type (ou sous-type)
          // Retourner type de retour de meth
          TBool
        case IntLit(value: Int) =>
          TInt
        case StringLit(value: String) =>
          TString

        case True() =>
          TBool
        case False() =>
          TBool
        case id: Identifier =>
          id.getType

        case thiz: This =>
          thiz.getSymbol.getType

        case NewIntArray(size: ExprTree) =>
          tcExpr(size, TInt)
          TIntArray
        case New(tpe: Identifier) =>
          tpe.getType
        case Not(expr: ExprTree) =>
          tcExpr(expr, TBool)
          TBool
      }

      expr.setType(tpe)

      // Check result and return a valid type in case of error
      if (expected.isEmpty) {
        tpe
      } else {
        if (!expected.exists(e => tpe.isSubTypeOf(e))) {
          error("Type error: Expected: " + expected.toList.mkString(" or ") + ", found: " + tpe, expr)
          expected.head
        } else {
          tpe
        }
      }
    }

    def tcStat(stat: StatTree): Unit = {
      stat match {
        case Block(stats: List[StatTree]) =>
          stats.foreach(tcStat(_))
        case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) =>
          tcExpr(expr, TBool)
          tcStat(thn)
          if(els.isDefined) tcStat(els.get)
        case While(expr: ExprTree, stat: StatTree) =>
          tcExpr(expr, TBool)
          tcStat(stat)
        case Println(expr: ExprTree) =>
          tcExpr(expr, TInt, TString, TBool)
        case Assign(id: Identifier, expr: ExprTree) =>
          tcExpr(expr, id.getType)
        case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) =>
          tcExpr(id, TIntArray)
          tcExpr(index, TInt)
          tcExpr(expr, TInt)
      }
    }

    prog
  }
}
