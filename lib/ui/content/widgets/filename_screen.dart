import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/data/services/api.dart';

class FileNameScreen extends StatefulWidget {

  final Api api;
  final ProjectElement? activeElement;

  const FileNameScreen({super.key, required this.api, required this.activeElement});

  @override
  State<StatefulWidget> createState() {
    return _FileNameScreen();
  }
}

class _FileNameScreen extends State<FileNameScreen> {

  bool saved = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FileNameScreen oldWidget) {
    final newElt = widget.activeElement;
    if (newElt != null) {
      setState(() { saved = newElt.saved; });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.grey.shade800,
      child: buildTabFile()
    );
  }

  Widget? buildTabFile() {
    final elt = widget.activeElement;
    if (elt != null) {
      final savedSection = saved ? const Text("") : const Icon(Icons.circle, color: Colors.white);
      return Container(
        width: 180, height: 25,
        color: Colors.grey.shade600,
        child: Padding(padding: const EdgeInsets.only(left: 5, top: 2),
          child: Row(children: [
            Text(elt.name, textAlign: TextAlign.left, 
              style: const TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 12)
            ),
            const Expanded(child: Text("")),
            savedSection,
            IconButton(icon: const Icon(Icons.close, color: Colors.white), padding: const EdgeInsets.all(0), onPressed: () {
              widget.api.content.setActiveElt(null);
            })
          ]
        ))
      );
    } else {
      return null;
    }
  }
}