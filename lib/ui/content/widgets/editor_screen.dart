import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/widgets/editorfile_screen.dart';
import 'package:knownledga/ui/content/widgets/filename_screen.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/api.dart';

class ContentEditorScreen extends StatefulWidget {

  final Api api;

  const ContentEditorScreen({super.key, required this.api});

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
    widget.api.content.registerGetActiveElt(() => activeElement);
    widget.api.content.registerSetActiveElt((ProjectElement? elt) { setState(() { activeElement = elt; }); });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      width: double.infinity, 
      color: Colors.grey.shade600,
      child: Column(children: [
        FileNameScreen(activeElement: activeElement, api: widget.api),
        EditorFileScreen(activeElement: activeElement, api: widget.api)
      ])
    ));
  }
}