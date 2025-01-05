import 'package:knownledga/data/repositories/markdown/token.dart';

class MarkdownItalic extends MarkdownToken {
  List<MarkdownToken> tokens = [];

  MarkdownItalic({required super.type, required super.raw, required this.tokens});
}