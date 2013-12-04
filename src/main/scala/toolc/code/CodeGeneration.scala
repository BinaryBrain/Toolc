package toolc
package code

import ast.Trees._
import analyzer.Symbols._
import analyzer.Types._
import cafebabe._
import AbstractByteCodes.{ New => _, _ }
import ByteCodes._
import utils._
import scala.collection.mutable.Map
import analyzer.Types._
import toolc.analyzer.Types

object CodeGeneration extends Pipeline[Program, Unit] {
  def PACKAGE_NAME = ""
  var slotFor: Map[Int, Int] = Map()
  
  def run(ctx: Context)(prog: Program): Unit = {
    import ctx.reporter._

    /** Writes the proper .class file in a given directory. An empty string for dir is equivalent to "./". */
    def generateClassFile(sourceName: String, ct: ClassDecl, dir: String): Unit = {
      // TODO: Create code handler, save to files ...

      val classFile = new ClassFile(sourceName, if (ct.parent.isDefined) Some(ct.parent.get.value) else None)
      classFile.setSourceFile(sourceName + ".tool");

      ct.vars.foreach { field: VarDecl =>
        classFile.addField(toByteCodeType(field.tpe), field.id.value);
      }

      ct.methods.foreach { method: MethodDecl =>
        val ch: CodeHandler = classFile.addMethod(toByteCodeType(method.retType), method.id.value, method.args.map { arg: Formal =>
          toByteCodeType(arg.tpe)
        }).codeHandler

        generateMethodCode(ch, method)
      }

      classFile.writeToFile(dir + sourceName + ".class");
    }

    def toByteCodeType(tpe: TypeTree): String = {
      tpe match {
        case i: IntType => return "I"
        case i: BooleanType => return "Z"
        case i: IntArrayType => return "[I"
        case i: StringType => return "Ljava/lang/String;"
        case Identifier(value: String) => return "L" + PACKAGE_NAME + "/" + value
      }
    }

    // a mapping from variable symbols to positions in the local variables
    // of the stack frame

    def generateMethodCode(ch: CodeHandler, mt: MethodDecl): Unit = {
      val methSym = mt.getSymbol
      // TODO: Emit code

      slotFor.clear()
      mt.args.foreach { arg: Formal =>
        slotFor.put(arg.getSymbol.id, ch.getFreshVar)
      }
      mt.vars.foreach { v: VarDecl =>
        slotFor.put(v.getSymbol.id, ch.getFreshVar)
      }
      
       (mt.stats.map(compileStat(_, ch)) ::: List(compileExpr(mt.retExpr, ch)))
    		   .foldLeft(ch)((ch, bcg) => ch << bcg)
      
    }

    def generateMainMethodCode(ch: CodeHandler, stmts: List[StatTree], cname: String): Unit = {

      // TODO: Emit code
      ch.freeze
    }

    def compileStat(stat: StatTree, ch: CodeHandler): AbstractByteCodeGenerator = {
      (ch: CodeHandler) =>
        {
          stat match {

            case Block(stats: List[StatTree]) =>
              ch

            case If(expr: ExprTree, thn: StatTree, els: Option[StatTree]) =>
              val afterLabel: String = ch.getFreshLabel("after")

              if (els.isDefined) {
                val elseLabel: String = ch.getFreshLabel("else")
                ch <<
                  compileExpr(expr, ch) <<
                  IfEq(elseLabel) <<
                  compileStat(thn, ch) <<
                  Goto(afterLabel) <<
                  Label(elseLabel) <<
                  compileStat(els.get, ch) <<
                  Label(afterLabel)
              } else {
                ch <<
                  compileExpr(expr, ch) <<
                  IfEq(afterLabel) <<
                  compileStat(thn, ch) <<
                  Label(afterLabel)
              }

            case While(expr: ExprTree, stat: StatTree) =>
              val whileLabel = ch.getFreshLabel("while")
              val afterLabel = ch.getFreshLabel("after")

              ch <<
                Label(whileLabel) <<
                compileExpr(expr, ch) <<
                IfEq(afterLabel) <<
                compileStat(stat, ch) <<
                Goto(whileLabel) <<
                Label(afterLabel)

            case Println(expr: ExprTree) =>
              ch <<
                GetStatic("java/lang/System", "out", "Ljava/io/PrintStream;") <<
                compileExpr(expr, ch) <<
                InvokeVirtual("java/io/PrintStream", "println", "(Ljava/lang/String;)V") <<
                RETURN

            case Assign(id: Identifier, expr: ExprTree) =>
              ch <<
                compileExpr(expr, ch) << {
                  id.getType match {
                    case TInt => IStore(slotFor(id.getSymbol.id))
                    case TIntArray => AStore(slotFor(id.getSymbol.id))
                    case TBoolean => IStore(slotFor(id.getSymbol.id))
                    case TString => AStore(slotFor(id.getSymbol.id))
                    case _ => AStore(slotFor(id.getSymbol.id)) // Object 
                  }
                }

            case ArrayAssign(id: Identifier, index: ExprTree, expr: ExprTree) =>
              ch <<
              	compileExpr(expr, ch) <<
              	compileExpr(index, ch) <<
              	ALoad(slotFor(id.getSymbol.id)) <<
              	IASTORE
          }
        }
    }

    def compileExpr(expr: ExprTree, ch: CodeHandler): AbstractByteCodeGenerator = {
      return null;
    }

    val outDir = ctx.outDir.map(_.getPath + "/").getOrElse("./")

    val f = new java.io.File(outDir)
    if (!f.exists()) {
      f.mkdir()
    }

    val sourceName = ctx.file.getName

    // output code
    prog.classes foreach {
      ct => generateClassFile(sourceName, ct, outDir)
    }

    // Now do the main method
    // ...
  }

}
