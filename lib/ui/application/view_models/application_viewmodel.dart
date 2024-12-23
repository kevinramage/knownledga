import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/api.dart';
import 'package:knownledga/ui/content/view_models/content_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class ApplicationViewModel with ChangeNotifier {
  late ContentViewModel contentViewModel;
  final Api _api;

  ApplicationViewModel({required Api api}) : _api = api;

  Future<List<ProjectViewModel>> loadAllProjects() async {
    final projects = await _api.project.loadAllProjects();
    return projects.map((p) => ProjectViewModel(applicationViewModel: this, project: p)).toList(); 
  }

  Future<ProjectViewModel> createProject(ProjectViewModel projectViewModel) async {
    final project = await _api.project.createProject(projectViewModel.project);
    return ProjectViewModel(applicationViewModel: this, project: project);
  }

  Future<ElementViewModel> createProjectElement(ProjectViewModel projectViewModel, ElementViewModel elementViewModel) async {
    final element = await _api.project.createProjectElement(elementViewModel.element);
    return ElementViewModel(projectViewModel: projectViewModel, element: element);
  }

  Future<void> openElement(ElementViewModel elementViewModel) async {
    await _api.project.loadElement(elementViewModel.element);
    //final elementModel = ElementViewModel(projectViewModel: projectViewModel, element: element)
    contentViewModel.defineCurrentElement(elementViewModel);
  }

  Future<void> saveElement(ElementViewModel elementViewModel) async {
    await _api.project.saveElementContent(elementViewModel.element);
  }

  Future<void> renameElement(ElementViewModel elementViewModel, String newName) async {
    await _api.project.renameElement(elementViewModel.element, newName);
  }

  Future<void> deleteElement(ElementViewModel elementViewModel) async {
    await _api.project.deleteElement(elementViewModel.element);
  }

  String getHomeDirectory() {
    return _api.project.getHomeDirectory();
  }

  /*
  Future<ProjectViewModel> loadProject(ProjectViewModel projectViewModel) async{
    final project = await _api.project.loadProject(projectViewModel.project);
    return ProjectViewModel(applicationViewModel: this, project: project);
  */

  
  String isValidProjectName(String projectName) {
    final regex = RegExp(r'^[a-z|A-Z|0-9|_|\\-]{3,}$');
    return regex.hasMatch(projectName) ? "" : "A project name must have at least 3 characters and contains only alphanumeric characters or '-' '_' characters";
  }
  String isValidProjectLocation(String path) {
    String invalidPath = "C:\\Knownledga\\test";
    return path != invalidPath ? "" : "A project with same name already existed";
  }
}