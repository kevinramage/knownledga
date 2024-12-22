import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/services/api.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';

class ExplorerModelView with ChangeNotifier {
  final ApplicationViewModel _application;
  final List<Project> _projects = [];

  ExplorerModelView({required ApplicationViewModel application}) : _application = application;
  
  void addProject(Project project) {
    if (project.name != "") {
      _projects.add(project);
      notifyListeners();
    }
  }


  Api get api {
    return _application.api;
  }
  ApplicationViewModel get applicationViewModel {
    return _application;
  }
  List<Project> get projects {
    return _projects;
  }
}