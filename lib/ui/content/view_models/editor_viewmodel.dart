import 'package:flutter/material.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class EditorViewModel with ChangeNotifier {
  final ApplicationViewModel _applicationViewModel;
  ElementViewModel? currentElement;

  EditorViewModel({required ApplicationViewModel applicationViewModel}) : _applicationViewModel = applicationViewModel;

  void defineCurrentElement(ElementViewModel element) {
    currentElement = element;
    notifyListeners();
  }

  ApplicationViewModel get applicationViewModel {
    return _applicationViewModel;
  }
}