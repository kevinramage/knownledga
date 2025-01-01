import 'package:flutter/material.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class EditorViewModel with ChangeNotifier {
  final ApplicationViewModel _applicationViewModel;
  ElementViewModel? currentElement;
  int viewIndex = 0;

  EditorViewModel({required ApplicationViewModel applicationViewModel}) : _applicationViewModel = applicationViewModel;

  void defineCurrentElement(ElementViewModel element) {
    currentElement = element;
    notifyListeners();
  }

  void closeCurrentElement() {
    currentElement = null;
    notifyListeners();
  }

  updateViewIndex(int index) {
    viewIndex = index;
    notifyListeners();
  }

  ApplicationViewModel get applicationViewModel {
    return _applicationViewModel;
  }

  String get viewMode {
    if (viewIndex == 0) {
      return "Editor";
    } else if (viewIndex == 1) {
      return "Designer";
    } else {
      return "Renderer";
    }
  }
}