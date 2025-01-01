import 'package:knownledga/data/repositories/markdown/token.dart';

class MarkdownBold extends MarkdownToken {
  List<MarkdownToken> tokens = [];

  MarkdownBold({required super.type, required super.raw, required this.tokens});
}