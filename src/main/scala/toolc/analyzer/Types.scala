package toolc
package analyzer

import Symbols._

object Types {
  trait Typed {
    self =>

    private var _tpe: Type = TUntyped

    def setType(tpe: Type): self.type = { _tpe = tpe; this }
    def getType: Type = _tpe
  }

  sealed abstract class Type {
    def isSubTypeOf(tpe: Type): Boolean
  }

  case object TError extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = true
    override def toString = "[error]"
  }

  case object TUntyped extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = false
    override def toString = "[untyped]"
  }

  case object TInt extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = tpe match {
      case TInt => true
      case _ => false
    }
    override def toString = "Int"
  }
  
  case object TIntArray extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = tpe match {
      case TIntArray => true
      case _ => false
    }
    override def toString = "Int[]"
  }
  
  case object TBool extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = tpe match {
      case TBool => true
      case _ => false
    }
    override def toString = "Bool"
  }
  
  case object TString extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = tpe match {
      case TString => true
      case _ => false
    }
    override def toString = "String"
  }

  case class TObject(classSymbol: ClassSymbol) extends Type {
    override def isSubTypeOf(tpe: Type): Boolean = tpe match {
      case TObject(cs: ClassSymbol) =>
        // TClass[this] <: TClass[Object]
        if(cs == anyObject.classSymbol) true
        // TClass[this] <: TClass[this]
        else if(cs == this.classSymbol) true
        //  TClass[B] <: TClass[A] and TClass[this] <: TClass[B] implies TClass[this] <: TClass[A]
        else {
          this.classSymbol.parent match {
            case None => false
            case Some(p) => p.getType.isSubTypeOf(cs.getType)
          } 
        }
      case _ => false
    }
    override def toString = classSymbol.name
  }

  // special object to implement the fact that all objects are its subclasses
  val anyObject = TObject(new ClassSymbol("Object"))
}
