parser grammar MyLangParser;

options { tokenVocab=MyLangLexer; }

prog      : stat* EOF ;

stat
    : IF LPAREN expr RPAREN stat           #ifStatement
    | LBRACE stat* RBRACE                  #block
    | IDENTIFIER ASSIGN expr SEMICOLON     #assignment
    | RETURN SEMICOLON                     #returnStatement
    | expr SEMICOLON                       #expressionStatement
    ;

expr      : term ((PLUS | MINUS | EQ) term)* ;

term      : factor ((MUL | DIV) factor)* ;

factor
    : LPAREN expr RPAREN
    | NUMBER
    | IDENTIFIER
    ;
