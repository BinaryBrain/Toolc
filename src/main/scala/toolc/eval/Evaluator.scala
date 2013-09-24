package toolc
package eval

import ast.Trees._
import utils._

class Evaluator(ctx: Context, prog: Program) {
  import ctx.reporter._

  def eval() {
    // Initialize the context for the main method
    val ectx = new MainMethodContext

    // Evaluate each statement of the main method
    prog.main.stats.foreach(evalStatement(ectx, _))
  }

  def evalStatement(ectx: EvaluationContext, stmt: StatTree): Unit = stmt match {
    case Block(stats) => stats.foreach(evalStatement(ectx, _))
    case If(expr, thn, els) =>
      if (evalExpr(ectx, expr).asBool)
        evalStatement(ectx, thn)
      else {
        els match {
          case Some(ex) => evalStatement(ectx, ex)
          case None =>
        }
      }
    case While(expr, stat) => while (evalExpr(ectx, expr).asBool) evalStatement(ectx, stat)
    case Println(expr) => evalExpr(ectx, expr) match {
      case StringValue(s) => println(s)
      case IntValue(v) => println(v)
      case _ => 
    }
    case Assign(id, expr) => ectx.setVariable(id.value, evalExpr(ectx, expr))
    case ArrayAssign(id, index, expr) => ectx.getVariable(id.value).asArray.
    									setIndex(evalExpr(ectx, index).asInt, evalExpr(ectx, expr).asInt)
    case _ =>
      fatal("unnexpected statement", stmt)
  }

  def evalExpr(ectx: EvaluationContext, e: ExprTree): Value = e match {
    case IntLit(value) => IntValue(value)
    case StringLit(value) => StringValue(value)
    case True() => BoolValue(true)
    case False() => BoolValue(false)
    case And(lhs, rhs) => BoolValue(evalExpr(ectx, lhs).asBool && evalExpr(ectx, rhs).asBool)
    case Or(lhs, rhs) => BoolValue(evalExpr(ectx, lhs).asBool || evalExpr(ectx, rhs).asBool)
    case Plus(lhs, rhs) => 
      
      var res: Value = null
      val pair = (evalExpr(ectx, lhs), evalExpr(ectx, rhs)) match {
      case (IntValue(l), IntValue(r)) => res = IntValue(l + r)
      case (IntValue(l), StringValue(r)) => res = StringValue(l + r)
      case (StringValue(l), IntValue(r)) => res = StringValue(l + r)
      case (StringValue(l), StringValue(r)) => res = StringValue(l + r)
      case _ => 
    }
    	
      res

      
    case Minus(lhs, rhs) => IntValue(evalExpr(ectx, lhs).asInt - evalExpr(ectx, rhs).asInt)
    case Times(lhs, rhs) => IntValue(evalExpr(ectx, lhs).asInt * evalExpr(ectx, rhs).asInt)
    case Div(lhs, rhs) => IntValue(evalExpr(ectx, lhs).asInt / evalExpr(ectx, rhs).asInt)
    case LessThan(lhs, rhs) => BoolValue(evalExpr(ectx, lhs).asInt < evalExpr(ectx, rhs).asInt)
    case Not(expr) => BoolValue(!evalExpr(ectx, expr).asBool)
    case Equals(lhs, rhs) =>
      val lv = evalExpr(ectx, lhs)
      val rv = evalExpr(ectx, rhs)
      val res = (lv, rv) match {
        case (IntValue(l), IntValue(r)) => l == r
        case (BoolValue(l), BoolValue(r)) => l == r
        case (lr, rr) => lr eq rr
      }
      BoolValue(res)

    case ArrayRead(arr, index) => IntValue(evalExpr(ectx, arr).asArray.getIndex(evalExpr(ectx, index).asInt))
    case ArrayLength(arr) => IntValue(evalExpr(ectx, arr).asArray.size)
    
    case MethodCall(obj, meth, args) =>
      val objValue = evalExpr(ectx, obj).asObject
      val md = findMethod(objValue.cd, meth.value)
      val mcxt = new MethodContext(objValue)
      md.args.foreach(arg => mcxt.declareVariable(arg.id.value))
      val pairs = md.args.zip(args)
      pairs.foreach(pair => mcxt.setVariable(pair._1.id.value, evalExpr(ectx, pair._2)))
      md.vars.foreach(v => mcxt.declareVariable(v.id.value))
      md.stats.foreach(evalStatement(mcxt, _))
      evalExpr(mcxt, md.retExpr)
      
    case Identifier(name) => ectx.getVariable(name)
    case New(tpe) => // ObjectValue declare/setField
      val cd = findClass(tpe.value);
      var obj = new ObjectValue(cd)
      fieldsOfClass(cd).foreach(obj.declareField(_))
      obj
    case This() => ectx match {
      case mctx: MethodContext => mctx.obj
      case _ => fatal("You can't use this in main method")
    }
    case NewIntArray(size) => 
      val sizeInt = evalExpr(ectx, size).asInt
      new ArrayValue(new Array[Int](sizeInt), sizeInt)
  }

