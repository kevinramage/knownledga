import 'dart:io';

import 'package:flutter/foundation.dart';

class KnownledgaConfiguration {
  static KnownledgaConfiguration? instance;
  final String workingDirectory;

  const KnownledgaConfiguration({required this.workingDirectory});

  Map<String, dynamic> toJSON() {
    return {
      "workingDir": workingDirectory.replaceAll("\\", "/")
    };
  }

  factory KnownledgaConfiguration.fromJSON(Map<String, dynamic> data) {
    String workingDirectory = data[configFieldWorkingDirectory];
    if (!kIsWeb && Platform.isWindows) {
      workingDirectory = workingDirectory.replaceAll("/", "\\");
    }
    return KnownledgaConfiguration(workingDirectory: workingDirectory);
  }

  factory KnownledgaConfiguration.init() {
    return const KnownledgaConfiguration(workingDirectory: "C:\\Knownledga");
  }
}

const String configFieldWorkingDirectory = "workingDir";