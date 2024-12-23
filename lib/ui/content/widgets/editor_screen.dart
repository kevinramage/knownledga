import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';
import 'package:knownledga/ui/content/widgets/filename_screen.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';

class ContentEditorScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const ContentEditorScreen({super.key, required EditorViewModel editorViewModel}) : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _ContentEditorScreen();
  }
}

class _ContentEditorScreen extends State<ContentEditorScreen> {

  ProjectElement? activeElement;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      width: double.infinity, 
      color: Colors.grey.shade600,
      child: Column(children: [
        FileNameScreen(editorViewModel: viewModel),
        //EditorFileScreen(activeElement: activeElement, api: widget.api)
      ])
    ));
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}