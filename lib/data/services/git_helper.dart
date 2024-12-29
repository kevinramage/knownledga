import 'package:knownledga/data/repositories/core/exception.dart';
import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/data/services/base/log_api.dart';
import 'package:process_run/shell.dart';

class GitHelper {

  static void _logInfo(BaseLogApi logger, String message) {
    logger.addInfoLog(LogComponent.project, message);
  }
  static void _logException(BaseLogApi logger, KnowledgaException exception, [StackTrace? stackTrace]) {
    logger.addExceptionLog(LogComponent.project, exception, stackTrace);
  }

  static Future<void> clone(BaseLogApi logger, String gitUrl, String projectPath) async {
    _logInfo(logger, "Git clone $gitUrl to $projectPath");
    final shell = Shell();
    try {
      await shell.run("git clone $gitUrl $projectPath");
      _logInfo(logger, "Git clone completed successfully");

    } catch (e, stackTrace) {
      KnowledgaException exception = KnowledgaException(code: codeProjectGitCloneTechnical, message: "Git clone failed, error message: ${e.toString()}");
      _logException(logger, exception, stackTrace);
      throw exception;
    }
  }

  static Future<void> add(BaseLogApi logger, String projectPath) async {
    _logInfo(logger, "Git add to $projectPath");
    final shell = Shell(workingDirectory: projectPath);
    try {
      await shell.run("git add *");
      _logInfo(logger, "Git add done successfully");

    } catch (e, stackTrace) {
      KnowledgaException exception = KnowledgaException(code: codeProjectGitCloneTechnical, message: "Git clone failed, error message: ${e.toString()}");
      _logException(logger, exception, stackTrace);
      throw exception;
    }
  }

  static Future<void> commit(BaseLogApi logger, String projectPath) async {
    _logInfo(logger, "Git commit to $projectPath");
    final shell = Shell(workingDirectory: projectPath);
    try {
      await shell.run("git commit -m \"update\"");
      _logInfo(logger, "Git commit done successfully");

    } catch (e, stackTrace) {
      KnowledgaException exception = KnowledgaException(code: codeProjectGitCloneTechnical, message: "Git clone failed, error message: ${e.toString()}");
      _logException(logger, exception, stackTrace);
      throw exception;
    }
  }

  static Future<void> push(BaseLogApi logger, String projectPath) async {
    _logInfo(logger, "Git push to $projectPath");
    final shell = Shell(workingDirectory: projectPath);
    try {
      await shell.run("git push origin");
      _logInfo(logger, "Git push done successfully");

    } catch (e, stackTrace) {
      KnowledgaException exception = KnowledgaException(code: codeProjectGitCloneTechnical, message: "Git clone failed, error message: ${e.toString()}");
      _logException(logger, exception, stackTrace);
      throw exception;
    }
  }
}