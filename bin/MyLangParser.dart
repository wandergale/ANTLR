import 'MyLangLexer.dart';

class Parser {
  final List<Token> tokens;
  int pos = 0;

  Parser(this.tokens);

  Token get current => pos < tokens.length ? tokens[pos] : Token('EOF', '');

  void consume(String expectedType) {
    if (current.type == expectedType) {
      pos++;
    } else {
      throw FormatException('Expected $expectedType but found ${current.type} ("${current.text}")');
    }
  }

  void prog() {
    while (pos < tokens.length && current.type != 'EOF') {
      stat();
    }
  }

  void stat() {
    if (current.type == 'IF') {
      consume('IF');
      consume('LPAREN');
      expr();
      consume('RPAREN');
      stat();
    } else if (current.type == 'LBRACE') {
      consume('LBRACE');
      while (current.type != 'RBRACE') {
        stat();
      }
      consume('RBRACE');
    } else if (current.type == 'IDENTIFIER') {
      // Could be assignment or expression statement
      if (pos + 1 < tokens.length && tokens[pos + 1].type == 'ASSIGN') {
        assignment();
      } else {
        expr();
        consume('SEMICOLON');
      }
    } else if (current.type == 'RETURN') {
      consume('RETURN');
      consume('SEMICOLON');
    } else {
      expr();
      consume('SEMICOLON');
    }
  }

  void assignment() {
    consume('IDENTIFIER');
    consume('ASSIGN');
    expr();
    consume('SEMICOLON');
  }

  void expr() {
    term();
    while (current.type == 'PLUS' || current.type == 'MINUS' || current.type == 'EQ') {
      consume(current.type);
      term();
    }
  }

  void term() {
    factor();
    while (current.type == 'MUL' || current.type == 'DIV') {
      consume(current.type);
      factor();
    }
  }

  void factor() {
    if (current.type == 'LPAREN') {
      consume('LPAREN');
      expr();
      consume('RPAREN');
    } else if (current.type == 'NUMBER') {
      consume('NUMBER');
    } else if (current.type == 'IDENTIFIER') {
      consume('IDENTIFIER');
    } else {
      throw FormatException('Unexpected token ${current.type} ("${current.text}") in factor');
    }
  }
}
