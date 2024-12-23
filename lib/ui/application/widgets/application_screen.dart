import 'package:flutter/material.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/content/widgets/content_screen.dart';
import 'package:knownledga/ui/explorer/view_models/explorer_viewmodel.dart';
import 'package:knownledga/ui/explorer/widgets/explorer_screen.dart';

class ApplicationScreen extends StatelessWidget {

  final ApplicationViewModel _viewModel;
  
  const ApplicationScreen({super.key, required ApplicationViewModel viewModel}) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: _viewModel, builder: (context, child) {
      return Row(children: [
        ExplorerScreen(explorer: ExplorerViewModel(application: _viewModel)),
        ContentScreen(api: _viewModel.api)
      ]);
    });
  }
}