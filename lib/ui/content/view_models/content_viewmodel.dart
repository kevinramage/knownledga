import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class ContentViewModel {
  final ApplicationViewModel _applicationViewModel;
  late EditorViewModel _editorViewModel;

  ContentViewModel({required ApplicationViewModel applicationViewModel}) : _applicationViewModel = applicationViewModel {
    _editorViewModel = EditorViewModel(applicationViewModel: applicationViewModel);
  }

  defineCurrentElement(ElementViewModel element) {
    _editorViewModel.defineCurrentElement(element);
  }

  ApplicationViewModel get applicationViewModel {
    return _applicationViewModel;
  }
  EditorViewModel get editorViewModel {
    return _editorViewModel;
  }
}