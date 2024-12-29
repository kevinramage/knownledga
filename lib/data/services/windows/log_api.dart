import 'dart:io';

import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/services/base/log_api.dart';
import 'package:knownledga/data/repositories/core/exception.dart';
import 'package:knownledga/data/services/helper/window_helper.dart';

class WindowsLogApi extends BaseLogApi {

  _writeContent(String content) async {
    String logPath = WindowsHelper.getKnownledgaLogPath();
    final file = File(logPath);
    await file.writeAsString(content, mode: FileMode.append);
  }

  @override
  addLog(LogLevel level, LogComponent component, String message) async {
    String logContent = ApplicationLog(date: DateTime.now(), level: level, component: component, message: message).toString();
    await _writeContent(logContent);
  }

  @override
  addInfoLog(LogComponent component, String message) async {
    await addLog(LogLevel.info, component, message);
  }

  @override
  addErrorLog(LogComponent component, String message) async {
    await addLog(LogLevel.error, component, message);
  }

  @override
  addExceptionLog(LogComponent component, KnowledgaException exception, [StackTrace? stackTrace]) async {
    await addErrorLog(component, "${exception.code} - ${exception.message}");
    if (stackTrace != null) {
      await _writeContent(stackTrace.toString());
    }
  }
}