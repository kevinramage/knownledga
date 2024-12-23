import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';

class EditorFileScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const EditorFileScreen({super.key, required EditorViewModel editorViewModel}) : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _EditorFileScreen();
  }
}

class _EditorFileScreen extends State<EditorFileScreen> {

  final TextEditingController _textController = TextEditingController(text: "");

  @override
  void initState() {
    /*
    final elt = widget.activeElement;
    if (elt != null) {
      setState(() { content = elt.content; });
    }
    */
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EditorFileScreen oldWidget) {
    /*
    final newElt = widget.activeElement;
    //final oldElt = oldWidget.activeElement;
    if (newElt != null ) {
      setState(() { content = newElt.content; });
    }
    */
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: buildScreen());
  }

  buildScreen() {
    final elt = viewModel.currentElement;
    if (elt != null) {
      return Padding(padding: const EdgeInsets.only(left: 10), child: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS): const SaveFileIntent()
        },
        child: Actions(
          actions: {
            SaveFileIntent: CallbackAction(onInvoke: (i) {
              /*
              elt.saved = true;
              widget.api.project.saveFile(elt, content);
              widget.api.content.setActiveElt(elt);
              return null;
              */
              return null;
            })
          },
          child: TextField(
            key: UniqueKey(),
            autofocus: true,
            controller: _textController,
            scrollController: ScrollController(keepScrollOffset: true),
            maxLines: 200,
            onChanged: (value) {
              /*
              elt.content = value;
              elt.saved = false;
              widget.api.content.openFile(elt);
              setState(() { content = value; });
              */
            },
          )
        )
      ));
    } else {
      return const Text("");
    }
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}

class SaveFileIntent extends Intent {
  const SaveFileIntent();
}