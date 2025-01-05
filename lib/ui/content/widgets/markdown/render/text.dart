import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/text.dart';

class MarkdownTextScreen extends StatelessWidget {

  final MarkdownText _token;
  final bool? _isBold;
  final bool? _isItalic;
  final bool? _isStrike;

  const MarkdownTextScreen({super.key, required MarkdownText token, bool? isBold, bool? isItalic, bool? isStrike}) :
    _isBold = isBold,
    _isItalic = isItalic,
    _isStrike = isStrike,
    _token = token
  ;

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = isBold ? FontWeight.bold : FontWeight.normal;
    FontStyle fontStyle = isItalic ? FontStyle.italic : FontStyle.normal;
    TextDecoration textDecoration = isStrike ? TextDecoration.lineThrough : TextDecoration.none;
    return Padding(padding: const EdgeInsets.only(right: 2), child: Text(_token.text, textAlign: TextAlign.start, style: TextStyle(decoration: textDecoration, fontStyle: fontStyle, fontWeight: fontWeight, fontSize: 14)));
  }

  bool get isBold {
    return _isBold != null && _isBold == true;
  }

  bool get isItalic {
    return _isItalic != null && _isItalic == true;
  }

  bool get isStrike {
    return _isStrike != null && _isStrike == true;
  }
}