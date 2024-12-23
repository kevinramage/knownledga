import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/view_models/content_viewmodel.dart';
import 'package:knownledga/ui/content/widgets/editor_screen.dart';

class ContentScreen extends StatelessWidget {

  final ContentViewModel _contentViewModel; 
  //final Api api;

  const ContentScreen({super.key, required ContentViewModel contentViewModel}) : _contentViewModel = contentViewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      width: double.infinity, 
      height: double.infinity, 
      color: Colors.grey.shade700,
      child: Column(children: [
        ContentEditorScreen(editorViewModel: _contentViewModel.editorViewModel),
        //ContentInformationsScreen(api: api)
      ])
    ));
  }
}