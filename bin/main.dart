import 'MyLangLexer.dart';
import 'MyLangParser.dart';

void main() {
  const input = '''
if (x == 10) x + 1;
{
    y = 5;
    return;
}
''';

  final lexer = Lexer(input);
  final tokens = lexer.tokenize();

  print('Tokens:');
  for (var t in tokens) {
    print(t);
  }

  final parser = Parser(tokens);
  try {
    parser.prog();
    print('Parsing completed successfully!');
  } catch (e) {
    print('Erro: $e');
  }
}
