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
          tcExpr(lhs, TBoolean)
          tcExpr(rhs, TBoolean)
          TBoolean
        case Or(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, TBoolean)
          tcExpr(rhs, TBoolean)
          TBoolean
        case Plus(lhs: ExprTree, rhs: ExprTree) =>
          val tpe1 = tcExpr(lhs, Tint, TString)
          val tpe2 = tcExpr(rhs, Tint, TString)
          if (tpe1 == TString || tpe2 == TString) TString else Tint
        case Minus(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, Tint)
          tcExpr(rhs, Tint)
          Tint
        case Times(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, Tint)
          tcExpr(rhs, Tint)
          Tint
        case Div(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, Tint)
          tcExpr(rhs, Tint)
          Tint
        case LessThan(lhs: ExprTree, rhs: ExprTree) =>
          tcExpr(lhs, Tint)
          tcExpr(rhs, Tint)
          TBoolean
        case Equals(lhs: ExprTree, rhs: ExprTree) =>
          val tpe1 = tcExpr(lhs, Tint, TintArray, TBoolean, TString, Types.anyObject)
          val tpe2 = tcExpr(lhs, Tint, TintArray, TBoolean, TString, Types.anyObject)
          if (tpe1 == tpe2 || (tpe1.isSubTypeOf(Types.anyObject) && tpe2.isSubTypeOf(Types.anyObject)))
            TBoolean
          else
            TError // TODO Check Equals
        case ArrayRead(arr: ExprTree, index: ExprTree) =>
          tcExpr(arr, TintArray)
          tcExpr(index, Tint)
          Tint
        case ArrayLength(arr: ExprTree) =>
          tcExpr(arr, TintArray)
          Tint
        case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
          // tcExpr(obj, classe dans laquelle meth est dŽfinie)
          // tcExpr pour chaque argument doit tre de bon type (ou sous-type)
          // Retourner type de retour de meth
          TBoolean
        case IntLit(value: Int) =>
          Tint
        case StringLit(value: String) =>
          TString

        case True() =>
          TBoolean
        case False() =>
          TBoolean
        case id: Identifier =>
          id.getType

        case thiz: This =>
          thiz.getSymbol.getType

        case NewIntArray(size: ExprTree) =>
          tcExpr(size, Tint)
          TintArray
        case New(tpe: Identifier) =>
          tpe.getType
        case Not(expr: ExprTree) =>
          tcExpr(expr, TBoolean)
          TBoolean
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
          tcExpr(expr, TBoolean)
          tcStat(thn)
          if(els.isDefined) tcStat(els.get)
        case While(expr: ExprTree, stat: StatTree) =>
          tcExpr(expr, TBoolean)
          tcStat(stat)
        case Println(expr: ExprTree) =>
          tcExpr(expr, Tint, TString, TBoolean)
        case Assign(id: Identifier, expr: ExprTree) =>
          tcExpr(expr, id.getType)
        case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) =>
          tcExpr(id, TintArray)
          tcExpr(index, Tint)
          tcExpr(expr, Tint)
      }
    }

    prog
  }
}
