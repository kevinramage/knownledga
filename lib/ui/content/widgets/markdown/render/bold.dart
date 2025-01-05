import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/bold.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/inline.dart';

class MarkdownBoldScreen extends StatelessWidget {

  final MarkdownBold _token;
  final bool? _isItalic;
  final bool? _isStrike;

  const MarkdownBoldScreen({super.key, required MarkdownBold token, bool? isItalic, bool? isStrike}) :
    _token = token,
    _isItalic = isItalic,
    _isStrike = isStrike
    ;

  @override
  Widget build(BuildContext context) {
    return MarkdownInlineScreen(tokens: _token.tokens, isBold: true, isItalic: _isItalic, isStrike: _isStrike);
  }
}