  // Define the scope of evaluation, with methods to access/declare/set local variables(or arguments)
  abstract class EvaluationContext {
    def getVariable(name: String): Value
    def setVariable(name: String, v: Value): Unit
    def declareVariable(name: String): Unit
  }

  // A Method context consists of the execution context within an object method.
  // getVariable can fallback to the fields of the current object
  class MethodContext(val obj: ObjectValue) extends EvaluationContext {
    var vars = Map[String, Option[Value]]()

    def getVariable(name: String): Value = {
      vars.get(name) match {
        case Some(ov) =>
          ov.getOrElse(fatal("Uninitialized variable '" + name + "'"))
        case _ =>
          obj.getField(name)
      }
    }

    def setVariable(name: String, v: Value) {
      if (vars contains name) {
        vars += name -> Some(v)
      } else {
        obj.setField(name, v)
      }
    }

    def declareVariable(name: String) {
      vars += name -> None
    }
  }

  // Special execution context for the main method, which is very limitted.
  class MainMethodContext extends EvaluationContext {
    def getVariable(name: String): Value = fatal("The main method contains no variable and/or field")
    def setVariable(name: String, v: Value): Unit = fatal("The main method contains no variable and/or field")
    def declareVariable(name: String): Unit = fatal("The main method contains no variable and/or field")
  }

  // Helper functions to query the current program
  def findMethod(cd: ClassDecl, name: String): MethodDecl = {
    cd.methods.find(_.id.value == name) match {
      case Some(v) => v
      case None =>
      	cd.parent match {
      	  case Some(p) => findMethod(findClass(p.value), name)
      	  case None => fatal("Unknow method");
      	}
    }
  }

  def findClass(name: String): ClassDecl = {
    prog.classes.find(_.id.value == name).getOrElse(fatal("Unknown class '" + name + "'"))
  }

  def fieldsOfClass(cl: ClassDecl): Set[String] = {
    cl.vars.map(_.id.value).toSet ++
      cl.parent.map(p => fieldsOfClass(findClass(p.value))).getOrElse(Set())
  }

  // Runtime evaluation values, with as* methods which act as typecasts for convenience.
  sealed abstract class Value {
    def asInt: Int = fatal("Unnexpected value, found " + this + " expected Int")
    def asString: String = fatal("Unnexpected value, found " + this + " expected String")
    def asBool: Boolean = fatal("Unnexpected value, found " + this + " expected Boolean")
    def asObject: ObjectValue = fatal("Unnexpected value, found " + this + " expected Object")
    def asArray: ArrayValue = fatal("Unnexpected value, found " + this + " expected Array")
  }

  case class ObjectValue(cd: ClassDecl) extends Value {
    var fields = Map[String, Option[Value]]()

    def setField(name: String, v: Value) {
      if (fields contains name) {
        fields += name -> Some(v)
      } else {
        fatal("Unknown field '" + name + "'")
      }
    }

    def getField(name: String) = {
      fields.get(name).flatten.getOrElse(fatal("Unknown field '" + name + "'"))
    }

    def declareField(name: String) {
      fields += name -> None
    }

    override def asObject = this
  }

  case class ArrayValue(var entries: Array[Int], val size: Int) extends Value {
    def setIndex(i: Int, v: Int) {
      if (i >= size || i < 0) {
        fatal("Index '" + i + "' out of bounds (0 .. " + size + ")")
      }
      entries(i) = v
    }

    def getIndex(i: Int) = {
      if (i >= size || i < 0) {
        fatal("Index '" + i + "' out of bounds (0 .. " + size + ")")
      }
      entries(i)
    }

    override def asArray = this
  }

  case class StringValue(var v: String) extends Value {
    override def asString = v
  }

  case class IntValue(var v: Int) extends Value {
    override def asInt = v
  }

  case class BoolValue(var v: Boolean) extends Value {
    override def asBool = v
  }
}

