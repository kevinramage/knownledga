import 'package:flutter/foundation.dart';
import 'package:knownledga/data/repositories/explorer/parent_element.dart';
import 'package:knownledga/data/services/api.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';

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
  bool isValidElementName(ParentElement parent, String elementName) {
    Iterable<ProjectElement> elts;
    if (parent is Project) {
      elts = parent.elements.where((e) => e.name == elementName);
    } else if (parent is ProjectElement) {
      elts = parent.subElements.where((e) => e.name == elementName); 
    } else {
      throw ErrorDescription("isValidElementName - Invalid parent instance");
    }
    return elts.isEmpty;
  }
  String getValidElementName(ParentElement parent) {
    return _getValidElementName(parent, 1);
  }
  String _getValidElementName(ParentElement parent, int counter) {
    if (isValidElementName(parent, "New file $counter.md")) {
      return "New file $counter.md";
    } else {
      return _getValidElementName(parent, counter + 1);
    } 
  }
  bool isValidFolderName(ParentElement parent, String folderName) {
    Iterable<ProjectElement> elts;
    if (parent is Project) {
      elts = parent.elements.where((e) => e.name == folderName);
    } else if (parent is ProjectElement) {
      elts = parent.subElements.where((e) => e.name == folderName);
    } else {
      throw ErrorDescription("IsValidFolderName - Invalid parent instance");
    }
    return elts.isEmpty;
  }
  String getValidFolderName(ParentElement parent) {
    return _getValidFoldertName(parent, 1);
  }
  String _getValidFoldertName(ParentElement parent, int counter) {
    if (isValidFolderName(parent, "New folder $counter")) {
      return "New folder $counter";
    } else {
      return _getValidFoldertName(parent, counter + 1);
    } 
  }

  void addProjectInProjectList(Project project) {
    final projects = getAllProjects();
    project.isCreating = false;
    setProjects(projects.toList());
  }

  void prepareProjectCreation(String projectName) {
    final projects = getAllProjects();
    final project = Project(name: projectName);
    projects.add(project);
    setProjects(projects.toList());
  }

  void deleteProjectFromProjectList(String projectName) {
    final projects = getAllProjects();
    projects.removeWhere((p) => p.name == projectName);
    setProjects(projects.toList());
  }

  void addEltToParent(ParentElement parent, ProjectElement element) {
    final projects = getAllProjects();
    if (parent is Project) {
      element.parent = parent;
      parent.elements.add(element);
    } else if (parent is ProjectElement) {
      element.parent = parent;
      parent.subElements.add(element);
    } else {
      throw ErrorDescription("addEltToParent - Invalid parent instance");
    }
    sortElements(projects);
    setProjects(projects.toList());
  }

  void deleteEltFromParent(ParentElement parent, ProjectElement element) {
    final projects = getAllProjects();
    if (parent is Project) {
      parent.elements.remove(element);
    } else if (parent is ProjectElement) {
      parent.subElements.remove(element);
    }
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

  sortElements(List<Project> projects) {
    for (int i = 0; i < projects.length; i++) {
      sortSubElements(projects[i].elements);
    }
  }

  sortSubElements(List<ProjectElement> elts) {
    elts.sort(ProjectElement.compareTo);
    for (int i = 0; i < elts.length; i++) {
      sortSubElements(elts[i].subElements);
    }
  }

  void createProject(String projectName);
  void deleteProject(String projectName);
  void createFile(ParentElement parent, String fileName);
  void createFolder(ParentElement parent, String directoryName);
  void deleteFile(ProjectElement element);
  void openFile(ProjectElement element);
  void saveFile(ProjectElement element, String content);
  void renameFile(ProjectElement element, String newName);
  Future<List<Project>> loadProjects();
  String getHomeDirectory();
}

