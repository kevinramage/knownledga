import 'dart:async';
import 'dart:io';

import 'package:knownledga/modules/content/models/log.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/models/projectelement.dart';
import 'package:knownledga/utils/services/base/project_api.dart';
import 'package:path/path.dart';

class WindowsProjectApi extends BaseProjectApi {

  @override
  createProject(String projectName) async {
    addLog(ApplicationLog.logLevelInfo, "Project", "Create project '$projectName'");

    // Create directory
    final project = Project(name: projectName);
    Map<String, String> envVars = Platform.environment;
    final homeDirectory = envVars["UserProfile"];
    project.path = "$homeDirectory/.knownledga/projects/$projectName";
    await Directory(project.path).create(recursive: true);

    // Update state
    addProjectInProjectList(project);
  }

  @override
  void deleteProject(String projectName) async {
    addLog(ApplicationLog.logLevelInfo, "Project", "Delete project '$projectName'");

    // Create directory
    final projects = getAllProjects();
    final project = projects.where((p) => p.name == projectName);
    if (project.isNotEmpty) {
      await Directory(project.first.path).delete(recursive: true);
      deleteProjectFromProjectList(projectName);
    } else {
      addLog(ApplicationLog.logLevelError, "Project", "Impossible to find project $projectName");
    }
  }

  @override
  createFile(Project project, String fileName) async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Create file '$fileName'");
    final element = ProjectElement(type: ProjectElement.typeFile, name: fileName, project: project);
    element.path = "${project.path}/${element.name}";
    await File(element.path).create();
    addEltInProject(project, element);
  }

  @override
  void deleteFile(Project project, ProjectElement element) async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Create file '${element.name}'");
    await File(element.path).delete();
    deleteEltFromProject(project, element);
  }

  @override
  openFile(ProjectElement element) async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Open file '${element.name}'");
    element.content = await File(element.path).readAsString();
    setActiveElement(element);
  }

  @override
  saveFile(ProjectElement element, String content) async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Save file '${element.name}'");
    await File(element.path).writeAsString(element.content);
  }

  @override
  void renameFile(ProjectElement element, String newName) async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Rename file '${element.name}' to $newName");
    bool isActiveElt = isActiveElement(element);
    await File(element.path).rename(newName);
    refreshState();
    if (isActiveElt) {
      setActiveElement(element);
    }
  }

  @override
  Future<List<Project>> loadProjects() async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Load projects");
    final completer = Completer<List<Project>>();
    List<Project> projects = [];

    // Identify path
    Map<String, String> envVars = Platform.environment;
    final homeDirectory = envVars["UserProfile"];
    final path = "$homeDirectory/.knownledga/projects";

    // Read directory
    final listener = Directory(path).list(recursive: true);
    listener.listen((file) async { 
        readFileFromDirectory(projects, path, file);
      }, onError: (err) {
        completer.completeError(err);
      }, onDone: () {
        addLog(ApplicationLog.logLevelInfo, "Project", "${projects.length} projects loaded");
        completer.complete(projects);
      }
    );

    return completer.future;
  }

  void readFileFromDirectory(List<Project> projects, String path, FileSystemEntity file) {

    // Check directory to check if it's a root folder
    if (file.parent.path == path) {
      final project = Project(name: basename(file.path));
      project.path = file.path;
      projects.add(project);
    } else {
      final projectName = basename(file.parent.path);
      final project = projects.where((p) => p.name == projectName);
      if (project.isNotEmpty) {
        final fileName = basename(file.path);
        final elt = ProjectElement(type: ProjectElement.typeFile, name: fileName, project: project.first);
        elt.path = file.path;
        project.first.elements.add(elt);
      }
    }
  }
}