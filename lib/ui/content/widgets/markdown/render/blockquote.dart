import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/blockquote.dart';

class MarkdownBlockQuoteScreen extends StatelessWidget {

  final MarkdownBlockQuote _token;

  const MarkdownBlockQuoteScreen({super.key, required MarkdownBlockQuote token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    return Text(_token.text, softWrap: true);
  }
}