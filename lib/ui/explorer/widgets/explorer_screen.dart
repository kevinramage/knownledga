import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/ui/dialog/widgets/create_project_screen.dart';
import 'package:knownledga/ui/explorer/view_models/explorer_modelView.dart';
import 'package:knownledga/ui/explorer/widgets/project_screen.dart';

class ExplorerScreen extends StatefulWidget {

  final ExplorerModelView _modelView;

  const ExplorerScreen({super.key, required ExplorerModelView explorer}) : _modelView = explorer;

  @override
  State<StatefulWidget> createState() {
    return _ExplorerScreen();
  }
}

class _ExplorerScreen extends State<ExplorerScreen> {

  @override
  void initState() {
    super.initState();
    final pj = Project(name: "Test2");
    widget._modelView.addProject(pj);
    //widget._explorerModelView.getApi();
    //widget._explorerModelView.getApi().project.registerGetProjects(() { return _model.projects; });
    //widget.api.project.registerSetProjects((pjs) { setState(() { _model.projects = pjs; }); });

    // Load project
    /*
    widget.api.project.loadProjects().then((pjs) {
      setState(() { _model.projects = pjs; });
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget._modelView, builder: (context, builder) {
      return Container(width: 350, height: double.infinity, color: Colors.grey.shade700,
        child: Column(children: [
          Container(decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.white54))), 
          child: Padding(padding: const EdgeInsets.all(10), child: Row(children: [
            const Text("Explorer", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 16)),
            const Expanded(child: Text("")),
            _buildProjectPopupMenuItem()
          ]))),
          _buildProjects()
      ]));
    });
  }

  Widget _buildProjectPopupMenuItem() {
    return PopupMenuButton(iconColor: Colors.white, itemBuilder: (BuildContext context) {
      return [
          PopupMenuItem(child: const Text("Create new project"), onTap: () async {
            final applicationViewModel = widget._modelView.applicationViewModel;
            final projectViewModel = await DialogCreateProjectScreen().show(context, applicationViewModel);
            final project = Project(name: projectViewModel.projectName);
            widget._modelView.addProject(project);
          })
      ];
    });
  }

  Widget _buildProjects() {
    return Expanded(child: ListView(children: widget._modelView.projects.map((p) { 
      return ProjectExplorerScreen(api: widget._modelView.api, project: p); 
    }).toList()));
  }
}