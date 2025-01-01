import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/base/log_api.dart';

abstract class BaseProjectApi {

  late BaseLogApi log;

  /*
   * All interfaces
   */
  Future<List<Project>> loadAllProjects();
  //Future<Project> loadProject(Project project);
  Future<Project> createProject(Project project);
  Future<ProjectElement> createProjectElement(ProjectElement element);
  Future<ProjectElement> loadElement(ProjectElement element);
  Future<ProjectElement> renameElement(ProjectElement element, String newName);
  Future<void> saveElementContent(ProjectElement element);
  Future<void> deleteElement(ProjectElement element);
  Future<void> push(Project project);
  String getHomeDirectory();
}

