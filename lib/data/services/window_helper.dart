import 'dart:io';
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

  static String getKnownledgaDirectory() {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    return path.join(homeDirectory, ".knownledga");
  }

  static String getKnownledgaProjectsDirectory() {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    return path.join(homeDirectory, ".knownledga", "projects");
  }

  static String getKnownledgaProjectDirectory(String projectName) {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    return path.join(homeDirectory, ".knownledga", "projects", projectName);
  }

  static String getKnownledgaLogPath() {
    String homeDirectory = WindowsHelper.getHomeDirectory();
    return path.join(homeDirectory, ".knownledga", "log.log");
  }

  static String get endline {
    if (Platform.isWindows) {
      return "\r\n";
    } else {
      return "\n";
    }
  }
}