import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/parent_element_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class ElementViewModel extends ParentElementViewModel with ChangeNotifier {
  final ParentElementViewModel _parentViewModel;
  final ProjectElement _element;
  List<ElementViewModel> _subElements;
  bool isBuilt = false;
  bool _isRenaming = false;
  bool isModified = false;

  ElementViewModel({required ParentElementViewModel parentElementViewModel, required ProjectElement element}) :
    _parentViewModel = parentElementViewModel,
    _subElements = [],
    _element = element {
      _subElements = element.subElements.map((se) => ElementViewModel(parentElementViewModel: this, element: se)).toList();
      _subElements.sort(ElementViewModel.sortElement);
    }

  Future<void> renameElement(String newName) async {
    await applicationViewModel.renameElement(this, newName);
    _element.name = newName;
    _isRenaming = false;
    notifyListeners();
  }

  Future<void> openElement() async {
    await projectViewModel.applicationViewModel.openElement(this);
    notifyListeners();
  }

  void queryRenaming() {
    _isRenaming = true;
    notifyListeners();
  }

  void cancelRenaming() {
    _isRenaming = false;
    notifyListeners();
  }

  void saveContent() {
    isModified = false;
    notifyListeners();
  }

  @override
  Future<void> deleteElement(ElementViewModel element) async {
    await applicationViewModel.deleteElement(element);
    _subElements = _subElements.where((e) => e != element).toList();
    notifyListeners();
  }

  void indicateContentChange() {
    isModified = true;
    notifyListeners();
  }

  static int sortElement(ElementViewModel a, ElementViewModel b) {
    if (a.elementType == ProjectElement.typeFolder && b.elementType == ProjectElement.typeFile) {
      return -1;
    } else if (a.elementType == ProjectElement.typeFile && b.elementType == ProjectElement.typeFolder) {
      return 1;
    } else {
      return a.elementName.compareTo(b.elementName);
    }
  }

  ParentElementViewModel get parentViewModel {
    return _parentViewModel;
  }

  @override
  ProjectViewModel get projectViewModel {
    if (parentViewModel is ProjectViewModel) {
      return parentViewModel as ProjectViewModel;
    } else {
      return parentViewModel.projectViewModel;
    }
  }

  ApplicationViewModel get applicationViewModel {
    return projectViewModel.applicationViewModel;
  }

  ProjectElement get element {
    return _element;
  }

  List<ElementViewModel> get subElements {
    return _subElements;
  }
  String get shortElementName {
    if (elementName.length > 15) {
      return "${elementName.substring(0, 15)}...";
    } else {
      return elementName;
    }
  }
  String get elementName {
    return _element.name;
  }
  String get elementContent {
    return _element.content;
  }
  String get elementType {
    return _element.type;
  }
  bool get isExpandable {
    return elementType == ProjectElement.typeFolder;
  }

  set elementContent(String value) {
    _element.content = value;
  }

  bool get isRenaming {
    return _isRenaming;
  }
  set isRenaming(bool value) {
    _isRenaming = value;
    notifyListeners();
  }
}