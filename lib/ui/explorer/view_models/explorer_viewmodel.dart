import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/api.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    Project project = Project(name: "Project1");
    ProjectViewModel projectViewModel = ProjectViewModel(applicationViewModel: _application, project: project);
    ProjectElement elt1 = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md", project: project);
    ProjectElement elt2 = ProjectElement(type: ProjectElement.typeFile, name: "Element2.md", project: project);
    ElementViewModel elt1ViewModel = ElementViewModel(projectViewModel: projectViewModel, element: elt1);
    ElementViewModel elt2ViewModel = ElementViewModel(projectViewModel: projectViewModel, element: elt2);
    projectViewModel.addElement(elt1ViewModel);
    projectViewModel.addElement(elt2ViewModel);
    _projects = [ projectViewModel ];
    notifyListeners();
  }

  Api get api {
    return _application.api;
  }
  ApplicationViewModel get applicationViewModel {
    return _application;
  }
  List<ProjectViewModel> get projects {
    return _projects;
  }
}