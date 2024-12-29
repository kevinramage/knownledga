import 'dart:io';
import 'package:knownledga/data/repositories/core/configuration.dart';
import 'package:path/path.dart' as path;

class WindowsHelper {

  static String getHomeDirectory() {
    String home = "";
    Map<String, String> envVars = Platform.environment;
    if (Platform.isMacOS) {
      home = envVars['HOME'] as String;
    } else if (Platform.isLinux) {
      home = envVars['HOME'] as String;
    } else if (Platform.isWindows) {
      home = envVars['UserProfile'] as String;
    }
    return home;
  }

  static String getWorkingDirectory() {
    final instance = KnownledgaConfiguration.instance;
    if (instance != null ) {
      //return instance.workingDirectory;
      return WindowsHelper.getHomeDirectory();
    } else {
      throw Exception("Configuration instance not defined");
    }
    //return KnownledgaConfiguration.instance!.workingDirectory;
    //return WindowsHelper.getHomeDirectory();
  }

  static String getKnownledgaDirectory() {
    String homeDirectory = WindowsHelper.getWorkingDirectory();
    return path.join(homeDirectory, ".knownledga");
  }

  static String getKnownledgaProjectsDirectory() {
    String homeDirectory = WindowsHelper.getWorkingDirectory();
    return path.join(homeDirectory, ".knownledga", "projects");
  }

  static String getKnownledgaProjectDirectory(String projectName) {
    String homeDirectory = WindowsHelper.getWorkingDirectory();
    return path.join(homeDirectory, ".knownledga", "projects", projectName);
  }

  static String getKnownledgaLogPath() {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    return path.join(homeDirectory, ".knownledga", "log.log");
  }

  static String getKnownledgaConfigurationPath() {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    return path.join(homeDirectory, ".knownledga", "configuration.json");
  }

  static String get endline {
    if (Platform.isWindows) {
      return "\r\n";
    } else {
      return "\n";
    }
  }
}