import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';

class FileNameScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const FileNameScreen({super.key, required EditorViewModel editorViewModel}) : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _FileNameScreen();
  }
}

class _FileNameScreen extends State<FileNameScreen> {

  bool saved = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FileNameScreen oldWidget) {
    /*
    final newElt = widget.activeElement;
    if (newElt != null) {
      setState(() { saved = newElt.saved; });
    }
    */
    super.didUpdateWidget(oldWidget);
  }

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
      final savedSection = saved ? const Text("") : const Icon(Icons.circle, color: Colors.white);
      return Container(
        width: 180, height: 25,
        color: Colors.grey.shade600,
        child: Padding(padding: const EdgeInsets.only(left: 5, top: 2),
          child: Row(children: [
            Text(elt.elementName, textAlign: TextAlign.left, 
              style: const TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 12)
            ),
            const Expanded(child: Text("")),
            savedSection,
            IconButton(icon: const Icon(Icons.close, color: Colors.white), padding: const EdgeInsets.all(0), onPressed: () {
              //widget.api.content.setActiveElt(null);
            })
          ]
        ))
      );
    } else {
      return null;
    }
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}