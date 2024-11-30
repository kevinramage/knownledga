import 'package:flutter/material.dart';
import 'package:knownledga/modules/content/screens/content_screen.dart';
import 'package:knownledga/modules/explorer/screens/explorer_screen.dart';
import 'package:knownledga/utils/services/api.dart';

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