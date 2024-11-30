import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knownledga/modules/explorer/models/projectelement.dart';
import 'package:knownledga/utils/services/api.dart';

class EditorFileScreen extends StatefulWidget {

  final ProjectElement? activeElement;
  final Api api;

  const EditorFileScreen({super.key, required this.api, required this.activeElement});

  @override
  State<StatefulWidget> createState() {
    return _EditorFileScreen();
  }
}

class _EditorFileScreen extends State<EditorFileScreen> {

  String content = "";

  @override
  void initState() {
    final elt = widget.activeElement;
    if (elt != null) {
      setState(() { content = elt.content; });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EditorFileScreen oldWidget) {
    final newElt = widget.activeElement;
    //final oldElt = oldWidget.activeElement;
    if (newElt != null ) {
      setState(() { content = newElt.content; });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: buildScreen());
  }

  buildScreen() {
    final elt = widget.activeElement;
    if (elt != null) {
      return Padding(padding: const EdgeInsets.only(left: 10), child: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS): const SaveFileIntent()
        },
        child: Actions(
          actions: {
            SaveFileIntent: CallbackAction(onInvoke: (i) {
              elt.saved = true;
              widget.api.project.saveFile(elt, content);
              widget.api.content.setActiveElt(elt);
              return null;
            })
          },
          child: TextField(
            key: UniqueKey(),
            autofocus: true,
            controller: TextEditingController(
              text: content
            ),
            scrollController: ScrollController(keepScrollOffset: true),
            maxLines: 200,
            onChanged: (value) {
              elt.content = value;
              elt.saved = false;
              widget.api.content.openFile(elt);
              setState(() { content = value; });
            },
          )
        )
      ));
    } else {
      return const Text("");
    }
  }
}

class SaveFileIntent extends Intent {
  const SaveFileIntent();
}