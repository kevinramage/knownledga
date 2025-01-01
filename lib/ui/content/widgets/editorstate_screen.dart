import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class EditorStateScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const EditorStateScreen({super.key, required EditorViewModel editorViewModel}) : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _EditorStateScreen();
  }
}

class _EditorStateScreen extends State<EditorStateScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: viewModel, builder: (context, builder) {
      return Container(
        alignment: Alignment.topLeft,
        color: Colors.grey.shade800,
        child: _buildStateScreen()
      );
    });
  }

  Widget? _buildStateScreen() {
    final elt = viewModel.currentElement;
    if (elt != null) {
      return _buildState();
    } else {
      return null;
    }
  }

  Widget _buildState() {
    final model = widget._editorViewModel.currentElement as ElementViewModel;
    return ListenableBuilder(listenable: model, builder: (context, builder) {
      return Container(height: 30, color: Colors.grey.shade700, child: Row(children: [
        Padding(padding: const EdgeInsets.only(right: 10), child: Text(model.state, style: const TextStyle(fontSize: 14, color: Colors.white))),
        Text("Ln ${model.lineNumber}, Col ${model.columnNumber}", style: const TextStyle(fontSize: 14, color: Colors.white)),
        const Expanded(child: Text("")),
        Text("Mode: ${widget._editorViewModel.viewMode}", style: const TextStyle(fontSize: 14, color: Colors.white)),
        const Expanded(child: Text("")),
        const Padding(padding: EdgeInsets.only(right: 10), child: Text("UTF-8", style: TextStyle(fontSize: 14, color: Colors.white))),
        const Padding(padding: EdgeInsets.only(right: 10), child: Text("CRLF", style: TextStyle(fontSize: 14, color: Colors.white))),
        Padding(padding: const EdgeInsets.only(right: 10), child: Text(model.fileTypeName, style: const TextStyle(fontSize: 14, color: Colors.white)))
      ]));
    });
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}