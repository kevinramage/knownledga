import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/models/projectelement.dart';
import 'package:knownledga/utils/services/api.dart';

class ElementExplorerScreen extends StatefulWidget {
  final Api api;
  final Project project;
  final ProjectElement element;

  const ElementExplorerScreen({super.key, required this.api, required this.project, required this.element});

  @override
  State<StatefulWidget> createState() {
    return _ElementExplorerScreen();
  }
}

class _ElementExplorerScreen extends State<ElementExplorerScreen> {

  String renameFileName = "";
  bool renaming = false;

  @override
  Widget build(BuildContext context) {
    if (widget.element.type == ProjectElement.typeFolder) {
      return buildFolder();
    } else if (widget.element.type == ProjectElement.typeFile) {
      return buildElement();
    } else {
      return const Text("Invalid type");
    }
  }

  Widget buildFolder() {
    List<Widget> subElts = [];
    Widget eltWidget = Text(widget.element.name, style: const TextStyle(color: Colors.white, fontSize: 14));
    if (renaming) {
      eltWidget = TextField(autofocus: true, controller: TextEditingController(text: renameFileName));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 0),
      child: ExpansionTile(
        title: Row(children: [
          eltWidget,
          const Expanded(child: Text("")),
          PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              const PopupMenuItem(child: Text("Open")),
              const PopupMenuItem(child: Text("Renaming")),
              PopupMenuItem(child: const Text("Delete"), onTap: () {
                //widget.project.elements.removeWhere((e) => e.name == widget.element.name);
                //widget.api.project.updateProject();
              })
            ];
          })
        ]),
        leading: const Icon(Icons.folder),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: subElts,
      )
    );
  }
  Widget buildElement() {
    Widget eltWidget = Text(widget.element.name, style: const TextStyle(color: Colors.white, fontSize: 14));
    if (renaming) {
      eltWidget = SizedBox(width: 200, child:
        KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: (value) {
            if (value.physicalKey == PhysicalKeyboardKey.enter) {
              widget.api.project.renameFile(widget.element, renameFileName);
              setState(() { renaming = false; });
            }
            if (value.physicalKey == PhysicalKeyboardKey.escape) {
              setState(() { renaming = false; });
            }
          }, 
          child: TextField(key: UniqueKey(), autofocus: true, controller: TextEditingController(text: renameFileName), onChanged: (value) {
            setState(() { renameFileName = value; });
          })
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 0),
      child: ListTile(
        title: Row(children: [
          InkWell(
            onTap: () {
              widget.api.project.openFile(widget.element);
            },
            child: eltWidget
          ),
          const Expanded(child: Text("")),
          PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(child: const Text("Open"), onTap: () {
                widget.api.project.openFile(widget.element);
              }),
              PopupMenuItem(child: const Text("Rename"), onTap: (){
                setState(() {
                  renaming = true;
                  renameFileName = widget.element.name;
                });
              }),
              PopupMenuItem(child: const Text("Delete"), onTap: () {
                widget.api.project.deleteFile(widget.project, widget.element);
              })
            ];
          })
        ]),
        iconColor: Colors.white,
        leading: const Icon(Icons.newspaper),
      )
    );
  }
}