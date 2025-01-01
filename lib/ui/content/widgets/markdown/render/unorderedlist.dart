import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/unorderedList.dart';

class MarkdownUnorderedScreen extends StatelessWidget {
  final MarkdownUnorderedList _token;

  const MarkdownUnorderedScreen({super.key, required MarkdownUnorderedList token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    var widgets = _token.elements.map((e) => _buildElement(e) ).toList();
    return Column(children: widgets);
  }

  Widget _buildElement(MarkdownUnorderedListElement token) {
    if (token is MarkdownUnorderedListSubList) {
      return _buildSubList(token);
    } else if (token is MarkdownUnorderedListContent) {
      return _buildContent(token);
    } else {
      throw Exception("MarkdownUnorderedList - Invalid token element");
    }
  }

  _buildSubList(MarkdownUnorderedListSubList subList) {
    var widgets = subList.elements.map((e) => _buildElement(e) ).toList();
    return Column(children: widgets);
  }

  _buildContent(MarkdownUnorderedListContent token) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('\u2022', style: TextStyle( fontSize: 16, height: 1.55)),
        const SizedBox(width: 5),
        Expanded(child: Text(token.content, 
          textAlign: TextAlign.left,
          softWrap: true,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.6),
            height: 1.55,
          )
        ))
      ]
    );
  }
}

//https://stackoverflow.com/questions/49625730/how-do-i-add-a-bullet-or-create-a-bulleted-list-in-flutter