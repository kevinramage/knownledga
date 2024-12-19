import 'package:flutter/material.dart';
import 'package:knownledga/ui/content/widgets/content_screen.dart';
import 'package:knownledga/ui/explorer/widgets/explorer_screen.dart';
import 'package:knownledga/data/services/api.dart';

class ApplicationScreen extends StatelessWidget {

  final Api api = Api.init();
  
  ApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ExplorerScreen(api: api),
      ContentScreen(api: api)
    ]);
  }
}