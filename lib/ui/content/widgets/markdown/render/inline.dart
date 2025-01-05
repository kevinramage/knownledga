import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/bold.dart';
import 'package:knownledga/data/repositories/markdown/italic.dart';
import 'package:knownledga/data/repositories/markdown/link.dart';
import 'package:knownledga/data/repositories/markdown/strike.dart';
import 'package:knownledga/data/repositories/markdown/text.dart';
import 'package:knownledga/data/repositories/markdown/token.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/bold.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/italic.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/link.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/strike.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/text.dart';

class MarkdownInlineScreen extends StatelessWidget {

  final List<MarkdownToken> _tokens;
  final bool? _isBold;
  final bool? _isItalic;
  final bool? _isStrike;

  const MarkdownInlineScreen({super.key, required List<MarkdownToken> tokens, bool? isBold, bool? isItalic, bool? isStrike}) :
    _isBold = isBold,
    _isItalic = isItalic,
    _isStrike = isStrike,
    _tokens = tokens
  ;

  @override
  Widget build(BuildContext context) {
    return Row(children: _tokens.map((t) => _buildToken(t)).toList());
  }

  Widget _buildToken(MarkdownToken token) {
    if (token is MarkdownLink) {
      return MarkdownLinkScreen(token: token);
    } else if (token is MarkdownBold) {
      return MarkdownBoldScreen(token: token, isItalic: _isItalic, isStrike: _isStrike);
    } else if (token is MarkdownItalic) {
      return MarkdownItalicScreen(token: token, isBold: _isBold, isStrike: _isStrike);
    } else if (token is MarkdownStrike) {
      return MarkdownStrikeScreen(token: token, isBold: _isBold, isItalic: _isItalic);
    } else if (token is MarkdownText) {
      return MarkdownTextScreen(token: token, isBold: _isBold, isItalic: _isItalic, isStrike: _isStrike);
    } else {
      throw Exception("MarkdownInlineScreen._buildToken - Invalid token type");
    }
  }
}