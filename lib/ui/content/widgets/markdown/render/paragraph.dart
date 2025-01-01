import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/paragraph.dart';

class MarkdownParagraphScreen extends StatelessWidget {

  final MarkdownParagraphToken _token;
  const MarkdownParagraphScreen({super.key, required MarkdownParagraphToken token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    return Text(_token.text);
  }
}