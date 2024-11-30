import 'package:knownledga/modules/explorer/models/project.dart';

class ProjectElement {
  static const String typeFolder = "FOLDER";
  static const String typeFile = "FILE";
  
  Project project;
  String type = ProjectElement.typeFile;
  String name = "";
  String path = "";
  String content = "";
  bool saved = true;
  List<ProjectElement> subElements = [];

  ProjectElement({required this.type, required this.name, required this.project});
}