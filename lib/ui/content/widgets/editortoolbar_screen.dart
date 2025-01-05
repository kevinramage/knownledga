import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';

class EditorToolbarScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const EditorToolbarScreen({super.key, required EditorViewModel editorViewModel}) :
    _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _EditorToolbarScreen();
  }
}

class _EditorToolbarScreen extends State<EditorToolbarScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: viewModel, builder: (context, builder) {
      return Container(
        alignment: Alignment.topLeft,
        color: Colors.grey.shade800,
        child: _buildToolbarScreen()
      );
    });
  }

  _buildToolbarScreen() {
    final elt = viewModel.currentElement;
    if (elt != null) {
      return _buildToolbar();
    } else {
      return null;
    }
  }

  _buildToolbar() {
    final model = widget._editorViewModel;
    return ListenableBuilder(listenable: model, builder: (context, builder) {
      //List<bool> isSelected = [false, false, false];
      List<bool> isSelected = [false, false];
      isSelected[model.viewIndex] = true;
      return Container(height: 50, color: Colors.grey.shade600, child: Row(children: [
        const Expanded(child: Text("")),
        ToggleButtons(
          isSelected: isSelected,
          constraints: const BoxConstraints(maxHeight: 30),
          selectedColor: Colors.white,
          onPressed: (index) {
            model.updateViewIndex(index);
          },
          children: [
            _buildEditorModeIcon("Editor", Icons.raw_on),
            _buildEditorModeIcon("Render", Icons.tv)
            //Icon(Icons.edit),
          ],
        ),
        const SizedBox(width: 20)
      ]));
    });
  }

  Widget _buildEditorModeIcon(String editorName, IconData editorIcon) {
    return SizedBox(height: 30, child: Padding(padding: const EdgeInsets.only(top: 5, bottom: 5), child: Row(children: [
        Padding(padding: const EdgeInsets.only(left: 10), child: Icon(editorIcon, size: 16)),
        Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: Text(editorName, style: const TextStyle(fontSize: 16)))
    ])));
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}