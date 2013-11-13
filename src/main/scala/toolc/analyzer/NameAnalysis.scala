package toolc
package analyzer

import utils._
import ast.Trees._
import Symbols._

object NameAnalysis extends Pipeline[Program, Program] {

  def run(ctx: Context)(prog: Program): Program = {
    import ctx.reporter._
    // Step 1: Collect symbols in declarations
    // Step 2: Attach symbols to identifiers (except method calls) in method bodies
    // (Step 3:) Print tree with symbol ids for debugging
    // Make sure you check for all constraints

    val gs: GlobalScope = new GlobalScope()
    prog.main.setSymbol(new ClassSymbol(prog.main.id.value))
    prog.main.id.setSymbol(prog.main.getSymbol)
    gs.mainClass = prog.main.getSymbol

    prog.classes.foreach { c: ClassDecl =>
      val cs: ClassSymbol = new ClassSymbol(c.id.value)
      c.setSymbol(cs)
      c.id.setSymbol(cs)
      gs.classes = gs.classes + ((c.id.value, cs)) // TODO Check if the key is correct

      c.vars.foreach { v: VarDecl =>
        val vs: VariableSymbol = new VariableSymbol(v.id.value)
        v.setSymbol(vs)
        v.id.setSymbol(vs)
        cs.members = cs.members + ((v.id.value, vs))
      }

      c.methods.foreach { m: MethodDecl =>
        val ms: MethodSymbol = new MethodSymbol(m.id.value, cs)
        m.setSymbol(ms)
        m.id.setSymbol(ms)
        cs.methods = cs.methods + ((m.id.value, ms))

        m.args.foreach { a: Formal =>
          val as: VariableSymbol = new VariableSymbol(a.id.value)
          a.setSymbol(as)
          a.id.setSymbol(as)
          ms.argList = ms.argList ::: List(as)
          ms.params = ms.params + ((a.id.value, as))
        }

        m.vars.foreach { v: VarDecl =>
          val vs: VariableSymbol = new VariableSymbol(v.id.value)
          v.setSymbol(vs)
          v.id.setSymbol(vs)
          ms.members = ms.members + ((v.id.value, vs))
        }

        //TODO champ overridden in ms
      }
    }

    prog.main.stats.foreach { s: StatTree =>
      nameBinding(s, prog.main.getSymbol)
    }

    prog.classes.foreach { c: ClassDecl =>
      val cs: ClassSymbol = c.getSymbol
      
      c.parent match{
        case Some(p) => p.setSymbol(gs.lookupClass(p.value).get)
        case _ =>
      } 
      
      c.vars.foreach { v: VarDecl =>
        v.tpe match {
          case id: Identifier => id.setSymbol(gs.lookupClass(id.value).get)
          case _ =>
        }
      }
      c.methods.foreach { m: MethodDecl =>
        val ms: MethodSymbol = m.getSymbol
        m.args.foreach { v: Formal =>
          v.tpe match {
            case id: Identifier => id.setSymbol(gs.lookupClass(id.value).get)
            case _ =>
          }
        }
        m.vars.foreach { v: VarDecl =>
          v.tpe match {
            case id: Identifier => id.setSymbol(gs.lookupClass(id.value).get)
            case _ =>
          }
        }

        m.retType match {
          case id: Identifier => id.setSymbol(gs.lookupClass(id.value).get)
          case _ =>
        }
        m.stats.foreach(nameBinding(_, ms))
        nameBindingExpr(m.retExpr, ms)
      }
    }

    def nameBinding(st: StatTree, s: Symbol): Unit = st match {
      case Block(stats: List[StatTree]) => stats.foreach(nameBinding(_, s))
      case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) =>
        nameBindingExpr(expr, s)
        nameBinding(thn, s)
        if (!els.isEmpty) nameBinding(els.get, s)
      case While(expr: ExprTree, stat: StatTree) =>
        nameBindingExpr(expr, s)
        nameBinding(stat, s)
      case Println(expr: ExprTree) => nameBindingExpr(expr, s)
      case Assign(id: Identifier, expr: ExprTree) =>
        nameBindingExpr(id, s)
        nameBindingExpr(expr, s)
      case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) =>
        nameBindingExpr(id, s)
        nameBindingExpr(index, s)
        nameBindingExpr(expr, s)
    }

    def nameBindingExpr(e: ExprTree, s: Symbol): Unit = e match {
      case And(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case Or(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case Plus(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case Minus(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case Times(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case Div(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case LessThan(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case Equals(lhs: ExprTree, rhs: ExprTree) =>
        nameBindingExpr(lhs, s); nameBindingExpr(rhs, s)
      case ArrayRead(arr: ExprTree, index: ExprTree) =>
        nameBindingExpr(arr, s); nameBindingExpr(index, s)
      case ArrayLength(arr: ExprTree) => nameBindingExpr(arr, s)
      case MethodCall(obj: ExprTree, meth: Identifier, args: List[ExprTree]) =>
        nameBindingExpr(obj, s); /*nameBindingExpr(meth, s);*/ args.foreach(nameBindingExpr(_, s))
      case NewIntArray(size: ExprTree) =>
        nameBindingExpr(size, s)
      case Not(expr: ExprTree) =>
        nameBindingExpr(expr, s)
      case New(tpe: Identifier) => tpe.setSymbol(gs.lookupClass(tpe.value).get) // TODO Error
      case thiz: This => lookUpThis(thiz, s)
      case id: Identifier => lookUpId(id, s)
      case _ =>
    }

    def lookUpVar(id: Identifier, s: Symbol): Option[Symbol] = s match {
      case m: MethodSymbol => m.lookupVar(id.value)
      case c: ClassSymbol => c.lookupVar(id.value)
      case _ => sys.error("Look up Var in bad scope"); None
    }

    def lookUpId(id: Identifier, s: Symbol): Unit = {
      lookUpVar(id, s) match {
        case Some(_) => id.setSymbol(lookUpVar(id, s).get)
        case None => fatal("undefined var " + id.value + " at " + id.position)
      }
    }

    def lookUpThis(thiz: This, s: Symbol): Unit = s match {
      case m: MethodSymbol => thiz.setSymbol(m.classSymbol)
      case c: ClassSymbol => thiz.setSymbol(c)
      case _ =>
    }

    prog
  }
}
