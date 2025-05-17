import 'dart:io';

class Token {
  final String type;
  final String text;
  Token(this.type, this.text);
  @override
  String toString() => 'Token(type: $type, text: "$text")';
}

final keywords = {
  'if': 'IF',
  'else': 'ELSE',
  'while': 'WHILE',
  'return': 'RETURN',
  'int': 'INT',
  'float': 'FLOAT',
  'void': 'VOID',
};

final tokenPatterns = <String, RegExp>{
  'FLOAT_LIT': RegExp(r'^\d+\.\d+'),
  'INT_LIT': RegExp(r'^\d+'),
  'ID': RegExp(r'^[a-zA-Z_][a-zA-Z_0-9]*'),
  'PLUS': RegExp(r'^\+'),
  'MINUS': RegExp(r'^\-'),
  'MUL': RegExp(r'^\*'),
  'DIV': RegExp(r'^/'),
  'EQ': RegExp(r'^=='),
  'NE': RegExp(r'^!='),
  'LE': RegExp(r'^<='),
  'LT': RegExp(r'^<'),
  'GE': RegExp(r'^>='),
  'GT': RegExp(r'^>'),
  'SEMI': RegExp(r'^;'),
  'LPAREN': RegExp(r'^\('),
  'RPAREN': RegExp(r'^\)'),
  'LBRACE': RegExp(r'^\{'),
  'RBRACE': RegExp(r'^\}'),
  'LINE_COMMENT': RegExp(r'^//.*'),
  'WS': RegExp(r'^[ \t\r\n]+'),
  'ASSIGN': RegExp(r'^='),
};

List<Token> lexer(String input) {
  List<Token> tokens = [];
  String buffer = input;

  while (buffer.isNotEmpty) {
    bool matched = false;

    // coment ou espaco vazio
    final wsMatch = tokenPatterns['WS']!.firstMatch(buffer);
    if (wsMatch != null) {
      buffer = buffer.substring(wsMatch.end);
      matched = true;
      continue;
    }

    final commentMatch = tokenPatterns['LINE_COMMENT']!.firstMatch(buffer);
    if (commentMatch != null) {
      buffer = buffer.substring(commentMatch.end);
      matched = true;
      continue;
    }

    // Testar todos os tokens na ordem (maior primeiro para evitar ambiguidade)
    for (var entry in tokenPatterns.entries) {
      if (entry.key == 'WS' || entry.key == 'LINE_COMMENT') continue; // já ignorados

      final match = entry.value.firstMatch(buffer);
      if (match != null) {
        String text = match.group(0)!;

        // Para IDs, verificar se é palavra-chave
        if (entry.key == 'ID' && keywords.containsKey(text)) {
          tokens.add(Token(keywords[text]!, text));
        } else {
          tokens.add(Token(entry.key, text));
        }

        buffer = buffer.substring(match.end);
        matched = true;
        break;
      }
    }

    if (!matched) {
      throw FormatException('Token inválido perto de: ${buffer.substring(0, buffer.length > 10 ? 10 : buffer.length)}');
    }
  }

  return tokens;
}

void main() {
  final input = '''
    if (x == 10) {
      y = y + 2;
      // comentario
    }
    return;
  ''';

  try {
    final tokens = lexer(input);
    for (final token in tokens) {
      print(token);
    }
  } catch (e) {
    print('Erro: $e');
  }
}