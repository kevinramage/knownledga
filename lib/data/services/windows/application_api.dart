import 'dart:convert';
import 'dart:io';
import 'package:knownledga/data/repositories/core/configuration.dart';
import 'package:knownledga/data/repositories/core/exception.dart';
import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/services/base/application_api.dart';
import 'package:knownledga/data/services/helper/window_helper.dart';
import 'package:path/path.dart' as path;

class WindowsApplicationApi extends BaseApplicationApi {

  _logInfo(String message) {
    log.addInfoLog(LogComponent.project, message);
  }
  _logException(KnowledgaException exception, [StackTrace? stackTrace]) {
    log.addExceptionLog(LogComponent.project, exception, stackTrace);
  }

  _init() async {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    String knownledgaDirectory = path.join(homeDirectory, ".knownledga", "projects");
    await Directory(knownledgaDirectory).create(recursive: true);
  }

  @override
  Future<KnownledgaConfiguration> loadConfiguration() async {
    await _init();
    _logInfo("Load configuration");
    try {
      String path =  WindowsHelper.getKnownledgaConfigurationPath();
      File configurationFile = File(path);
      bool configurationExisted = await configurationFile.exists();

      // Read configuration from JSON if file existed
      if (configurationExisted) {
        String content = await configurationFile.readAsString();
        Map<String, dynamic> decodedContent = jsonDecode(content);
        KnownledgaConfiguration.instance = KnownledgaConfiguration.fromJSON(decodedContent);

      // Return basic configuration if file not exists and save configuration
      } else {
        final basicConfiguration = KnownledgaConfiguration.init();
        saveConfiguration(basicConfiguration);
        KnownledgaConfiguration.instance = basicConfiguration;
      }
      return KnownledgaConfiguration.instance as KnownledgaConfiguration;

    } catch (e, stackTrace) {
      KnowledgaException exception = KnowledgaException(code: codeAppConfReadTechnical, message: "Impossible to read configuration file, a technical error occured: ${e.toString()}, please check logs");
      _logException(exception, stackTrace);
      throw exception;
    }
  }

  @override
  saveConfiguration(KnownledgaConfiguration configuration) async {
    _logInfo("Save configuration");
    String path =  WindowsHelper.getKnownledgaConfigurationPath();
    String content = jsonEncode(configuration.toJSON());
    await File(path).writeAsString(content);
  }
}