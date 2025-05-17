lexer grammar MyLangLexer;

IF         : 'if';
RETURN     : 'return';
EQ         : '==';
ASSIGN     : '=';
PLUS       : '+';
MINUS      : '-';
MUL        : '*';
DIV        : '/';
LPAREN     : '(';
RPAREN     : ')';
LBRACE     : '{';
RBRACE     : '}';
SEMICOLON  : ';';

IDENTIFIER : [a-zA-Z_][a-zA-Z_0-9]*;
NUMBER     : [0-9]+;

WS         : [ \t\r\n]+ -> skip;
