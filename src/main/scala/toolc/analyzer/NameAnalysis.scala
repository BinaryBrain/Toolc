package toolc
package analyzer

import utils._
import ast.Trees._
import Symbols._
import scala.collection.mutable.LinkedList
import toolc.ast.Trees

object NameAnalysis extends Pipeline[Program, Program] {

  def run(ctx: Context)(prog: Program): Program = {
    import ctx.reporter._
    // Step 1: Collect symbols in declarations
    // Step 2: Attach symbols to identifiers (except method calls) in method bodies
    // (Step 3:) Print tree with symbol ids for debugging
    // Make sure you check for all constraints

    var errors: List[String] = List()

    val gs: GlobalScope = new GlobalScope()

    //========================================================
    // COLLECT DEFINITIONS
    //========================================================

    //Collect main class
    prog.main.setSymbol(new ClassSymbol(prog.main.id.value))
    prog.main.id.setSymbol(prog.main.getSymbol)
    gs.mainClass = prog.main.getSymbol

    // For each class
    prog.classes.foreach { c: ClassDecl =>

      // Collect the class definition
      val cs: ClassSymbol = new ClassSymbol(c.id.value)
      c.setSymbol(cs)
      cs.setPos(c)
      c.id.setSymbol(cs)

      // Check if class already exist
      gs.lookupClass(c.id.value) match {
        case None => gs.classes = gs.classes + ((c.id.value, cs)) // TODO Check if the key is correct
        case _ => errorFound("illegal attempt to override class '" + c.id.value + "' at " + c.id.position)
      }

      // Collect fields
      c.vars.foreach { v: VarDecl =>
        val vs: VariableSymbol = new VariableSymbol(v.id.value)
        v.setSymbol(vs)
        vs.setPos(v)
        v.id.setSymbol(vs)

        // Check if field already exist
        cs.lookupVar(v.id.value) match {
          case None => cs.members = cs.members + ((v.id.value, vs))
          case _ => errorFound("illegal attempt to override field '" + v.id.value + "' at " + v.id.position)
        }
      }

      // Collect methods
      c.methods.foreach { m: MethodDecl =>
        val ms: MethodSymbol = new MethodSymbol(m.id.value, cs)
        ms.returnType = m.retType
        m.setSymbol(ms)
        ms.setPos(m)
        m.id.setSymbol(ms)

        // Check if method already exist
        cs.lookupMethod(m.id.value) match {
          case None => cs.methods = cs.methods + ((m.id.value, ms))
          case _ => errorFound("illegal attempt to override method '" + m.id.value + "' at " + m.id.position)
        }

        // Collect method args
        m.args.foreach { a: Formal =>
          val as: VariableSymbol = new VariableSymbol(a.id.value)
          a.setSymbol(as)
          as.setPos(a)
          a.id.setSymbol(as)

          // Check if args already exist
          ms.lookupVar(a.id.value) match {
            case None =>
            case _ => ms.classSymbol.lookupVar(a.id.value) match {
              case None => errorFound("illegal attempt to override argument '" + a.id.value + "' at " + a.id.position)
              case _ =>
            }
          }

          ms.argList = ms.argList ::: List(as)
          ms.params = ms.params + ((a.id.value, as))
        }

        // Collect local variable
        m.vars.foreach { v: VarDecl =>
          val vs: VariableSymbol = new VariableSymbol(v.id.value)
          v.setSymbol(vs)
          vs.setPos(v)
          v.id.setSymbol(vs)

          // Check if variable already exist
          ms.lookupVar(v.id.value) match {
            case None =>
            case _ => ms.params.get(v.id.value) match {
              case None => ms.members.get(v.id.value) match {
                case None =>
                case _ => errorFound("illegal attempt to override local variable '" + v.id.value + "' at " + v.id.position)
              }
              case _ => errorFound("illegal attempt to override argument '" + v.id.value + "' at " + v.id.position)
            }
          }

          ms.members = ms.members + ((v.id.value, vs))
        }
      }
    }

    //========================================================
    // NAME BINDING
    //========================================================

    prog.main.stats.foreach { s: StatTree =>
      nameBinding(s, prog.main.getSymbol)
    }

    //========================================================
    // SET PARENT
    //========================================================

    prog.classes.foreach { c: ClassDecl =>
      val cs: ClassSymbol = c.getSymbol

      cs.parent = c.parent match {
        case None => None
        case Some(id) => gs.lookupClass(id.value)
      }
    }

    //========================================================
    // CHECK INHERITANCE CYCLE
    //========================================================

    prog.classes.foreach { c: ClassDecl =>
      var accu = List(c.getSymbol)
      var continue = true
      while (accu.head.parent.isDefined && continue) {
        if (accu.contains(accu.head.parent.get)) {
          errorFound("cycle in inheritance hierarchy of class '" + c.id.value + "' at " + c.id.position)
          continue = false
        }
        accu = accu.head.parent.get :: accu
      }
    }

    //========================================================
    // FIRST GUARD
    //========================================================

    // There was some errors
    if (!errors.isEmpty) {
      errors.foreach(error(_))
      fatal("Errors in name analysis phase after collecting definitions")
    }


    prog.classes.foreach { c: ClassDecl =>
      val cs: ClassSymbol = c.getSymbol

      c.parent match {
        case Some(id) => gs.lookupClass(id.value) match {
          case None => errorFound("undefined class '" + id.value + "' at " + id.position)
          case _ => id.setSymbol(gs.lookupClass(id.value).get)
        }

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
            case id: Identifier => gs.lookupClass(id.value) match {
              case None => errorFound("undefined class '" + id.value + "' at " + id.position)
              case _ => id.setSymbol(gs.lookupClass(id.value).get)
            }
            case _ =>
          }
        }

        m.retType match {
          case id: Identifier => gs.lookupClass(id.value) match {
            case None => errorFound("undefined class '" + id.value + "' at " + id.position)
            case _ => id.setSymbol(gs.lookupClass(id.value).get)
          }
          case _ =>
        }
        m.stats.foreach(nameBinding(_, ms))
        nameBindingExpr(m.retExpr, ms)
      }
    }
    
    //========================================================
    // CHECK OVERLOADING/OVERRIDING
    //========================================================

    for ((_, cs) <- gs.classes) {
      for ((_, vs) <- cs.members) {
        var parentClass = cs.parent
        while (parentClass.isDefined) {
          var vaar = parentClass.get.lookupVar(vs.name)
          if (vaar.isDefined) {
            errorFound("illegal attempt to override field " + vs.name + " at " + vs.position)
          }
          parentClass = parentClass.get.parent
        }
      }

      for ((_, ms) <- cs.methods) {
        var parentClass = cs.parent
        while (parentClass.isDefined) {
          var meth = parentClass.get.lookupMethod(ms.name)
          if (meth.isDefined) {

            // Check same number of arguments
            if (meth.get.argList.size != ms.argList.size) {
              errorFound("illegal attempt to overload method (number of arguments do not match) " + ms.name + " at " + ms.position)
            }

            // Check exact same argument's types
            val argListZip = ms.argList.zip(meth.get.argList)
            argListZip.foreach {
              case (arg, argOverriden) =>
                if (arg.getType != argOverriden.getType) {
                  errorFound("illegal attempt to overload method (Wrong argument type) " + ms.name + " at " + arg.position)
                }
            }

            // Check exact same return type
            if (ms.returnType.getType != meth.get.returnType.getType) {
              errorFound("illegal attempt to overload method (Wrong return type) " + ms.name + " at " + ms.position)
            }

          }
          parentClass = parentClass.get.parent
        }
      }
    }

    //========================================================
    // SETTING TYPES
    //========================================================

    // Set types of classSymbols
    gs.mainClass.setType(new Types.TObject(gs.mainClass))
    gs.classes.foreach {
      case (_, cs) =>
        cs.setType(new Types.TObject(cs))
    }

    prog.classes.foreach { c: ClassDecl =>

      // Set types of fields
      c.vars.foreach { v: VarDecl =>
        v.getSymbol.setType(v.tpe.getType)
      }

      c.methods.foreach { m: MethodDecl =>
        
        m.getSymbol.setType(m.retType.getType)

        // Set types of arguments
        m.args.foreach { f: Formal =>
          f.getSymbol.setType(f.tpe.getType)
        }

        // Set types of local variables
        m.vars.foreach { v: VarDecl =>
          v.getSymbol.setType(v.tpe.getType)
        }
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
      case New(tpe: Identifier) => gs.lookupClass(tpe.value) match {
        case None => errorFound("undefined class '" + tpe.value + "' at " + tpe.position)
        case _ => tpe.setSymbol(gs.lookupClass(tpe.value).get)
      }
      case thiz: This => lookUpThis(thiz, s)
      case id: Identifier => lookUpId(id, s)
      case _ =>
    }

    def lookUpVar(id: Identifier, s: Symbol): Option[VariableSymbol] = s match {
      case m: MethodSymbol => m.lookupVar(id.value)
      case c: ClassSymbol => c.lookupVar(id.value)
      case _ => sys.error("Look up Var in bad scope"); None
    }

    def lookUpId(id: Identifier, s: Symbol): Unit = {
      lookUpVar(id, s) match {
        case Some(_) =>
          id.setSymbol(lookUpVar(id, s).get)
          lookUpVar(id, s).get.used = true

        case None => s match {
          case ms: MethodSymbol => ms.classSymbol.parent match {
            case None => errorFound("undefined var '" + id.value + "' at " + id.position)
            case Some(ps) => lookUpId(id, ps)
          }
          case cs: ClassSymbol => {
            cs.parent match {
              case None => errorFound("undefined var '" + id.value + "' at " + id.position)
              case Some(ps) => lookUpId(id, ps)
            }
          }
          case _ => errorFound("undefined var '" + id.value + "' at " + id.position)
        }
      }
    }

    def lookUpThis(thiz: This, s: Symbol): Unit = s match {
      case m: MethodSymbol => thiz.setSymbol(m.classSymbol)
      case c: ClassSymbol => thiz.setSymbol(c)
      case _ =>
    }

    def errorFound(errMsg: String): Unit = {
      errors = errors ::: List(errMsg)
    }

    // Output warnings about unused variable/field
    prog.classes.foreach { c: ClassDecl =>
      val cs: ClassSymbol = c.getSymbol

      for ((name, vs) <- cs.members) {
        if (!vs.used) {
          warning("Unused field " + name + " in class " + cs.name, vs)
        }
      }

      for ((methodName, ms) <- cs.methods) {

        for ((argName, vs) <- ms.params) {
          if (!vs.used) {
            warning("Unused argument " + argName + " in method " + ms.name + " in class " + cs.name, vs)
          }
        }

        for ((varName, vs) <- ms.members) {
          if (!vs.used) {
            warning("Unused local variable " + varName + " in method " + ms.name + " in class " + cs.name, vs)
          }
        }

      }
    }

    // There was some errors
    if (!errors.isEmpty) {
      errors.foreach(error(_))
      fatal("Errors in name analysis phase after checking uses")
    }

    prog
  }
}
