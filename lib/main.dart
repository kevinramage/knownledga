import 'package:flutter/material.dart';
import 'package:knownledga/data/services/api.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/application/widgets/application_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knownledga',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.lightBlue)
      ),
      home: Scaffold(
        body: ApplicationScreen(viewModel: ApplicationViewModel(api: Api.init()))
      ),
    );
  }
}