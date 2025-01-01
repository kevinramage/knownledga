import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

abstract class ParentElementViewModel {
  Future<void> deleteElement(ElementViewModel element);

  ProjectViewModel get projectViewModel;
}