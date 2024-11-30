import 'package:flutter/material.dart';
import 'package:knownledga/modules/content/models/log.dart';

class ContentLogScreen extends StatelessWidget {

  final List<ApplicationLog> logs;

  const ContentLogScreen({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.right, 
      child: ListView(
        primary: true,
        children: logs.map((l) => buildLog(l)).toList(),
      )
    );
  }

  Row buildLog(ApplicationLog log) {
    final logDate = log.date.toString();
    return Row(children: [
        Text("$logDate - ", style: const TextStyle(color: Colors.white, decoration: TextDecoration.none)),
        buildLogLevel(log),
        const Text(" - ", style: TextStyle(color: Colors.white, decoration: TextDecoration.none)),
        Padding(padding: const EdgeInsets.only(left: 10), child: Text(log.message, style: const TextStyle(color: Colors.white, decoration: TextDecoration.none)))
    ]);
  }

  buildLogLevel(ApplicationLog log) {
    if (log.level == ApplicationLog.logLevelError) {
      return const Text("ERROR", style: TextStyle(color: Colors.red, decoration: TextDecoration.none, fontWeight: FontWeight.w400));
    } else if (log.level == ApplicationLog.logLevelWarn) {
      return const Text("WARN", style: TextStyle(color: Colors.deepOrange, decoration: TextDecoration.none, fontWeight: FontWeight.w400));
    } else if (log.level == ApplicationLog.logLevelDebug) {
      return const Text("DEBUG", style: TextStyle(color: Colors.grey, decoration: TextDecoration.none, fontWeight: FontWeight.w400));
    } else {
      return const Text("INFO", style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.w400));
    }
  }
}