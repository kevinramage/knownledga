import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/checklist.dart';

class MarkdownCheckListScreen extends StatelessWidget {
  final MarkdownChecklist _token;

  const MarkdownCheckListScreen({super.key, required MarkdownChecklist token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    return Column(children: _token.elements.map((e) => _buildElement(e)).toList());
  }

  Widget _buildElement(MarkdownChecklistElement element) {
    return Row(children: [
      Checkbox(value: element.checked, onChanged: (_){}),
      Text(element.title)
    ]);
    //return CheckboxListTile(value: element.checked, title: Text(element.title), onChanged: (_){});
  }
}