package toolc
package ast

import utils._
import Trees._
import lexer._
import lexer.Tokens._

object Parser extends Pipeline[Iterator[Token], Program] {
  def run(ctx: Context)(tokens: Iterator[Token]): Program = {
    import ctx.reporter._

    /** Store the current token, and one lookahead token, as read from the lexer. */
    var currentToken: Token = new Token(BAD)

    def readToken: Unit = {
      if (tokens.hasNext) {
        // uses nextToken from the Lexer trait
        currentToken = tokens.next

        // skips bad tokens
        while (currentToken.kind == BAD) {
          currentToken = tokens.next
        }
      }
    }

    /** ''Eats'' the expected token, or terminates with an error. */
    def eat(kind: TokenKind): Unit = {
      if (currentToken.kind == kind) {
        readToken
      } else {
        expected(kind)
      }
    }

    /** Complains that what was found was not expected. The method accepts arbitrarily many arguments of type TokenClass */
    def expected(kind: TokenKind, more: TokenKind*): Nothing = {
      fatal("expected: " + (kind :: more.toList).mkString(" or ") + ", found: " + currentToken, currentToken)
    }

    /** Some useful method to know what we are parsing */
    def isFirstOfClassDecl = currentToken.kind == CLASS
    def isFirstOfStatement = List(LBRACE, IF, WHILE, PRINTLN, IDKIND).exists(_ == currentToken.kind)
    def isFirstOfExpr = List(LPAREN, BANG, NEW, IDKIND, FALSE, THIS, TRUE, STRLITKIND, INTLITKIND).exists(_ == currentToken.kind)
    def isFirstOfChainExpr = List(LBRACKET, DOT).exists(_ == currentToken.kind)
    

    /** Goal ::=	MainObject ( ClassDeclaration )* <EOF> */ 
    def parseGoal: Program = {
      val mainObject = parseMainObject

      var classDecls: List[ClassDecl] = List()
      while (isFirstOfClassDecl) {
        classDecls = classDecls ::: List(parseClassDecl)
      }

      eat(EOF)
      Program(mainObject, classDecls).setPos(mainObject)
    }
    

    /** MainObject  ::=	object Identifier { def main ( ) : Unit = { ( Statement )* } } */
    def parseMainObject: MainObject = {
      val objectToken = currentToken
      eat(OBJECT)
      val identifier = parseIdentifier
      eat(LBRACE)
      eat(DEF)
      eat(MAIN)
      eat(LPAREN)
      eat(RPAREN)
      eat(COLON)
      eat(UNIT)
      eat(EQSIGN)
      eat(LBRACE)

      var stmts = parseStatements
      eat(RBRACE)
      eat(RBRACE)

      new MainObject(identifier, stmts).setPos(objectToken)
    }

    /** ClassDeclaration	::=	class Identifier ( extends Identifier )? { ( VarDeclaration )* ( MethodDeclaration )* } */	
    def parseClassDecl: ClassDecl = {
      val classToken = currentToken
      eat(CLASS)
      val identifier = parseIdentifier

      var parent: Option[Identifier] = None
      if (currentToken.kind == EXTENDS) {
        eat(EXTENDS)
        parent = Some(parseIdentifier)
      }

      eat(LBRACE)
      var varDecls: List[VarDecl] = List()
      while (currentToken.kind == VAR) {
        varDecls = varDecls ::: List(parseVarDecl)
      }

      var methodDecls: List[MethodDecl] = List()
      while (currentToken.kind == DEF) {
        methodDecls = methodDecls ::: List(parseMethodDecl)
      }

      eat(RBRACE)

      new ClassDecl(identifier, parent, varDecls, methodDecls).setPos(classToken)
    }

    def parseIdentifier: Identifier = {
      var value = ""
      if (currentToken.kind == IDKIND) {
        value = currentToken.toString.substring(3, currentToken.toString.size - 1)
      }
      val idToken = currentToken
      eat(IDKIND)

      new Identifier(value).setPos(idToken)
    }

    def parseStatement: StatTree = {
      //{ ( Statement )* }
      if (currentToken.kind == LBRACE) {
        val lBraceToken = currentToken
        eat(LBRACE)
        var stmts = parseStatements
        eat(RBRACE)

        new Block(stmts).setPos(lBraceToken)
      } // if ( Expression ) Statement ( else Statement )? 
      /*
       * if expr then if expr then expr else expr
       */ else if (currentToken.kind == IF) {
        val ifToken = currentToken
        eat(IF)
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        val stmt = parseStatement
        var elseStmts: Option[StatTree] = None
        if (currentToken.kind == ELSE) {
          eat(ELSE)
          elseStmts = Option(parseStatement)
        }

        new If(expr, stmt, elseStmts).setPos(ifToken)
      } // while ( Expression ) Statement 
      else if (currentToken.kind == WHILE) {
        val whileToken = currentToken
        eat(WHILE)
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        val stmt = parseStatement

        new While(expr, stmt).setPos(whileToken)
      } // println ( Expression ) ;
      else if (currentToken.kind == PRINTLN) {
        val printlnToken = currentToken
        eat(PRINTLN)
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        eat(SEMICOLON)

        new Println(expr).setPos(printlnToken)
      } else {
        val identifier = parseIdentifier

        // Identifier = Expression ; 
        if (currentToken.kind == EQSIGN) {
          eat(EQSIGN)
          val expr = parseExpr
          eat(SEMICOLON)
          new Assign(identifier, expr).setPos(identifier)
        } // Identifier [ Expression ] = Expression ; 
        else {
          eat(LBRACKET)
          val indexExpr = parseExpr
          eat(RBRACKET)
          eat(EQSIGN)
          val expr = parseExpr
          eat(SEMICOLON)
          new ArrayAssign(identifier, indexExpr, expr).setPos(identifier)
        }
      }
    }

    def parseStatements: List[StatTree] = {
      var stmts: List[StatTree] = List()
      while (isFirstOfStatement) {
        stmts = stmts ::: List(parseStatement)
      }
      return stmts
    }

    // VarDeclaration	::=	var Identifier : Type ;
    def parseVarDecl: VarDecl = {
      val varToken = currentToken
      eat(VAR)
      val identifier = parseIdentifier
      eat(COLON)
      val typ3 = parseType
      eat(SEMICOLON)
      new VarDecl(typ3, identifier).setPos(varToken)
    }

    // MethodDeclaration	::=	def Identifier ( ( Identifier : Type ( , Identifier : Type )* )? ) :
    // Type = { ( VarDeclaration )* ( Statement )* return Expression ; }
    def parseMethodDecl: MethodDecl = {
      val defToken = currentToken
      eat(DEF)
      val identifier = parseIdentifier
      eat(LPAREN)
      var args: List[Formal] = List()

      var first = true
      if (currentToken.kind == IDKIND) {
        args = args ::: List(parseArg)
        first = false
      }

      while (!first && currentToken.kind == COMMA) {
        eat(COMMA)
        args = args ::: List(parseArg)
      }

      eat(RPAREN)

      eat(COLON)

      val typ3 = parseType

      eat(EQSIGN)
      eat(LBRACE)

      var varDecls: List[VarDecl] = List()
      while (currentToken.kind == VAR) {
        varDecls = varDecls ::: List(parseVarDecl)
      }

      var stmts = parseStatements

      eat(RETURN)

      val expr = parseExpr

      eat(SEMICOLON)
      eat(RBRACE)

      new MethodDecl(typ3, identifier, args, varDecls, stmts, expr).setPos(defToken)
    }

    def parseArg: Formal = {
      val identifier = parseIdentifier
      eat(COLON)
      val typ3 = parseType
      new Formal(typ3, identifier).setPos(identifier)
    }

    def parseType: TypeTree = {

      val token = currentToken
      if (currentToken.kind == INT) {
        eat(INT)
        if (currentToken.kind == LBRACKET) {
          eat(LBRACKET)
          eat(RBRACKET)
          new IntArrayType().setPos(token)
        } else {
          new IntType().setPos(token)
        }
      } else if (currentToken.kind == BOOLEAN) {
        eat(BOOLEAN)
        new BooleanType().setPos(token)
      } else if (currentToken.kind == STRING) {
        eat(STRING)
        new StringType().setPos(token)
      } else {
        parseIdentifier
      }
    }

    def parseExpr: ExprTree = {
      parseOrExpr
    }

    def parseOrExpr: ExprTree = {
      var e = parseAndExpr
      while (currentToken.kind == OR) {
        eat(OR)
        e = Or(e, parseAndExpr).setPos(e)
      }
      e
    }

    def parseAndExpr: ExprTree = {
      var e = parseLessOrEqualExpr
      while (currentToken.kind == AND) {
        eat(AND)
        e = And(e, parseLessOrEqualExpr).setPos(e)
      }
      e
    }

    def parseLessOrEqualExpr: ExprTree = {
      var e = parsePlusOrMinusExpr
      while (currentToken.kind == LESSTHAN || currentToken.kind == EQUALS) {
        if (currentToken.kind == LESSTHAN) {
          eat(LESSTHAN)
          e = LessThan(e, parsePlusOrMinusExpr).setPos(e)
        } else {
          eat(EQUALS)
          e = Equals(e, parsePlusOrMinusExpr).setPos(e)
        }
      }
      e
    }

    def parsePlusOrMinusExpr: ExprTree = {
      var e = parseTimesOrDivideExpr
      while (currentToken.kind == PLUS || currentToken.kind == MINUS) {
        if (currentToken.kind == PLUS) {
          eat(PLUS)
          e = Plus(e, parseTimesOrDivideExpr).setPos(e)
        } else {
          eat(MINUS)
          e = Minus(e, parseTimesOrDivideExpr).setPos(e)
        }
      }
      e
    }

    def parseTimesOrDivideExpr: ExprTree = {
      var e = parseFinalExpr
      while (currentToken.kind == TIMES || currentToken.kind == DIV) {
        if (currentToken.kind == TIMES) {
          eat(TIMES)
          e = Times(e, parseFinalExpr).setPos(e)
        } else {
          eat(DIV)
          e = Div(e, parseFinalExpr).setPos(e)
        }
      }
      e
    }

    def parseFinalExpr: ExprTree = {
      var e = if (currentToken.kind == TRUE) {
        val tree = new True().setPos(currentToken)
        eat(TRUE)
        tree
      } else if (currentToken.kind == FALSE) {
        val tree = new False().setPos(currentToken)
        eat(FALSE)
        tree
      } else if (currentToken.kind == IDKIND) {
        parseIdentifier
      } else if (currentToken.kind == INTLITKIND) {
        val tree = new IntLit(currentToken.toString.substring(4, currentToken.toString.size - 1).toInt)
        tree.setPos(currentToken)
        eat(INTLITKIND)
        tree
      } else if (currentToken.kind == STRLITKIND) {
        val tree = new StringLit(currentToken.toString.substring(4, currentToken.toString.size - 1))
        tree.setPos(currentToken)
        eat(STRLITKIND)
        tree
      } else if (currentToken.kind == THIS) {
        val tree = new This().setPos(currentToken)
        eat(THIS)
        tree
      } else if (currentToken.kind == NEW) {
        val newToken = currentToken
        eat(NEW)
        if (currentToken.kind == INT) {
          eat(INT)
          eat(LBRACKET)
          val expr = parseExpr
          eat(RBRACKET)

          new NewIntArray(expr).setPos(newToken)
        } else {
          val id = parseIdentifier
          eat(LPAREN)
          eat(RPAREN)

          new New(id).setPos(newToken)
        }
      } else if (currentToken.kind == BANG) {
        val bangToken = currentToken
        eat(BANG)
        val expr = parseFinalExpr // parseExpr
        new Not(expr).setPos(bangToken)
      } else {
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        expr
      }

      while (isFirstOfChainExpr) {

        if (currentToken.kind == LBRACKET) {
          val lBracketToken = currentToken
          eat(LBRACKET)
          val indexExpr = parseExpr
          eat(RBRACKET)
          e = new ArrayRead(e, indexExpr).setPos(lBracketToken)
        } else if (currentToken.kind == DOT) {
          val dotToken = currentToken
          eat(DOT)

          if (currentToken.kind == LENGTH) {
            eat(LENGTH)
            e = new ArrayLength(e).setPos(dotToken)
          } else {
            val id = parseIdentifier
            eat(LPAREN)
            var exprs: List[ExprTree] = List()
            var first = true

            if (isFirstOfExpr) {
              exprs = exprs ::: List(parseExpr)
              first = false
            }

            while (!first && currentToken.kind == COMMA) {
              eat(COMMA)
              exprs = exprs ::: List(parseExpr)
            }

            eat(RPAREN)

            e = new MethodCall(e, id, exprs).setPos(dotToken)
          }
        }
      }

      e
    }

    readToken
    val tree = parseGoal
    terminateIfErrors
    tree
  }
}
