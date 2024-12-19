import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knownledga/data/services/api.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';

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
    List<Widget> subElts = widget.element.subElements.map((e) => ElementExplorerScreen(api: widget.api, project: widget.project, element: e)).toList();
    Widget eltWidget = Text(widget.element.name, style: const TextStyle(color: Colors.white, fontSize: 14));
    if (renaming) {
      eltWidget = TextField(autofocus: true, controller: TextEditingController(text: renameFileName));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Row(children: [
          eltWidget,
          const Expanded(child: Text("")),
          PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              const PopupMenuItem(enabled: false, child: Text("Open")),
              const PopupMenuItem(enabled: false, child: Text("Renaming")),
              PopupMenuItem(child: const Text("Delete"), onTap: () {
                widget.api.project.deleteFile(widget.element);
              }),
              const PopupMenuDivider(),
              PopupMenuItem(child: const Text("Create folder"), onTap: () {
                final folderName = widget.api.project.getValidFolderName(widget.element);
                widget.api.project.createFolder(widget.element, folderName);
              }),
              PopupMenuItem(child: const Text("Create file"), onTap: () {
                final folderName = widget.api.project.getValidElementName(widget.element);
                widget.api.project.createFile(widget.element, folderName);
              }),
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
                widget.api.project.deleteFile(widget.element);
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