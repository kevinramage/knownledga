import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// This is a paragraph
class MarkdownParagraphToken extends MarkdownToken {
  String text;

  MarkdownParagraphToken({required super.type, required this.text, required super.raw});
}