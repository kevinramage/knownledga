import 'package:knownledga/data/repositories/explorer/parent_element.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';

class Project extends ParentElement {
  String name = "";
  String path = "";
  bool isCreating = true;
  List<ProjectElement> elements = [];

  Project({required this.name});
}