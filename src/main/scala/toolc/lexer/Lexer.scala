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

    // Complete this file

    new Iterator[Token] {
      var token: Token = null
      var ch = source.next
      var pos = source.pos

      def nextCh = {
        ch = source.next
      }
      
      def hasNext = {
        token == null || token.kind != EOF
      }

      def next = {
        pos = source.pos

        if (!source.hasNext) {
          token = new Token(EOF)
        }
        
        else {
          token = ch match {
            
            case ' '  => nextCh; next
            case '\n' => nextCh; next
            
            
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
            
            case '/' => nextCh;
            			if(ch == '/') {
            			  while(ch != '\n' && source.hasNext) nextCh;
            			  if(source.hasNext) nextCh
            			  next }
            			
            			else if(ch == '*') {
            			  nextCh
            			  var cont = true
            			  while(cont) {
            				  while(ch != '*' && source.hasNext) 
            				    nextCh
            				  if(source.hasNext) nextCh
            				  if(ch == '/' || !source.hasNext) {
            				    cont = false
            				  }
            				  if(source.hasNext) nextCh
            			  }
            			  next }
            			
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
