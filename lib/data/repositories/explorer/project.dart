import 'package:knownledga/data/repositories/explorer/parent_element.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';

class Project extends ParentElement {
  String name = "";
  ProjectType type = ProjectType.localProject;
  String path = "";
  bool isCreating = true;
  List<ProjectElement> elements = [];

  Project({required this.name});
}

enum ProjectType { localProject, gitProject }
class ProjectTypeUtils {
  static toText(ProjectType type) {
    switch (type) {
      case ProjectType.localProject: return "Local project";
      case ProjectType.gitProject: return "Git project";
    }
  }
}