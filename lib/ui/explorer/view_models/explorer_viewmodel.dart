import 'package:flutter/material.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class ExplorerViewModel with ChangeNotifier {
  final ApplicationViewModel _application;
  List<ProjectViewModel> _projects = [];

  ExplorerViewModel({required ApplicationViewModel application}) : _application = application;
  
  void addProject(ProjectViewModel projectViewModel) {
    if (projectViewModel.project.name != "") {
      _projects.add(projectViewModel);
      notifyListeners();
    }
  }

  void loadProjects() async {
    _projects = await _application.loadAllProjects();
    notifyListeners();
  }

  ApplicationViewModel get applicationViewModel {
    return _application;
  }
  List<ProjectViewModel> get projects {
    return _projects;
  }
}