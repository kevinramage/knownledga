import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/orderedlist.dart';

class MarkdownOrderedScreen extends StatelessWidget {
  final MarkdownOrderedList _token;

  const MarkdownOrderedScreen({super.key, required MarkdownOrderedList token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    var widgets = _token.elements.map((e) => _buildElement(e) ).toList();
    return Column(children: widgets);
  }

  Widget _buildElement(MarkdownOrderedListElement token) {
    if (token is MarkdownOrderedListSubList) {
      return _buildSubList(token);
    } else if (token is MarkdownOrderedListContent) {
      return _buildContent(token);
    } else {
      throw Exception("MarkdownOrderedList - Invalid token element");
    }
  }

  _buildSubList(MarkdownOrderedListSubList subList) {
    var widgets = subList.elements.map((e) => _buildElement(e) ).toList();
    return Column(children: widgets);
  }

  _buildContent(MarkdownOrderedListContent token) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${token.index}.", style: const TextStyle( fontSize: 16, height: 1.55)),
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