import 'package:knownledga/modules/content/models/log.dart';

class LogApi {
  Function? _getLogsFunc;
  Function? _setLogsFunc;

  registerGetLogs(Function getLogs) {
    _getLogsFunc = getLogs;
  }
  registerSetLogs(Function setLogs) {
    _setLogsFunc = setLogs;
  }

  List<ApplicationLog> getAllLogs() {
    final func = _getLogsFunc;
    if (func != null) {
      return func();
    } else {
      return [];
    }
  }
  void setLogs(List<ApplicationLog> logs) {
    final func = _setLogsFunc;
    if (func != null) {
      func(logs);
    }
  }

  void _addLog(ApplicationLog log) {
    final logs = getAllLogs();
    logs.add(log);
    setLogs(logs);
  }
  void addLog(String level, String component, String message) {
    final log = ApplicationLog(component: component, level: level, message: message, date: DateTime.now());
    _addLog(log);
  }
}