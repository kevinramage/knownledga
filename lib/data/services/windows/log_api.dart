import 'dart:io';

import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/services/base/log_api.dart';
import 'package:knownledga/data/services/window_helper.dart';

class WindowsLogApi extends BaseLogApi {

  @override
  addLog(LogLevel level, LogComponent component, String message) async {
    String logPath = WindowsHelper.getKnownledgaLogPath();
    String logContent = ApplicationLog(date: DateTime.now(), level: level, component: component, message: message).toString();
    final file = File(logPath);
    await file.writeAsString(logContent, mode: FileMode.append);
  }

  @override
  addInfoLog(LogComponent component, String message) {
    addLog(LogLevel.info, component, message);
  }

  @override
  addErrorLog(LogComponent component, String message) {
    addLog(LogLevel.error, component, message);
  }
}