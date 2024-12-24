import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class ElementViewModel with ChangeNotifier {
  final ProjectViewModel _projectViewModel;
  final ProjectElement _element;
  bool isBuilt = false;
  bool _isRenaming = false;
  bool isModified = false;

  ElementViewModel({required ProjectViewModel projectViewModel, required ProjectElement element}) :
    _projectViewModel = projectViewModel,
    _element = element;

  Future<void> renameElement(String newName) async {
    await _projectViewModel.applicationViewModel.renameElement(this, newName);
    _element.name = newName;
    _isRenaming = false;
    notifyListeners();
  }

  Future<void> openElement() async {
    await projectViewModel.applicationViewModel.openElement(this);
    notifyListeners();
  }

  cancelRenaming() {
    _isRenaming = false;
    notifyListeners();
  }

  void saveContent() {
    isModified = false;
    notifyListeners();
  }

  void indicateContentChange() {
    isModified = true;
    notifyListeners();
  }

  ProjectViewModel get projectViewModel {
    return _projectViewModel;
  }

  ProjectElement get element {
    return _element;
  }

  String get elementName {
    return _element.name;
  }
  String get elementContent {
    return _element.content;
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