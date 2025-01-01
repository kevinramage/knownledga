import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/repositories/core/exception.dart';

abstract class BaseLogApi {

  /*
   * All interfaces
   */
  addLog(LogLevel level, LogComponent component, String message);
  addInfoLog(LogComponent component, String message);
  addErrorLog(LogComponent component, String message);
  addExceptionLog(LogComponent component, KnowledgaException exception, [StackTrace? stackTrace]);
}