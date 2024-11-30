import 'package:flutter/foundation.dart';
import 'package:knownledga/modules/explorer/models/project.dart';
import 'package:knownledga/modules/explorer/models/projectelement.dart';
import 'package:knownledga/utils/services/api.dart';

abstract class BaseProjectApi {
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

  void addLog(String logLevel, String component, String message) {
    final applicationApi = api;
    if (applicationApi != null) {
      applicationApi.log.addLog(logLevel, component, message);
    } else {
      throw ErrorDescription("API component not defined");
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

  void addProjectInProjectList(Project project) {
    final projects = getAllProjects();
    projects.add(project);
    setProjects(projects.toList());
  }

  void deleteProjectFromProjectList(String projectName) {
    final projects = getAllProjects();
    projects.removeWhere((p) => p.name == projectName);
    setProjects(projects.toList());
  }

  void addEltInProject(Project project, ProjectElement element) {
    final projects = getAllProjects();
    project.elements.add(element);
    setProjects(projects.toList());
  }

  void deleteEltFromProject(Project project, ProjectElement element) {
    final projects = getAllProjects();
    project.elements.remove(element);
    setProjects(projects.toList());
  }

  void refreshState() {
    final projects = getAllProjects();
    setProjects(projects.toList());
  }

  bool isActiveElement(ProjectElement element) {
    final applicationApi = api;
    if (applicationApi != null) {
      final activeElement = applicationApi.content.getActiveElt();
      return activeElement != null && activeElement == element;
    } else {
      throw ErrorDescription("API component not defined");
    }
  }

  void setActiveElement(ProjectElement element) {
    final applicationApi = api;
    if (applicationApi != null) {
      applicationApi.content.openFile(element);
    } else {
      throw ErrorDescription("API component not defined");
    }
  }

  void createProject(String projectName);
  void deleteProject(String projectName);
  void createFile(Project project, String fileName);
  void deleteFile(Project project, ProjectElement element);
  void openFile(ProjectElement element);
  void saveFile(ProjectElement element, String content);
  void renameFile(ProjectElement element, String newName);
  Future<List<Project>> loadProjects();
}

