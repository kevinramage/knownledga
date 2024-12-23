import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class ProjectViewModel with ChangeNotifier {
  final ApplicationViewModel _applicationViewModel;
  final Project _project;
  bool _projectExpanded = false;
  List<ElementViewModel> _projectElements = [];
  ElementViewModel? _buildingElement;
  

  ProjectViewModel({ required ApplicationViewModel applicationViewModel, required Project project}) : 
    _applicationViewModel = applicationViewModel, 
    _project = project {
      _projectElements = project.elements.map((e) => ElementViewModel(projectViewModel: this, element: e)).toList();
    }

  addBuildingElement() async {
    //final element = ProjectElement(type: ProjectElement.typeFile, name: "Element1", project: _project);
    //_buildingElement = ElementViewModel(projectViewModel: this, element: element);
    //_buildingElement!.isBuilt = true;
    final element = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md");
    final elementViewModel = ElementViewModel(projectViewModel: this, element: element);
    elementViewModel.element.path = "$projectPath\\${elementViewModel.elementName}";
    final newElement = await _applicationViewModel.createProjectElement(this, elementViewModel);
    _projectElements.add(newElement);
    _projectExpanded = true;
    notifyListeners();
  }
  Future<void> addElement(ElementViewModel elementViewModel) async {
    elementViewModel.element.path = "$projectPath\\${elementViewModel.elementName}";
    final newElement = await _applicationViewModel.createProjectElement(this, elementViewModel);
    _projectElements.add(newElement);
    _projectExpanded = true;
    notifyListeners();
  }
  Future<void> deleteElement(ElementViewModel element) async {
    await _applicationViewModel.deleteElement(element);
    _projectElements = _projectElements.where((e) => e != element).toList();
    notifyListeners();
  }
  void addDirectory(ElementViewModel element) {
    _projectElements.add(element);
  }
  Future<void> push() async {
    await _applicationViewModel.push(this);
  }

  Project get project {
    return _project;
  }

  ApplicationViewModel get applicationViewModel {
    return _applicationViewModel;
  }

  List<ElementViewModel> get elements {
    return _projectElements;
  }

  ElementViewModel? get builtElement {
    return _buildingElement;
  }

  String get projectPath {
    return _project.path;
  }

  String get gitUrl {
    return _project.gitUrl;
  }

  bool get projectExpanded {
    return _projectExpanded;
  }
  set projectExpanded(bool value) {
    _projectExpanded = value;
    notifyListeners();
  }
}