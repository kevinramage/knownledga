import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// > This is a block quote text
class MarkdownBlockQuote extends MarkdownToken {
  String text = "";

  MarkdownBlockQuote({required super.type, required super.raw, required this.text});
}