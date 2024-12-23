import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/ui/core/widgets/expansion_element.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';
import 'package:knownledga/ui/explorer/widgets/element_screen.dart';

class ProjectExplorerScreen extends StatefulWidget {
  final ProjectViewModel _modelView;

  const ProjectExplorerScreen({super.key, required ProjectViewModel projectViewModel}):
    _modelView = projectViewModel;

  @override
  State<StatefulWidget> createState() {
    return _ProjectExplorerScreen();
  }
}

class _ProjectExplorerScreen extends State<ProjectExplorerScreen> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget._modelView, builder: (context, builder) {
      return ExpansionElement(
        leading: _buildProjectType(),
        title: _buildProjectName(),
        expanded: widget._modelView.projectExpanded,
        commands: [
          _buildAddElementBtn(),
          _buildAddFolderBtn(),
          _buildSyncBtn()
        ],
        children: [
          Padding(padding: const EdgeInsets.only(top: 3, left: 5), child: Column(children: _buildChildren()))
        ],
      );
    });
  }

  Widget _buildProjectName() {
    return Text(widget._modelView.project.name.toUpperCase(), style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 12, 
      decoration: TextDecoration.none
    ));
  }

  Icon _buildProjectType() {
    if (widget._modelView.project.type == ProjectType.gitProject) {
      return const Icon(Icons.explore, size: 15, color: Colors.white);
    } else {
      return const Icon(Icons.work, size: 15, color: Colors.white);
    }
  }

  Widget _buildAddElementBtn() {
    return IconButton(
      onPressed: () {
        widget._modelView.addBuildingElement();
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.post_add, size: 15, color: Colors.white)
    );
  }

  Widget _buildAddFolderBtn() {
    return IconButton(
      onPressed: () {},
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.create_new_folder, size: 15, color: Colors.white)
    );
  }

  Widget _buildSyncBtn() {
    return IconButton(
      onPressed: () { 
        widget._modelView.push(); 
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.sync, size: 15, color: Colors.white)
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> widgets = [];
    if (widget._modelView.builtElement != null) {
      widgets.add(ElementExplorerScreen(elementViewModel: widget._modelView.builtElement as ElementViewModel));
    }
    widgets.addAll(widget._modelView.elements.map((e) => ElementExplorerScreen(elementViewModel: e) ));
    return widgets;
  }
}