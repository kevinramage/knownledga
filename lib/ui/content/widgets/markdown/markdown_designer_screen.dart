import 'package:flutter/material.dart';

class MarkdownDesignerScreen extends StatefulWidget {

  //final EditorViewModel _editorViewModel;

  /*
  const MarkdownDesignerScreen({super.key, required EditorViewModel editorViewModel})
     : _editorViewModel = editorViewModel;
  */
  const MarkdownDesignerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MarkdownDesignerScreen();
  }
}

class _MarkdownDesignerScreen extends State<MarkdownDesignerScreen> {

  @override
  Widget build(BuildContext context) {
    return const Text("Designer");
  }
}