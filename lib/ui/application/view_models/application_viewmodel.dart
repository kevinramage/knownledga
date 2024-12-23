import 'package:flutter/material.dart';
import 'package:knownledga/data/services/api.dart';

class ApplicationViewModel with ChangeNotifier {
  final Api _api;

  ApplicationViewModel({required Api api}) : _api = api;

  String isValidProjectName(String projectName) {
    final regex = RegExp(r'^[a-z|A-Z|0-9|_|\\-]{3,}$');
    return regex.hasMatch(projectName) ? "" : "A project name must have at least 3 characters and contains only alphanumeric characters or '-' '_' characters";
  }
  String isValidProjectLocation(String path) {
    String invalidPath = "C:\\Knownledga\\test";
    return path != invalidPath ? "" : "A project with same name already existed";
  }

  Api get api { 
    return _api;
  }

  String get homeDirectory {
    return "C:\\Knownledga";
  }
}