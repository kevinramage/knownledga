import 'package:knownledga/data/services/base/project_api.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';

class WebProjectApi extends BaseProjectApi {

  @override
  Future<List<Project>> loadAllProjects() async {
    await Future.delayed(const Duration(seconds: 1));
    final project1 = Project(name: "Project1");
    final project2 = Project(name: "Project2");
    final project3 = Project(name: "Project3");
    project3.type = ProjectType.gitProject;
    final elt1 = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md");
    elt1.content = "Element1";
    final elt2 = ProjectElement(type: ProjectElement.typeFile, name: "Element2.md");
    elt2.content = "Element2";
    final elt3 = ProjectElement(type: ProjectElement.typeFile, name: "Element3.md");
    elt3.content = "Element3";
    project1.elements.add(elt1);
    project2.elements.add(elt1);
    project2.elements.add(elt2);
    project3.elements.add(elt1);
    project3.elements.add(elt2);
    project3.elements.add(elt3);
    return [ project1, project2, project3];
  }

/*
  @override
  Future<Project> loadProject(Project project) async {
    Future.delayed(const Duration(seconds: 1));
    switch (project.name) {
      case "Project1":
        final elt1 = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md", project: project);
        elt1.content = "Element1";
        project.type = ProjectType.localProject;
        project.elements.add(elt1);
        return project;
      
      case "Project2":
        final elt1 = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md", project: project);
        elt1.content = "Element1";
        final elt2 = ProjectElement(type: ProjectElement.typeFile, name: "Element2.md", project: project);
        elt2.content = "Element2";
        project.type = ProjectType.localProject;
        project.elements.add(elt1);
        project.elements.add(elt2);
        return project;
      
      case "Project3":
        final elt1 = ProjectElement(type: ProjectElement.typeFile, name: "Element1.md", project: project);
        elt1.content = "Element1";
        final elt2 = ProjectElement(type: ProjectElement.typeFile, name: "Element2.md", project: project);
        elt2.content = "Element2";
        final elt3 = ProjectElement(type: ProjectElement.typeFile, name: "Element3.md", project: project);
        elt3.content = "Element3";
        project.type = ProjectType.localProject;
        project.elements.add(elt1);
        project.elements.add(elt2);
        project.elements.add(elt3);
        return project;
    }
    throw ErrorDescription("Invalid project name: ${project.name}");
  }
*/

  @override
  Future<Project> createProject(Project project) async {
    await Future.delayed(const Duration(seconds: 1));
    return project;
  }

  @override
  Future<ProjectElement> createProjectElement(ProjectElement element) async {
    await Future.delayed(const Duration(seconds: 1));
    return element;
  }

  @override
  Future<ProjectElement> loadElement(ProjectElement element) async {
    await Future.delayed(const Duration(seconds: 1));
    return element;
  }

  @override
  Future<ProjectElement> renameElement(ProjectElement element, String newName) async {
    await Future.delayed(const Duration(seconds: 1));
    element.name = newName;
    return element;
  }

  @override
  Future<void> saveElementContent(ProjectElement element) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  @override
  Future<void> deleteElement(ProjectElement element) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  @override
  String getHomeDirectory() {
    return "C:\\Knownledga";
  }

  /*
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

  @override
  String getHomeDirectory() {
    return "C:\\Project";
  }
  */
}