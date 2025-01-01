import 'package:intl/intl.dart';
import 'package:knownledga/data/services/helper/window_helper.dart';

class ApplicationLog {
  DateTime date;
  LogLevel level;
  LogComponent component;
  String message;

  ApplicationLog({required this.date, required this.level, required this.component, required this.message});

  @override
  String toString() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formattedDate = formatter.format(now);
    return "$formattedDate - ${LogLevelUtils.toText(level)} - ${LogComponentUtils.toText(component)} - $message${WindowsHelper.endline}";
  }
}

enum LogLevel { debug, info, warn, error, severe }
class LogLevelUtils {
  static toText(LogLevel logLevel) {
    switch (logLevel) {
      case LogLevel.debug: return "debug";
      case LogLevel.info: return "info";
      case LogLevel.warn: return "warn";
      case LogLevel.error: return "error";
      case LogLevel.severe: return "severe";
    }
  }
}

enum LogComponent { application, project }
class LogComponentUtils {
static toText(LogComponent logComponent) {
    switch (logComponent) {
      case LogComponent.application: return "application";
      case LogComponent.project: return "project";
    }
  }
}