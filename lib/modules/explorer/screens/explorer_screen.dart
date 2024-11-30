import 'package:flutter/material.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/screens/projectexplorer_screen.dart';
import 'package:knownledga/utils/services/api.dart';

class ExplorerScreen extends StatefulWidget {

  final Api api;

  const ExplorerScreen({super.key, required this.api});

  @override
  State<StatefulWidget> createState() {
    return _ExplorerScreen();
  }
}

class _ExplorerScreen extends State<ExplorerScreen> {

  List<Project> projects = [];

  @override
  void initState() {
    super.initState();
    widget.api.project.registerGetProjects(() { return projects; });
    widget.api.project.registerSetProjects((pjs) { setState(() { projects = pjs; }); });

    // Load project
    widget.api.project.loadProjects().then((pjs) {
      setState(() { projects = pjs; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 350, height: double.infinity, color: Colors.grey.shade700,
    child: Column(children: [
      Container(decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.white54))), 
      child: Padding(padding: const EdgeInsets.all(10), child: Row(children: [
        const Text("Explorer", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 16)),
        const Expanded(child: Text("")),
        PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
          return [
              PopupMenuItem(child: const Text("Create new project"), onTap: () {
                final projectName = widget.api.project.getValidProjectName();
                widget.api.project.createProject(projectName);
              })
          ];
        })
      ]))),
      Expanded(child: ListView(children: projects.map((p) { return ProjectExplorerScreen(api: widget.api, project: p); }).toList()))
    ]));
  }
}