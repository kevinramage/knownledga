import 'package:knownledga/data/repositories/markdown/token.dart';

// Example: 
// # Title1
class MarkdownHeadingToken extends MarkdownToken {
  String content;
  int level;

  MarkdownHeadingToken({required super.type, required super.raw, required this.level, required this.content});
}