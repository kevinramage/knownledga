import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class FileNameScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const FileNameScreen({super.key, required EditorViewModel editorViewModel}) : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _FileNameScreen();
  }
}

class _FileNameScreen extends State<FileNameScreen> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: viewModel, builder: (context, builder) {
      return Container(
        alignment: Alignment.topLeft,
        color: Colors.grey.shade800,
        child: buildTabFile()
      );
    });
  }

  Widget? buildTabFile() {
    final elt = viewModel.currentElement;
    if (elt != null) {
      return _buildTabWidget(elt);
    } else {
      return null;
    }
  }

  Widget _buildTabWidget(ElementViewModel elt) {
    return ListenableBuilder(listenable: elt, builder: (context, child) {
      return Container(
        width: 180, height: 25,
        color: Colors.grey.shade600,
        child: Padding(padding: const EdgeInsets.only(left: 5, top: 2),
          child: Row(children: [
            _buildTabText(elt),
            const Expanded(child: Text("")),
            _buildTabIcon(elt),
            _buildTabCloseBtn(elt)
          ]
        ))
      );
    });
  }

  Widget _buildTabText(ElementViewModel elt) {
    return Text(elt.shortElementName, textAlign: TextAlign.left, 
      style: const TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 12),
    );
  }

  Widget _buildTabIcon(ElementViewModel elt) {
    if (elt.isModified) {
      return const Icon(Icons.circle, color: Colors.white, size: 12);
    } else {
      return const Text("");
    }
  }

  Widget _buildTabCloseBtn(ElementViewModel elt) {
    return IconButton(icon: const Icon(Icons.close, color: Colors.white), padding: const EdgeInsets.all(0), onPressed: () {
      viewModel.closeCurrentElement();
    });
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}