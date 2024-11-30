import 'package:knownledga/modules/content/models/log.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/models/projectelement.dart';
import 'package:knownledga/utils/services/base/project_api.dart';

class WebProjectApi extends BaseProjectApi {

  @override
  createProject(String projectName) {
    addLog(ApplicationLog.logLevelInfo, "Project", "Create project '$projectName'");
    final project = Project(name: projectName);
    addProjectInProjectList(project);
  }

  @override
  void deleteProject(String projectName) {
    addLog(ApplicationLog.logLevelInfo, "Project", "Delete project '$projectName'");
    deleteProjectFromProjectList(projectName);
  }

  @override
  void createFile(Project project, String fileName) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Create file '$fileName'");
    final element = ProjectElement(type: ProjectElement.typeFile, name: fileName, project: project);
    addEltInProject(project, element);
  }

  @override
  void deleteFile(Project project, ProjectElement element) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Delete file '${element.name}'");
    deleteEltFromProject(project, element);
  }

  @override
  openFile(ProjectElement element) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Open file '${element.name}'");
    setActiveElement(element);
  }

  @override
  saveFile(ProjectElement element, String content) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Save file '${element.name}'");
  }

  @override
  void renameFile(ProjectElement element, String newName) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Rename file '${element.name}' to $newName");
    bool isActiveElt = isActiveElement(element);
    refreshState();
    if (isActiveElt) {
      setActiveElement(element);
    }
  }

  @override
  Future<List<Project>> loadProjects() async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Load projects");
    await Future.delayed(const Duration(seconds: 5));
    List<Project> projects = [];
    projects.add(Project(name: "New pj"));
    return projects;
  }
}