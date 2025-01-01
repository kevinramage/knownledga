import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/paragraph.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/inline.dart';

class MarkdownParagraphScreen extends StatelessWidget {

  final MarkdownParagraphToken _token;
  const MarkdownParagraphScreen({super.key, required MarkdownParagraphToken token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    return MarkdownInlineScreen(tokens: _token.tokens);
  }
}