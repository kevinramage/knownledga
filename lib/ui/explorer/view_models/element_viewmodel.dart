import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class ElementViewModel with ChangeNotifier {
  final ProjectViewModel _projectViewModel;
  final ProjectElement _element;
  bool isBuilt = false;
  bool _isRenaming = false;

  ElementViewModel({required ProjectViewModel projectViewModel, required ProjectElement element}) :
    _projectViewModel = projectViewModel,
    _element = element;

  Future<void> renameElement(String newName) async {
    await Future.delayed(const Duration(seconds: 1));
    _element.name = newName;
    _isRenaming = false;
    notifyListeners();
  }

  cancelRenaming() {
    _isRenaming = false;
    notifyListeners();
  }

  ProjectViewModel get projectViewModel {
    return _projectViewModel;
  }

  String get elementName {
    return _element.name;
  }

  bool get isRenaming {
    return _isRenaming;
  }
  set isRenaming(bool value) {
    _isRenaming = value;
    notifyListeners();
  }
}