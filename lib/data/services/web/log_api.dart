import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/services/base/log_api.dart';
import 'package:knownledga/data/repositories/core/exception.dart';

class WebLogApi extends BaseLogApi {

  @override
  addLog(LogLevel level, LogComponent component, String message) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  addInfoLog(LogComponent component, String message) {
    addLog(LogLevel.info, component, message);
  }

  @override
  addErrorLog(LogComponent component, String message) {
    addLog(LogLevel.error, component, message);
  }

  @override
  addExceptionLog(LogComponent component, KnowledgaException exception, [StackTrace? stackTrace]) {
    addErrorLog(component, "${exception.code} - ${exception.message}");
  }
}