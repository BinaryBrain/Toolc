package toolc
package lexer

import utils._
import scala.io.Source
import java.io.File

object Lexer extends Pipeline[File, Iterator[Token]] {
  import Tokens._

  def run(ctx: Context)(f: File): Iterator[Token] = {
    val source = Source.fromFile(f)
    import ctx.reporter._
    
    new Iterator[Token] {
      var token: Token = null
      var ch = source.next
      var pos = source.pos
      var endOfFile = false

      def nextCh = {
        if(source.hasNext) {
        	ch = source.next 
        } else {
          endOfFile = true
          ch = 0
        }
      }
      
      def hasNext = {
        // ask what to do if file is empty
        token == null || token.kind != EOF
      }

      def next = {
        pos = source.pos

        if(endOfFile) {
          token = new Token(EOF)
        }
        
        else {
          
          token = ch match {
            
            case c if c.toString.matches("\\s")  => nextCh; next
            
            
            case ':' => nextCh; new Token(COLON)
            case ';' => nextCh; new Token(SEMICOLON)
            case '.' => nextCh; new Token(DOT)
            case ',' => nextCh; new Token(COMMA)
            case '!' => nextCh; new Token(BANG)
            case '(' => nextCh; new Token(LPAREN)
            case ')' => nextCh; new Token(RPAREN)
            case '[' => nextCh; new Token(LBRACKET)
            case ']' => nextCh; new Token(RBRACKET)
            case '{' => nextCh; new Token(LBRACE)
            case '}' => nextCh; new Token(RBRACE)
            case '<' => nextCh; new Token(LESSTHAN)
            case '+' => nextCh; new Token(PLUS)
            case '-' => nextCh; new Token(MINUS)
            case '*' => nextCh; new Token(TIMES)
            
            case x if (x.isDigit && x != '0')  => 
              nextCh
              var integer = x.asDigit
              var cont = true
              while(cont) {
                ch match {
                  case y if y.isDigit =>
                		  integer = integer * 10 + y.asDigit
                		  nextCh
                  case _ =>
                		  cont = false
                }
              }
              
              new INTLIT(integer)
              
            case '0' => nextCh; new INTLIT(0)
            
            case '&' => nextCh;
            			if(ch == '&') {
            			  nextCh
            			  new Token(AND)
            			} else {
            			  new Token(BAD)
            			}
            
            case '|' => nextCh;
            			if(ch == '|') {
            			  nextCh
            			  new Token(OR)
            			} else {
            			  new Token(BAD)
            			}
            
            case '=' => nextCh;
            			if(ch == '=') {
            			  nextCh
            			  new Token(EQUALS)
            			} else {
            			  new Token(EQSIGN)
            			}
            			
            case c if c.isLetter => 
              var id = c.toString
              nextCh
              while(ch.isLetterOrDigit || ch == '_') {
                id = id + ch
                nextCh
              }
              
            id match {
              case "object" => new Token(OBJECT)
              case "class" => new Token(CLASS)
              case "def" => new Token(DEF)
              case "var" => new Token(VAR)
              case "Unit" => new Token(UNIT)
              case "main" => new Token(MAIN)
              case "String" => new Token(STRING)
              case "extends" => new Token(EXTENDS)
              case "Int" => new Token(INT)
              case "Bool" => new Token(BOOLEAN)
              case "while" => new Token(WHILE)
              case "if" => new Token(IF)
              case "else" => new Token(ELSE)
              case "return" => new Token(RETURN)
              case "length" => new Token(LENGTH)
              case "true" => new Token(TRUE)
              case "false" => new Token(FALSE)
              case "this" => new Token(THIS)
              case "new" => new Token(NEW)
              case "println" => new Token(PRINTLN)
              
              case _ => new ID(id)
            }
              
            			
            case '"' =>
              	nextCh
              	var str = ""
              	while(ch != '"') {
              	  if(ch == '\n' || endOfFile) {
              	    fatal("Non Terminated String")
              	  }
              	  str = str + ch
              	  nextCh
              	}
              	nextCh
              	new STRLIT(str)
            
            case '/' => nextCh
            
            			// Single-line comment
            			if(ch == '/') {
            			  while(ch != '\n' && !endOfFile) nextCh;
            			  nextCh
            			  next 
            			}
            			
            			/* Block Comment */
            			else if(ch == '*') {
            			  nextCh
            			  var cont = true
            			  while(cont) {
            				  while(ch != '*') {
            				    if(endOfFile)
            				    	fatal("Unclosed comment block")
            				    nextCh
            				  }
            				  nextCh
            				  if(ch == '/') {
            				    if(endOfFile)
            				    	fatal("Unclosed comment block")
            				    cont = false
            				    nextCh
            				  }
            				  
            			  }
            			  next }
            			
            			// Division sign
            			else {
            			  new Token(DIV)
            			}
            
            
            case _ => nextCh; new Token(BAD)
          }

        }
        
        token.setPos(f, pos)
        token
      }
    }

  }
}
