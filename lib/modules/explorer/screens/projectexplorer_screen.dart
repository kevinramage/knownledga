import 'package:flutter/material.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/screens/elementexplorer_screen.dart';
import 'package:knownledga/utils/services/api.dart';

class ProjectExplorerScreen extends StatefulWidget {
  final Project project;
  final Api api;

  const ProjectExplorerScreen({super.key, required this.api, required this.project});

  @override
  State<StatefulWidget> createState() {
    return _ProjectExplorerScreen();
  }
}

class _ProjectExplorerScreen extends State<ProjectExplorerScreen> {

  String renameProjectName = "";

  @override
  void initState() {
    renameProjectName = widget.project.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget eltWidget = Text(widget.project.name, style: const TextStyle(color: Colors.white, decoration: TextDecoration.none));
    if (widget.project.isCreating) {
      eltWidget = Expanded(child: TextField(autofocus: true, controller: TextEditingController(text: renameProjectName)));
    }
    return ExpansionTile(
      leading: const Icon(Icons.work, color: Colors.white),
      initiallyExpanded: true,
      title: Row(children: [
        eltWidget,
        const Expanded(child: Text("")),
        PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            const PopupMenuItem(enabled: false, child: Text("Rename project")),
            const PopupMenuItem(enabled: false, child: Text("Configure project")),
            PopupMenuItem(child: const Text("Delete project"), onTap:(){
              widget.api.project.deleteProject(widget.project.name);
            }),
            const PopupMenuDivider(),
            PopupMenuItem(child: const Text("Create folder"), onTap: () {
              final folderName = widget.api.project.getValidFolderName(widget.project);
              widget.api.project.createFolder(widget.project, folderName);
            }),
            PopupMenuItem(child: const Text("Create file"), onTap: () {
              final eltName = widget.api.project.getValidElementName(widget.project);
              widget.api.project.createFile(widget.project, eltName);
            }),
            
          ];
        })
      ]),
      collapsedIconColor: Colors.white,
      children: widget.project.elements.map((e) { return ElementExplorerScreen(api: widget.api, project: widget.project, element: e); }).toList(),
    );
  }
}