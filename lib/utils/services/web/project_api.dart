import 'package:flutter/material.dart';
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
  void createFile(ParentElement parent, String fileName) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Create file '$fileName'");
    ProjectElement element;
    if (parent is Project) {
      element = ProjectElement(type: ProjectElement.typeFile, name: fileName, project: parent);
    } else if (parent is ProjectElement) {
      element = ProjectElement(type: ProjectElement.typeFile, name: fileName, project: parent.project);
    } else {
      throw ErrorDescription("createFile - Invalid parent instance");
    }
    addEltToParent(parent, element);
  }

  @override
  void createFolder(ParentElement parent, String directoryName) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Create folder '$directoryName'");
    ProjectElement element;
    if (parent is Project) {
      element = ProjectElement(type: ProjectElement.typeFolder, name: directoryName, project: parent);
    } else if (parent is ProjectElement) {
      element = ProjectElement(type: ProjectElement.typeFolder, name: directoryName, project: parent.project);
    } else {
      throw ErrorDescription("createFolder - Invalid parent instance");
    }
    addEltToParent(parent, element);
  }

  @override
  void deleteFile(ProjectElement element) {
    addLog(ApplicationLog.logLevelDebug, "Project", "Delete element '${element.name}'");
    if (element.parent != null) {
      deleteEltFromParent(element.parent as ParentElement, element);
    } else {
      throw ErrorDescription("DeleteFile - Invalid parent element");
    }
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
    final project = Project(name: "New pj");
    project.isCreating = false;
    projects.add(project);
    return projects;
  }
}