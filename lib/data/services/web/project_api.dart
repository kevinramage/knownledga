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
  Future<void> push(Project project) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  @override
  String getHomeDirectory() {
    return "C:\\Knownledga";
  }
}