import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/strike.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/inline.dart';

class MarkdownStrikeScreen extends StatelessWidget {

  final MarkdownStrike _token;
  final bool? _isBold;
  final bool? _isItalic;

  const MarkdownStrikeScreen({super.key, required MarkdownStrike token, required bool? isBold, bool? isItalic}) :
    _token = token,
    _isBold = isBold,
    _isItalic = isItalic
    ;

  @override
  Widget build(BuildContext context) {
    return MarkdownInlineScreen(tokens: _token.tokens, isBold: _isBold, isItalic: _isItalic, isStrike: true);
  }
}