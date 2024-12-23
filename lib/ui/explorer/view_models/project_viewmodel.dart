import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/api.dart';
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
    _project = project;

  addBuildingElement() {
    //final element = ProjectElement(type: ProjectElement.typeFile, name: "Element1", project: _project);
    //_buildingElement = ElementViewModel(projectViewModel: this, element: element);
    //_buildingElement!.isBuilt = true;
    final element = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md", project: _project);
    final elementViewModel = ElementViewModel(projectViewModel: this, element: element);
    _projectElements.add(elementViewModel);
    _projectExpanded = true;
    notifyListeners();
  }
  Future<void> addElement(ElementViewModel element) async {
    await Future.delayed(const Duration(seconds: 1));
    _projectElements.add(element);
    _projectExpanded = true;
    notifyListeners();
  }
  Future<void> deleteElement(ElementViewModel element) async {
    await Future.delayed(const Duration(seconds: 1));
    _projectElements = _projectElements.where((e) => e != element).toList();
    notifyListeners();
  }
  void addDirectory(ElementViewModel element) {
    _projectElements.add(element);
  }

  Project get project {
    return _project;
  }

  Api get api {
    return _applicationViewModel.api;
  }

  List<ElementViewModel> get elements {
    return _projectElements;
  }

  ElementViewModel? get builtElement {
    return _buildingElement;
  }

  bool get projectExpanded {
    return _projectExpanded;
  }
  set projectExpanded(bool value) {
    _projectExpanded = value;
    notifyListeners();
  }
}