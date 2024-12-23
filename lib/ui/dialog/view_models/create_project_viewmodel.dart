import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class CreateProjectViewModel extends ChangeNotifier {
  final ApplicationViewModel _applicationViewModel;

  String _projectName = "Project1";
  String _projectLocation = "";
  ProjectType _projectType = ProjectType.localProject;
  String _applicationHome = "";
  String _gitUrl = "";
  //String _gitUsername = "";
  //String _gitPassword = "";
  bool _isValidProjectName = true;
  bool _isValidProjectLocation = false;
  
  CreateProjectViewModel({required ApplicationViewModel application}) : _applicationViewModel = application {
    applicationHome = application.getHomeDirectory();
  }

  initHomeDirectory() {
    applicationHome = _applicationViewModel.getHomeDirectory();
  }

  ProjectViewModel toProjectViewModel(ApplicationViewModel applicationViewModel) {
    final Project project = Project(name: projectName);
    project.path = projectLocation;
    project.type = projectType;
    project.gitUrl = gitUrl;
    return ProjectViewModel(applicationViewModel: applicationViewModel, project: project);
  }

  String get projectName {
    return _projectName;
  }
  set projectName (String value) {
    _projectName = value;
    _setProjectLocation = "$_applicationHome\\.knownledga\\projects\\$value";
    _isValidProjectName = _applicationViewModel.isValidProjectName(value) == "";
    notifyListeners();
  }
  String get projectLocation {
    return _projectLocation;
  }
  set _setProjectLocation(String value) {
    _projectLocation = value;
    _isValidProjectLocation = _applicationViewModel.isValidProjectLocation(value) == "";
  }
  ProjectType get projectType {
    return _projectType;
  }
  set projectType (ProjectType value) {
    _projectType = value;
    notifyListeners();
  }
  String get applicationHome {
    return _applicationHome;
  }
  set applicationHome (String value) {
    _applicationHome = value;
    _setProjectLocation = "$value\\.knownledga\\projects\\$_projectName";
    notifyListeners();
  }
  String get gitUrl {
    return _gitUrl;
  }
  set gitUrl (String value) {
    _gitUrl = value;
    notifyListeners();
  }
  /*
  String get gitUsername {
    return _gitUsername;
  }
  set gitUsername (String value) {
    _gitUsername = value;
    notifyListeners();
  }
  */
  /*
  String get gitPassword {
    return _gitPassword;
  }
  set gitPassword(String value) {
    _gitPassword = value;
    notifyListeners();
  }
  */
  bool get isValidProjectName {
    return _isValidProjectName;
  }
  bool get isValidProjectLocation {
    return _isValidProjectLocation;
  }
  bool get isValidGitURL {
    return projectType != ProjectType.gitProject || gitUrl.isNotEmpty;
  }
  /*
  bool get isValidGitUserName {
    return projectType != ProjectType.gitProject || gitUsername.isNotEmpty; 
  }
  */
  /*
  bool get isValidGitPassword {
    return projectType != ProjectType.gitProject || gitPassword.isNotEmpty;
  }
  */
  bool get isValidProperties {
    return isValidProjectName && isValidProjectLocation && isValidGitURL /*&& isValidGitUserName && isValidGitPassword */;
  }
}