import 'package:knownledga/data/repositories/explorer/parent_element.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';

class ProjectElement extends ParentElement {
  static const String typeFolder = "FOLDER";
  static const String typeFile = "FILE";
  
  Project project;
  ParentElement? parent;
  String type = ProjectElement.typeFile;
  String name = "";
  String path = "";
  String content = "";
  bool saved = true;
  List<ProjectElement> subElements = [];

  ProjectElement({required this.type, required this.name, required this.project});

  static int compareTo(ProjectElement a, ProjectElement b) {
    if (a.type == b.type) {
      return a.name.compareTo(b.name);
    } else if (a.type == ProjectElement.typeFolder) {
      return -1;
    } else {
      return 1;
    }
  }
}