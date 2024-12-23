import 'package:process_run/shell.dart';

class GitHelper {
  static Future<void> clone(String gitUrl, String projectPath) async {
    final shell = Shell();
    print("git clone $gitUrl $projectPath");
    await shell.run("git clone $gitUrl $projectPath");
  }

  static Future<void> add(String projectPath) async {
    final shell = Shell(workingDirectory: projectPath);
    await shell.run("git add *");
  }

  static Future<void> commit(String projectPath) async {
    final shell = Shell(workingDirectory: projectPath);
    await shell.run("git commit -m \"update\"");
  }

  static Future<void> push(String projectPath) async {
    final shell = Shell(workingDirectory: projectPath);
    await shell.run("git push origin");
  }
}