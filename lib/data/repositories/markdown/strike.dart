import 'package:knownledga/data/repositories/markdown/token.dart';

class MarkdownStrike extends MarkdownToken {
  List<MarkdownToken> tokens = [];

  MarkdownStrike({required super.type, required super.raw, required this.tokens});
}