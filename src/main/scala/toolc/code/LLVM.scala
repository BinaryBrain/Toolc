package toolc.code

object LLVM {
  
  
  class Class {
    var size = 0
    var tpe: String = ""
    var methods: List[String] = List()
    var argsType = List[List[String]]()
    var fields: List[String] = List()
    override def toString() = "Methods: " + methods + " Fields: " + fields
  }

  trait Instruction {
    def asAssembly(): String = "Undefined Instruction cannot produce code!"
    def align(tpe: String) = if (tpe == "i32" || tpe == "i1") 4 else 8
  }
  
  case class triple() extends Instruction {
    
    def getArchTypeName: String = {
	  
	  val arch: String = System.getProperty("os.arch") match {
	  	case "x86" | "i386" | "i686" => "i386"
	  	case "x86_64" | "amd64" => "x86_64"
		case "ppc" => "ppc"
		case _ => "x86_64"
	  }
	  
	  arch
    }
    /*
    def getOSTypeName: String = {
      val osName = System.getProperty("os.name")
	  val win = osName.substring(0, 7)
	  val mac = osName.substring(0, 3)
	  
	  val os: String = osName match {
	    case WinPattern(w) => "win32"
		case MacPattern(m) => "macosx"
		case "Linux" => "linux"
		case "FreeBSD" => "freebsd"
		case _ => "linux"
	  }
	  
	  os
    }
    */
    def getOSTypeName: String = {
      val osName: String = System.getProperty("os.name");
	  val WinPattern = "(Windows.*)".r
	  val MacPattern = "(Mac.*)".r
	  val os: String = osName match {
	    case WinPattern(w) => "win32"
		case MacPattern(m) => "macosx"
		case "Linux" => "linux"
		case "FreeBSD" => "freebsd"
		case _ => "poney"
	  }
	  
	  os
    }
    
    def getVendorTypeName: String = {
      val osName: String = System.getProperty("os.name");
	  val WinPattern = "(Windows.*)".r
	  val MacPattern = "(Mac.*)".r
	  val vendor: String = osName match {
		case MacPattern(m) => "apple"
		case _ => "pc"
	  }
	  
	  vendor
    }
    
    override def asAssembly() = {
      getArchTypeName + '-' + getVendorTypeName + '-' + getOSTypeName
  	}
  }
  
  case class alloca(reg: String, tpe: String) extends Instruction {
    override def asAssembly() =
      reg + " = alloca " + tpe + ", align " + align(tpe)
  }
  
  case class store(elem: String, dest: String, tpe: String) extends Instruction {
    override def asAssembly() =
     "store " + tpe + " " + elem + ", " + tpe + "* " + dest + ", align " + align(tpe) 
  }
  
  case class load(reg: String, ptr: String, tpe: String) extends Instruction {
    override def asAssembly() =
     reg + " = load " + tpe + "* " + ptr + ", align " + align(tpe)  
  }
  
  case class call(reg: String, tpe: String, meth: String, args: String) extends Instruction {
    override def asAssembly() =
     reg + " = call " + tpe + " " + meth + "(" + args + ")"  
  }
  
  case class zext(reg: String, elem: String, tpe: String, toTpe: String) extends Instruction {
    override def asAssembly() =
     reg + " = zext " + tpe + " " + elem + " to " + toTpe 
  }
  
  case class branch(reg: String, trueLabel: String, falseLabel: String) extends Instruction {
    override def asAssembly() =
     "br i1 " + reg + ", label " + trueLabel + ", label " + falseLabel 
  }
  
  case class jump(label: String) extends Instruction {
    override def asAssembly() =
     "br label " + label 
  }
  
  case class label(label: String) extends Instruction {
    override def asAssembly() =
     "\n; <label>: " + label
  }
  
  case class add(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = add nsw i32 " + l + ", " + r
  }
  
  case class sub(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = sub nsw i32 " + l + ", " + r
  }
  
  case class and(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = and i1 " + l + ", " + r
  }
  
  case class or(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = or i1 " + l + ", " + r
  }
  
  case class xor(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = xor i1 " + l + ", " + r
  }
  
  case class mul(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = mul nsw i32 " + l + ", " + r
  }
  
  case class sdiv(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = sdiv i32 " + l + ", " + r
  }
  
  case class lessThan(reg: String, l: String, r: String) extends Instruction {
    override def asAssembly() =
     reg + " = icmp slt i32 " + l + ", " + r
  }
  
  case class equal(reg: String, l: String, r: String, tpe: String) extends Instruction {
    override def asAssembly() =
     reg + " = icmp eq  " + tpe + " " + l + ", " + r
  }
  
  case class getelementptr(reg: String, tpe: String, elem: String, index: Int) extends Instruction {
    override def asAssembly() =
     reg + " = getelementptr inbounds " + tpe + " " + elem + ", i32 0, i32 " + index
  }
  
  case class bitcast(reg: String, tpe: String, elem: String, toTpe: String) extends Instruction {
    override def asAssembly() =
     reg + " = bitcast " + tpe + " " + elem + " to " + toTpe
  }
  
  case class ret(tpe: String, elem: String) extends Instruction {
    override def asAssembly() =
     "ret " + tpe + " " + elem
  }
  
  case class phi(reg:String, reg1: String, pred1: String, reg2: String, pred2: String) extends Instruction {
    override def asAssembly() =
     reg + " = phi i1 [ " + reg1 + ", " + pred1 + " ], [ " + reg2 + ", " + pred2 + " ]"
  }

}