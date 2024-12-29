import 'package:knownledga/data/repositories/explorer/project.dart';

class ProjectAPIHelper {

  /*
  static void addLog(String logLevel, String component, String message) {
    final applicationApi = api;
    if (applicationApi != null) {
      applicationApi.log.addLog(logLevel, component, message);
    } else {
      throw ErrorDescription("API component not defined");
    }
  }
  */

  bool projectNameExisted(List<Project> projects, String projectName) {
    final pjs = projects.where((p) => p.name == projectName);
    return pjs.isEmpty;
  }

  /*
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
  */

}