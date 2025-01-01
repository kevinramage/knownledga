import 'package:knownledga/data/repositories/markdown/token.dart';

class MarkdownLink extends MarkdownToken {
  String title = "";
  String link = "";

  MarkdownLink({required super.type, required super.raw, required this.title, required this.link});
}