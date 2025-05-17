lexer grammar MyLangLexer;

IF      : 'if';
ELSE    : 'else';
WHILE   : 'while';
RETURN  : 'return';
INT     : 'int';
FLOAT   : 'float';
VOID    : 'void';

FLOAT_LIT : [0-9]+ '.' [0-9]+;
INT_LIT   : [0-9]+;
ID        : [a-zA-Z_][a-zA-Z_0-9]*;

PLUS    : '+';
MINUS   : '-';
MUL     : '*';
DIV     : '/';

EQ      : '==';
NE      : '!=';
LE      : '<=';
LT      : '<';
GE      : '>=';
GT      : '>';

SEMI    : ';';
LPAREN  : '(';
RPAREN  : ')';
LBRACE  : '{';
RBRACE  : '}';

ASSIGN  : '=';

// Comentários e espaços em branco (ignorados)
LINE_COMMENT : '//' ~[\r\n]* -> skip;
WS           : [ \t\r\n]+    -> skip;
