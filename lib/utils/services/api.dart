import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:knownledga/utils/services/base/project_api.dart';
import 'package:knownledga/utils/services/content_api.dart';
import 'package:knownledga/utils/services/log_api.dart';
import 'package:knownledga/utils/services/web/project_api.dart';
import 'package:knownledga/utils/services/windows/project_api.dart';

class Api {
  BaseProjectApi project = WebProjectApi();
  LogApi log = LogApi();
  ContentApi content = ContentApi();

  Api();

  initialize() {
    if (!kIsWeb && Platform.isWindows) {
      project = WindowsProjectApi();
    }
    project.api = this;
  }

  factory Api.init() {
    final instance = Api();
    instance.initialize();
    return instance;
  }
}