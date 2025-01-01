import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:knownledga/data/services/base/application_api.dart';
import 'package:knownledga/data/services/base/log_api.dart';
import 'package:knownledga/data/services/base/project_api.dart';
import 'package:knownledga/data/services/web/application_api.dart';
import 'package:knownledga/data/services/web/log_api.dart';
import 'package:knownledga/data/services/web/project_api.dart';
import 'package:knownledga/data/services/windows/application_api.dart';
import 'package:knownledga/data/services/windows/log_api.dart';
import 'package:knownledga/data/services/windows/project_api.dart';

class Api {
  BaseApplicationApi application = WebApplicationApi();
  BaseProjectApi project = WebProjectApi();
  BaseLogApi log = WebLogApi();

  Api();

  initialize() {

    // Instianciate windows api
    if (!kIsWeb && Platform.isWindows) {
      project = WindowsProjectApi();
      application = WindowsApplicationApi();
      log = WindowsLogApi();
    }

    // Manage dependency
    project.log = log;
    application.log = log;
  }

  factory Api.init() {
    final instance = Api();
    instance.initialize();
    return instance;
  }
}