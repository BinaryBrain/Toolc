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
        while(currentToken.kind == BAD) {
          currentToken = tokens.next
        }
      }
    }

    /** ''Eats'' the expected token, or terminates with an error. */
    def eat(kind: TokenKind): Unit = {
      if(currentToken.kind == kind) {
        readToken
      } else {
        expected(kind)
      }
    }

    /** Complains that what was found was not expected. The method accepts arbitrarily many arguments of type TokenClass */
    def expected(kind: TokenKind, more: TokenKind*): Nothing = {
      fatal("expected: " + (kind::more.toList).mkString(" or ") + ", found: " + currentToken, currentToken)
    }
    
    def isFirstOfClassDecl = currentToken.kind == CLASS
    def isFirstOfStatement = List(LBRACE, IF, WHILE, PRINTLN, IDKIND).exists(_ == currentToken.kind) 
    def isFirstOfExpr = List(LPAREN, BANG, NEW, IDKIND, FALSE, THIS, TRUE, STRLITKIND, INTLITKIND).exists(_ == currentToken.kind)
    def isFirstOfChainExpr = List(LBRACKET, DOT).exists(_ == currentToken.kind)
    

    
    // Goal	::=	MainObject ( ClassDeclaration )* <EOF> 
    def parseGoal: Program = {
      val mainObject = parseMainObject
      
      var classDecls: List[ClassDecl] = List()
      while(isFirstOfClassDecl) {
        classDecls = classDecls ::: List(parseClassDecl) 
      }
      
      eat(EOF)
      Program(mainObject, classDecls)
    }
    
    // MainObject  ::=	object Identifier { def main ( ) : Unit = { ( Statement )* } }
    def parseMainObject: MainObject = {
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
      
      new MainObject(identifier, stmts)
    }
    
    // ClassDeclaration	::=	class Identifier ( extends Identifier )? { ( VarDeclaration )* ( MethodDeclaration )* }	
    def parseClassDecl: ClassDecl = {
      eat(CLASS)
      val identifier = parseIdentifier
      
      var parent: Option[Identifier] = None
      if(currentToken.kind == EXTENDS) {
        parent = Some(parseIdentifier)
      }
      
      eat(LBRACE)
      var varDecls: List[VarDecl] = List()
      while(currentToken.kind == VAR) {
        varDecls = varDecls ::: List(parseVarDecl)
      }
      
      var methodDecls: List[MethodDecl] = List()
      while(currentToken.kind == DEF) {
        methodDecls = methodDecls ::: List(parseMethodDecl)
      }
      
      eat(RBRACE)
      
      new ClassDecl(identifier, parent, varDecls, methodDecls)
    }
    
    def parseIdentifier: Identifier = {
      var value = ""
      if(currentToken.kind == IDKIND) {
    	  value = currentToken.toString.substring(3, currentToken.toString.size-1)
      }
      eat(IDKIND)
      
      new Identifier(value)
    }
    
    def parseStatement: StatTree = {
      //{ ( Statement )* }
      if(currentToken.kind == LBRACE) {
        eat(LBRACE)
        var stmts = parseStatements
        eat(RBRACE)
        
        new Block(stmts)
      } 
      
      // if ( Expression ) Statement ( else Statement )? 
      /*
       * if expr then if expr then expr else expr
       */
      else if(currentToken.kind == IF) {
        eat(IF)
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        val stmt = parseStatement
        var elseStmts: Option[StatTree] = None
        if(currentToken.kind == ELSE) {
          eat(ELSE)
          elseStmts = Option(parseStatement)
        }
        
        new If(expr, stmt, elseStmts)
      }
      
      // while ( Expression ) Statement 
      else if(currentToken.kind == WHILE) {
        eat(WHILE)
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        val stmt = parseStatement
        
        new While(expr, stmt)
      }
      
      // println ( Expression ) ;
      else if(currentToken.kind == PRINTLN) {
        eat(PRINTLN)
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        eat(SEMICOLON)
        
        new Println(expr)
      }
      
      else {
        val identifier = parseIdentifier
        
        // Identifier = Expression ; 
        if(currentToken.kind == EQSIGN) {
        	eat(EQSIGN)
        	val expr = parseExpr
        	eat(SEMICOLON)
        	new Assign(identifier, expr)
        }
        
        // Identifier [ Expression ] = Expression ; 
        else {
        	eat(LBRACKET)
        	val indexExpr = parseExpr
        	eat(RBRACKET)
        	eat(EQSIGN)
        	val expr = parseExpr
        	eat(SEMICOLON)
        	new ArrayAssign(identifier, indexExpr, expr)
        }
      }
    }
    
    def parseStatements: List[StatTree] = {
      var stmts: List[StatTree] = List()
	    while(isFirstOfStatement) {
	      stmts = stmts ::: List(parseStatement)
	  }
      return stmts
    }
    
    // VarDeclaration	::=	var Identifier : Type ;
    def parseVarDecl: VarDecl = {
      eat(VAR)
      val identifier = parseIdentifier
      eat(COLON)
      val typ3 = parseType 
      eat(SEMICOLON)
      new VarDecl(typ3, identifier)
    }
    
    // MethodDeclaration	::=	def Identifier ( ( Identifier : Type ( , Identifier : Type )* )? ) :
    // Type = { ( VarDeclaration )* ( Statement )* return Expression ; }
    def parseMethodDecl: MethodDecl = {
      eat(DEF)
      val identifier = parseIdentifier
      eat(LPAREN)
      var args: List[Formal] = List() 
      
      if(currentToken.kind == IDKIND) {
        args = args ::: List(parseArg)
      }
      
      while(currentToken.kind == COMMA) {
    	eat(COMMA)
        args = args ::: List(parseArg)
      }
      
      eat(RPAREN)
      
      eat(COLON)
      
      val typ3 = parseType
      
      eat(EQSIGN)
      eat(LBRACE)
      
      var varDecls: List[VarDecl] = List()
      while(currentToken.kind == VAR) {
        varDecls = varDecls ::: List(parseVarDecl)
      }
      
      var stmts = parseStatements
      
      eat(RETURN)
      
      val expr = parseExpr
      
      eat(SEMICOLON)
      eat(RBRACE)
      
      new MethodDecl(typ3, identifier, args, varDecls, stmts, expr)
    }
    
    def parseArg: Formal = {
      val identifier = parseIdentifier
      eat(COLON)
      val typ3 = parseType
      new Formal(typ3, identifier)
    }
    
    def parseType: TypeTree = {
      
      if(currentToken.kind == INT) {
        eat(INT)
        if(currentToken.kind == LBRACKET) {
          eat(LBRACKET)
          eat(RBRACKET)
          new IntArrayType
        } else {
          new IntType
        }
      } else if(currentToken.kind == BOOLEAN) {
        eat(BOOLEAN)
        new BooleanType
      } else if(currentToken.kind == STRING) {
        eat(STRING)
        new StringType
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
    	  e = Or(e, parseAndExpr)
      }
      e
    }
    
    def parseAndExpr: ExprTree = {
      var e = parseLessOrEqualExpr
      while (currentToken.kind == AND) {
    	  eat(AND)
    	  e = And(e, parseLessOrEqualExpr)
      }
      e
    }
    
    def parseLessOrEqualExpr: ExprTree = {
      var e = parsePlusOrMinusExpr
      while (currentToken.kind == LESSTHAN || currentToken.kind == EQUALS) {
    	  if(currentToken.kind == LESSTHAN) {
    		  eat(LESSTHAN)
    		  e =  LessThan(e, parsePlusOrMinusExpr)
    	  } else {
    		  eat(EQUALS)
    		  e =  Equals(e, parsePlusOrMinusExpr)
    	  }
      }
      e
    }
    
    def parsePlusOrMinusExpr: ExprTree = {
      var e = parseTimesOrDivideExpr
      while (currentToken.kind == PLUS || currentToken.kind == MINUS) {
    	  if(currentToken.kind == PLUS) {
    		  eat(PLUS)
    		  e =  Plus(e, parseTimesOrDivideExpr)
    	  } else {
    		  eat(MINUS)
    		  e =  Minus(e, parseTimesOrDivideExpr)
    	  }
      }
      e
    }
    
    def parseTimesOrDivideExpr: ExprTree = {
      var e = parseFinalExpr
      while (currentToken.kind == TIMES || currentToken.kind == DIV) {
    	  if(currentToken.kind == TIMES) {
    		  eat(TIMES)
    		  e =  Times(e, parseFinalExpr)
    	  } else {
    		  eat(DIV)
    		  e =  Div(e, parseFinalExpr)
    	  }
      }
      e
    }
    
    def parseFinalExpr: ExprTree = {
      var e = if(currentToken.kind == TRUE) {
        eat(TRUE)
        new True
      }
      else if(currentToken.kind == FALSE) {
        eat(FALSE)
        new False
      }
      else if(currentToken.kind == IDKIND) {
        parseIdentifier
      }
      
      else if(currentToken.kind == INTLITKIND) {
        val e = new IntLit(currentToken.toString.substring(4, currentToken.toString.size-1).toInt)
        eat(INTLITKIND)
        e
      }
      
      else if(currentToken.kind == STRLITKIND) {
        val e = new StringLit(currentToken.toString.substring(4, currentToken.toString.size-1))
        eat(STRLITKIND)
        e
      }
      
      else if(currentToken.kind == THIS) {
        eat(THIS)
        new This
      }
      
      else if(currentToken.kind == NEW) {
        eat(NEW)
        if(currentToken.kind == INT) {
          eat(INT)
          eat(LBRACKET)
          val expr = parseExpr
          eat(RBRACKET)
          
          new NewIntArray(expr)
        }
        else {
          val id = parseIdentifier
          eat(LPAREN)
          eat(RPAREN)
          
          new New(id)
        }
      } else if(currentToken.kind == BANG) {
        eat(BANG)
        val expr = parseExpr
        new Not(expr)
      }
      
      else {
        eat(LPAREN)
        val expr = parseExpr
        eat(RPAREN)
        expr
      }
      
      while(isFirstOfChainExpr) {
      
      if(currentToken.kind == LBRACKET) {
        eat(LBRACKET)
        val indexExpr = parseExpr
        eat(RBRACKET)
        e = new ArrayRead(e, indexExpr)
      } 
      
      else if(currentToken.kind == DOT) {
        eat(DOT)
        
        if(currentToken.kind == LENGTH) {
          eat(LENGTH)
          e = new ArrayLength(e)
        }
        
        else {
          val id = parseIdentifier
          eat(LPAREN)
          var exprs: List[ExprTree] = List()
          
          if(isFirstOfExpr) {
        	  	exprs = exprs ::: List(parseExpr)
          }
      
          while(currentToken.kind == COMMA) {
        	  eat(COMMA)
        	  exprs = exprs ::: List(parseExpr)
          }
          
          eat(RPAREN)
          
          e = new MethodCall(e, id, exprs)
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
