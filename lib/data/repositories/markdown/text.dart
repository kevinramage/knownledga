import 'package:knownledga/data/repositories/markdown/token.dart';

class MarkdownText extends MarkdownToken {
  String text;

  MarkdownText({required super.type, required super.raw, required this.text});
}