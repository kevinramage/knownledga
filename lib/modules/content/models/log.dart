class ApplicationLog {
  static const logLevelError = "ERROR";
  static const logLevelWarn = "WARN";
  static const logLevelInfo = "INFO";

  DateTime date;
  String level;
  String component;
  String message;

  ApplicationLog({required this.date, required this.level, required this.component, required this.message});
}