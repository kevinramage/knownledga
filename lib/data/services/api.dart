import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:knownledga/data/services/base/project_api.dart';
import 'package:knownledga/data/services/content_api.dart';
import 'package:knownledga/data/services/log_api.dart';
import 'package:knownledga/data/services/web/project_api.dart';

class Api {
  BaseProjectApi project = WebProjectApi();
  LogApi log = LogApi();
  ContentApi content = ContentApi();

  Api();

  initialize() {
    if (!kIsWeb && Platform.isWindows) {
      //project = WindowsProjectApi();
    }
    //project.api = this;
  }

  factory Api.init() {
    final instance = Api();
    instance.initialize();
    return instance;
  }
}