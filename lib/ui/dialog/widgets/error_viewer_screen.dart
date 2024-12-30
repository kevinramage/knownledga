import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/core/exception.dart';

class DialogErrorViewerScreen {

  Future<void> show(BuildContext context, KnowledgaException exception) async {
    await showDialog(context: context, builder: (_) {
      return ErrorViewerScreen(exception: exception);
    });
  }
}

class ErrorViewerScreen extends StatefulWidget {

  final KnowledgaException exception;

  const ErrorViewerScreen({super.key, required this.exception});

  @override
  State<StatefulWidget> createState() {
    return _ErrorViewerScreen();
  }
}

class _ErrorViewerScreen extends State<ErrorViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      actionsPadding: const EdgeInsets.only(left: 10, right: 50, bottom: 10),
      title: Container(color: Colors.red, child: Padding(
        padding: const EdgeInsets.only(left: 20), 
        child: Text("ERROR - ${widget.exception.code}", style: const TextStyle(color: Colors.white))
      )),
      content: SizedBox(height: 100.0, child: Text(widget.exception.message)),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () { Navigator.pop(context, "OK"); }, 
          child: const Text("OK")
        )
      ]
    );
  }
}