import 'package:flutter/material.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/screens/elementexplorer_screen.dart';
import 'package:knownledga/utils/services/api.dart';

class ProjectExplorerScreen extends StatelessWidget {

  final Project project;
  final Api api;

  const ProjectExplorerScreen({super.key, required this.api, required this.project});

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: ExpansionTile(
      leading: const Icon(Icons.work, color: Colors.white),
      initiallyExpanded: true,
      title: Row(children: [
        Text(project.name, style: const TextStyle(color: Colors.white, decoration: TextDecoration.none)),
        const Expanded(child: Text("")),
        PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            const PopupMenuItem(enabled: false, child: Text("Rename project")),
            const PopupMenuItem(enabled: false, child: Text("Configure project")),
            PopupMenuItem(child: const Text("Delete project"), onTap:(){
              api.project.deleteProject(project.name);
            }),
            const PopupMenuDivider(),
            PopupMenuItem(enabled: false, child: const Text("Create folder"), onTap: () {
              //final elt = ProjectElement(type: ProjectElement.typeFolder, name: "New Folder 1", project: project);
              //project.elements.add(elt);
              //api.project.updateProject();
            }),
            PopupMenuItem(child: const Text("Create file"), onTap: () {
              final eltName = api.project.getValidElementName(project);
              api.project.createFile(project, eltName);
            }),
            
          ];
        })
      ]),
      collapsedIconColor: Colors.white,
      children: project.elements.map((e) { return ElementExplorerScreen(api: api, project: project, element: e); }).toList(),
      )
    );
  }
}