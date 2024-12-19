import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/widgets/editor_screen.dart';
import 'package:knownledga/ui/content/widgets/informations_screen.dart';
import 'package:knownledga/data/services/api.dart';

class ContentScreen extends StatelessWidget {

  final Api api;

  const ContentScreen({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      width: double.infinity, 
      height: double.infinity, 
      color: Colors.grey.shade700,
      child: Column(children: [
        ContentEditorScreen(api: api),
        ContentInformationsScreen(api: api)
      ])
    ));
  }
}