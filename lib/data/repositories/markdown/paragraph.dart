import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// This is a paragraph
class MarkdownParagraphToken extends MarkdownToken {
  List<MarkdownToken> tokens;

  MarkdownParagraphToken({required super.type, required this.tokens, required super.raw});
}