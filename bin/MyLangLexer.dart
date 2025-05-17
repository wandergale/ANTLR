class Token {
  final String type;
  final String text;
  Token(this.type, this.text);
  @override
  String toString() => 'Token($type, "$text")';
}

class Lexer {
  final String input;
  int pos = 0;

  Lexer(this.input);

  static final tokenPatterns = <String, RegExp>{
    'IF': RegExp(r'^if\b'),
    'RETURN': RegExp(r'^return\b'),
    'EQ': RegExp(r'^=='),
    'ASSIGN': RegExp(r'^='),
    'IDENTIFIER': RegExp(r'^[a-zA-Z_][a-zA-Z_0-9]*'),
    'NUMBER': RegExp(r'^[0-9]+'),
    'LPAREN': RegExp(r'^\('),
    'RPAREN': RegExp(r'^\)'),
    'LBRACE': RegExp(r'^\{'),
    'RBRACE': RegExp(r'^\}'),
    'SEMICOLON': RegExp(r'^;'),
    'PLUS': RegExp(r'^\+'),
    'MINUS': RegExp(r'^\-'),
    'MUL': RegExp(r'^\*'),
    'DIV': RegExp(r'^/'),
    'WS': RegExp(r'^[ \t\r\n]+'),
  };

  Token? nextToken() {
    if (pos >= input.length) return null;

    final slice = input.substring(pos);

    for (var entry in tokenPatterns.entries) {
      final match = entry.value.firstMatch(slice);
      if (match != null) {
        final text = match.group(0)!;
        pos += text.length;

        // Skip whitespace
        if (entry.key == 'WS') {
          return nextToken();
        }

        return Token(entry.key, text);
      }
    }

    throw FormatException('Unexpected character at position $pos: "${input[pos]}"');
  }

    List<Token> tokenize() {
        final tokens = <Token>[];
        Token? tok;
        while (true) {
            tok = nextToken();
            if (tok == null) break;
            tokens.add(tok);
        }
        return tokens;
    }

}
