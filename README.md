# jlox #
   
My first foray into PLD, and understanding how actual interpreters and compilers work,
following [Crafting Interpreters](http://craftinginterpreters.com/ "Crafting Interpreters"),
an excellent book by Bob Nystrom.

This implementation of `jlox` follows faithfully the canonical tree-walk interpreter
implementation in Java as detailed in the book.

## Lox Lexical Grammar ##

    NUMBER          → DIGIT+ ( "." DIGIT+ )? ;
    STRING          → '"' <any char except '"'>* '"' ;
    IDENTIFIER      → ALPHA ( ALPHA | DIGIT )* ;
    ALPHA           → 'a' ... 'z' | 'A' ... 'Z' | '_' ;
    DIGIT           → '0' ... '9' ;


## Lox Syntax Grammar ##

    program         → declaration* EOF ;
    
    declaration     → classDecl
                    | funDecl
                    | varDecl
                    | statement ;
    classDecl       → "class" IDENTIFIER ( "<" IDENTIFIER )?
                    "{" function* "}" ;
    funDecl         → "fun" function ;
    function        → IDENTIFIER "(" parameters? ")" block ;
    parameters      → IDENTIFIER ( "," IDENTIFIER )* ;
    varDecl         → "var" IDENTIFIER ( "=" expression )? ";" ;
    
    statement       → exprStmt
                    | forStmt
                    | ifStmt
                    | printStmt
                    | returnStmt
                    | whileStmt
                    | block ;
                    
    exprStmt        → expression ";" ;                    
    forStmt         → "for" "(" ( varDecl | exprStmt | ";" )
                                expression? ";"
                                expression? ")" statement ;
    ifStmt          → "if" "(" expression ")" statement ( "else" statement )? ;
    printStmt       → "print" expression ";" ;
    returnStmt      → "return" expression? ";" ;
    whileStmt       → "while" "(" expression ")" statement ; 
    block           → "{" declaration* "}" ;
    
    expression      → assignment ;
    
    assignment      → ( call "." )? IDENTIFIER "=" assignment
                    | logic_or ;
                    
    logic_or        → logic_and ( "or" logic_and )* ;
    logic_and       → equality ( "and" equality )* ;
    equality        → comparison ( ( "!=" | "==" ) comparison )* ;
    comparison      → addition ( ( ">" | ">=" | "<" | "<=" ) addition )* ;
    addition        → multiplication ( ( "-" | "+" ) multiplication )* ;
    multiplication  → unary ( ( "/" | "*" ) unary )* ;
    
    unary           → ( "!" | "-" ) unary | call ;
    call            → primary ( "(" arguments? ")" | "." IDENTIFIER )* ;
    arguments       → expression ( "," expression )* ;
    primary         → "true" | "false" | "nil" | "this"
                    | NUMBER | STRING | IDENTIFIER | "(" expression ")"
                    | "super" "." IDENTIFIER ;
                
## Lox Precedence Rules ##

Name            |       Operators       | Associates
:--------------:|:---------------------:|:---------:
Unary           |   `!` `-`             | Right
Multiplication  |   `/` `*`             | Left
Addition        |   `-` `+`             | Left
Comparison      |   `>` `>=` `<` `<=`   | Left
Equality        |   `==` `!=`           | Left
