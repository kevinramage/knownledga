import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/services/base/project_api.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/git_helper.dart';
import 'package:knownledga/data/services/window_helper.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

class WindowsProjectApi extends BaseProjectApi {

  _logInfo(String message) {
    log.addInfoLog(LogComponent.project, message);
  }

  @override
  Future<Project> createProject(Project project) async {
    _logInfo("Create project '${project.name}'");
    if (project.type == ProjectType.localProject) {
      await _createLocalProject(project);
    } else {
      await _createGitProject(project);
    }
    return project;
  }

  _createLocalProject(Project project) async {
    project.path = WindowsHelper.getKnownledgaProjectDirectory(project.name);
    await Directory(project.path).create(recursive: true);
    return project;
  }

  _createGitProject(Project project) async {
    _logInfo("Cloning '${project.name}' ('${project.gitUrl}')");
    project.path = WindowsHelper.getKnownledgaProjectDirectory(project.name);
    await GitHelper.clone(project.gitUrl, project.path);
    _logInfo("'${project.name}' cloned successfully");
  }

  /*
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
  */

  @override
  Future<ProjectElement> createProjectElement(ProjectElement element) async {
    _logInfo("Create file '${element.name}'");
    await File(element.path).create();
    return element;
  }

  /*
  @override
  void createFolder(ParentElement parent, String directoryName) async {
    addLog(ApplicationLog.logLevelDebug, "Project", "Create folder '$directoryName'");
    ProjectElement element;
    if (parent is Project) {
      element = ProjectElement(type: ProjectElement.typeFolder, name: directoryName, project: parent);
      element.path = path.join(parent.path, element.name);
    } else if (parent is ProjectElement) {
      element = ProjectElement(type: ProjectElement.typeFolder, name: directoryName, project: parent.project);
      element.path = path.join(parent.path, element.name);
    } else {
      throw ErrorDescription("createFolder - Invalid parent instance");
    }
    await Directory(element.path).create();
    addEltToParent(parent, element);
  }
  */

  @override
  Future<void> deleteElement(ProjectElement element) async {
    _logInfo("Delete element '${element.name}'");
    await File(element.path).delete(recursive: true);
  }

  @override
  loadElement(ProjectElement element) async {
    //addLog(ApplicationLog.logLevelDebug, "Project", "Open file '${element.name}'");
    element.content = await File(element.path).readAsString();
    return element;
  }

  @override
  Future<void> saveElementContent(ProjectElement element) async {
    //addLog(ApplicationLog.logLevelDebug, "Project", "Save file '${element.name}'");
    await File(element.path).writeAsString(element.content);
  }

  @override
  Future<ProjectElement> renameElement(ProjectElement element, String newName) async {
    _logInfo("Rename file '${element.name}' to $newName");
    String parentPath = "";
    final parent = element.parent;
    if (parent is Project) {
      parentPath = parent.path;
    } else if (parent is ProjectElement) {
      parentPath = parent.path;
    } else {
      throw ErrorDescription("renameFile - Invalid parent instance");
    }
    final newPath = path.join(parentPath, newName);
    await File(element.path).rename(newPath);
    element.name = newName;
    element.path = newPath;
    return element;
  }

  @override
  Future<List<Project>> loadAllProjects() async {
    _logInfo("Loading projects");
    //addLog(ApplicationLog.logLevelDebug, "Project", "Load projects");
    final completer = Completer<List<Project>>();
    List<Project> projects = [];

    // Identify path
    final projectsPath = WindowsHelper.getKnownledgaProjectsDirectory();

    // Read directory
    final listener = Directory(projectsPath).list(recursive: true);
    listener.listen((file) async { 
        readFileFromDirectory(projects, projectsPath, file);
      }, onError: (err) {
        completer.completeError(err);
      }, onDone: () {
        _logInfo("${projects.length} projects loaded");
        //sortElements(projects);
        _updateProjectsType(projects);
        completer.complete(projects);
      }
    );

    return completer.future;
  }

  void readFileFromDirectory(List<Project> projects, String path, FileSystemEntity file) {

    // Check directory to check if it's a root folder
    if (file.parent.path == path) {
      if (file.statSync().type == FileSystemEntityType.directory) {
        readProjectFromDirectory(projects, path, file);
      }
    } else {
      final fileType = file.statSync().type;
      final parentElement = detectParent(projects, file.parent);
      if (parentElement != null && parentElement is ProjectElement ) {
        final elt = buildElement(file, fileType);
        elt.parent = parentElement;
        parentElement.subElements.add(elt);
      } else if (parentElement != null && parentElement is Project) {
        final elt = buildElement(file, fileType);
        elt.parent = parentElement;
        parentElement.elements.add(elt);
      }
    }
  }

  ProjectElement buildElement(FileSystemEntity file, FileSystemEntityType fileType) {
    final fileName = basename(file.path);
    final elt = ProjectElement(type: ProjectElement.typeFile, name: fileName);
    elt.path = file.path;
    elt.type = fileType == FileSystemEntityType.directory ? ProjectElement.typeFolder : ProjectElement.typeFile;
    return elt;
  }

  void readProjectFromDirectory(List<Project> projects, String path, FileSystemEntity file) {
    final project = Project(name: basename(file.path));
    project.isCreating = false;
    project.path = file.path;
    projects.add(project);
  }

  detectParent(List<Project> projects, FileSystemEntity file) {
    final projectFound = projects.where((p) => p.path == file.path);
    if (projectFound.isEmpty) {
      final projectElements = projects.map((p) => p.elements).expand((e) => e).toList();
      final allElements = projectElements.map((e) => getAllElements(e)).expand((e) => e).toList();
      final elementsFound = allElements.where((e) => e.path == file.path);
      if (elementsFound.isNotEmpty) {
        return elementsFound.first;
      } else {
        return null;
      }
    } else {
      return projectFound.first;
    }
  }

  List<ProjectElement> getAllElements(ProjectElement element) {
    List<ProjectElement> allElements = [];
    allElements.add(element);
    for (int i = 0; i < element.subElements.length; i++) {
      final elts = getAllElements(element.subElements[i]);
      allElements.addAll(elts);
    }
    return allElements;
  }

  void _updateProjectsType(List<Project> projects) {
    for (var p in projects) {
      final elt = p.elements.where((e) => e.name == ".git" && e.type == ProjectElement.typeFolder );
      if (elt.length == 1) {
        p.type = ProjectType.gitProject;
      }
    }
  }

  @override
  Future<void> push(Project project) async {
    _logInfo("Pushing project '${project.name}'");
    await GitHelper.add(project.path);
    await GitHelper.commit(project.path);
    await GitHelper.push(project.path);
    _logInfo("Project '${project.name}' pushed");
  }

  @override
  String getHomeDirectory() {
    return WindowsHelper.getHomeDirectory();
  }
}