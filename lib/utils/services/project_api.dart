import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:knownledga/modules/content/models/log.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/models/projectelement.dart';
import 'package:knownledga/utils/services/api.dart';
import 'package:path/path.dart';

class ProjectApi {
  Api? api;
  Function? _getProjectsFunc;
  Function? _setProjectsFunc;

  registerGetProjects(Function getProjects) {
    _getProjectsFunc = getProjects;
  }
  registerSetProjects(Function setProjects) {
    _setProjectsFunc = setProjects;
  }

  List<Project> getAllProjects() {
    final func = _getProjectsFunc;
    if (func != null) {
      return func();
    } else {
      return [];
    }
  }
  void setProjects(List<Project> projects) {
    final func = _setProjectsFunc;
    if (func != null) {
      func(projects);
    }
  }
  void _createProjectUpdateState(Project project) {
    final projects = getAllProjects();
    projects.add(project);
    setProjects(projects.toList());
  }
  Future createProject(String projectName) async {

    // Add log
    final applicationApi = api;
    if (applicationApi != null) {
      applicationApi.log.addLog(ApplicationLog.logLevelInfo, "Project", "Create project '$projectName'");
    }

    // Create project
    final project = Project(name: projectName);

    if (kIsWeb) {

      // Update project
      _createProjectUpdateState(project);
    }

    else if (Platform.isWindows) {

      // Create windows directory
      Map<String, String> envVars = Platform.environment;
      final homeDirectory = envVars["UserProfile"];
      project.path = "$homeDirectory/.knownledga/projects/$projectName";
      await Directory(project.path).create(recursive: true);

      // Update project
      _createProjectUpdateState(project);

    } else {
      throw "Invalid platform";
    }

  }
  void updateProject() {
    final projects = getAllProjects();
    setProjects(projects.toList());
  }

  _deleteProjectUpdateState(List<Project> projects, String projectName) {
    projects.removeWhere((p) => p.name == projectName);
    setProjects(projects.toList());
  }
  deleteProject(String projectName) async {

    // Add log
    final applicationApi = api;
    if (applicationApi != null) {
      applicationApi.log.addLog(ApplicationLog.logLevelInfo, "Project", "Delete project '$projectName'");
    }
    final projects = getAllProjects();

    if (kIsWeb) {
      _deleteProjectUpdateState(projects, projectName);
    } else if (Platform.isWindows) {
      final project = projects.where((p) => p.name == projectName);
      if (project.isNotEmpty) {
        await Directory(project.first.path).delete(recursive: true);
        _deleteProjectUpdateState(projects, projectName);
      }
    } else {
      throw "Invalid platform";
    }
  }
  bool isValidProjectName(String projectName) {
    final projects = getAllProjects();
    final pjs = projects.where((p) => p.name == projectName);
    return pjs.isEmpty;
  }
  String getValidProjectName() {
    return _getValidProjectNameCounter(1);
  }
  String _getValidProjectNameCounter(int counter) {
    if (isValidProjectName("New project $counter")) {
      return "New project $counter";
    } else {
      return _getValidProjectNameCounter(counter + 1);
    }
  }
  bool isValidElementName(Project project, String elementName) {
    final elt = project.elements.where((e) => e.name == elementName);
    return elt.isEmpty;
  }
  String getValidElementName(Project project) {
    return _getValidElementName(project, 1);
  }
  String _getValidElementName(Project project, int counter) {
    if (isValidElementName(project, "New file $counter.md")) {
      return "New file $counter.md";
    } else {
      return _getValidElementName(project, counter + 1);
    } 
  }

  _createFileUpdateState(Project project, ProjectElement elt) {
    final projects = getAllProjects();
    project.elements.add(elt);
    setProjects(projects);
  }
  createFile(Project project, String fileName) async {
    final elt = ProjectElement(type: ProjectElement.typeFile, name: fileName, project: project);

    // Web
    if (kIsWeb) {
      _createFileUpdateState(project, elt);

    // Windows
    } else if (Platform.isWindows) {

      // Create element
      elt.path = "${project.path}/${elt.name}";
      await File(elt.path).create();

      // Update state
      _createFileUpdateState(project, elt);
    }
  }

  _deleteFileUpdateState(Project project, ProjectElement elt) {
    final projects = getAllProjects();
    project.elements.remove(elt);
    setProjects(projects);
  }

  deleteFile(Project project, ProjectElement elt) async {

    // Web
    if (kIsWeb) {
      _deleteFileUpdateState(project, elt);

    // Windows
    } else if (Platform.isWindows) {
      await File(elt.path).delete();
    }
  }

  openFile(ProjectElement element) async {
    final applicationApi = api;
    if (applicationApi == null) {
      throw "API not defined";
    }

    // Web
    if (kIsWeb) {

      // Define as active element
      applicationApi.content.openFile(element);

    // Windows
    } else if (Platform.isWindows) {

      // Read content
      element.content = await File(element.path).readAsString();

      // Define as active element
      applicationApi.content.openFile(element);
    }
  }

  saveFile(ProjectElement element, String content) async {
    element.content = content;

    // Web
    if (kIsWeb) {

    // Windows 
    } else if (Platform.isWindows) {
      await File(element.path).writeAsString(element.content);
    }
  }

  refreshState() {
    final projects = getAllProjects();
    setProjects(projects.toList());
  }

  renameFile(ProjectElement elt, String newName) async {
    final applicationApi = api;
    if (applicationApi == null) { throw "Invalid API"; } 
    final activeElement = applicationApi.content.getActiveElt();
    final isActiveElement = (activeElement != null && activeElement == elt);
    elt.name = newName;

    // Web
    if (kIsWeb) {

      // Rename file
      refreshState();

      // Update active element
      if (isActiveElement) {
        applicationApi.content.setActiveElt(activeElement);
      }

    // Windows
    } else if (Platform.isWindows) {

      // Rename file
      await File(elt.path).rename(newName);
      refreshState();

      // Update active element
      if (isActiveElement) {
        applicationApi.content.setActiveElt(activeElement);
      }
    }
  }

  Future<List<Project>> loadProjects() {
    final completer = Completer<List<Project>>();
    List<Project> projects = [];

    // Windows
    if (!kIsWeb) {

      if (Platform.isWindows) {
        Map<String, String> envVars = Platform.environment;
        final homeDirectory = envVars["UserProfile"];
        final path = "$homeDirectory/.knownledga/projects";
        final listener = Directory(path).list(recursive: true);
        listener.listen((file) async {

          // Check directory to check if it's a root folder
          if (file.parent.path == path) {
            projects.add(Project(name: basename(file.path)));
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
        }, onError: (err) {
          completer.completeError(err);
        }, onDone: () {
          final logApplication = api;
          if (logApplication != null) {
            logApplication.log.addLog(ApplicationLog.logLevelInfo, "Project", "${projects.length} projects loaded");
          }
          completer.complete(projects);
        },);

      } else {
        completer.completeError(ErrorSummary("Invalid platform"));
      }

    } else {
      completer.complete(projects);
    }

    return completer.future;
  }
}