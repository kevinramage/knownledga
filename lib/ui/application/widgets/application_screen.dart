import 'package:flutter/material.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/content/view_models/content_viewmodel.dart';
import 'package:knownledga/ui/content/widgets/content_screen.dart';
import 'package:knownledga/ui/explorer/view_models/explorer_viewmodel.dart';
import 'package:knownledga/ui/explorer/widgets/explorer_screen.dart';

class ApplicationScreen extends StatefulWidget {

  final ApplicationViewModel _viewModel;
  final ExplorerViewModel _explorerViewModel;
  final ContentViewModel _contentViewModel;
  
  ApplicationScreen({super.key, required ApplicationViewModel viewModel}) :
    _viewModel = viewModel,
    _explorerViewModel = ExplorerViewModel(application: viewModel),
    _contentViewModel = ContentViewModel(applicationViewModel: viewModel) {
    viewModel.contentViewModel = _contentViewModel;
  }

  @override
  State<StatefulWidget> createState() {
    return _ApplicationScreen();
  }
}

class _ApplicationScreen extends State<ApplicationScreen> {

  @override
  void initState() {

    // Initialize and load configuration
    widget._viewModel.loadConfiguration().then((_) {
      // Load projects
      widget._explorerViewModel.loadProjects();

    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget._viewModel, builder: (context, child) {
      return Row(children: [
        ExplorerScreen(explorer: widget._explorerViewModel),
        ContentScreen(contentViewModel: widget._contentViewModel)
      ]);
    });
  }
}