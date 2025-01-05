import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/italic.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/inline.dart';

class MarkdownItalicScreen extends StatelessWidget {

  final MarkdownItalic _token;
  final bool? _isBold;
  final bool? _isStrike;

  const MarkdownItalicScreen({super.key, required MarkdownItalic token, required bool? isBold, bool? isStrike}) :
    _token = token,
    _isBold = isBold,
    _isStrike = isStrike
    ;

  @override
  Widget build(BuildContext context) {
    return MarkdownInlineScreen(tokens: _token.tokens, isBold: _isBold, isItalic: true, isStrike: _isStrike);
  }
}