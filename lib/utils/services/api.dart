import 'package:knownledga/utils/services/content_api.dart';
import 'package:knownledga/utils/services/log_api.dart';
import 'package:knownledga/utils/services/project_api.dart';

class Api {
  ProjectApi project = ProjectApi();
  LogApi log = LogApi();
  ContentApi content = ContentApi();

  Api();

  initialize() {
    project.api = this;
  }

  factory Api.init() {
    final instance = Api();
    instance.initialize();
    return instance;
  }
}