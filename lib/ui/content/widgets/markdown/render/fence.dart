import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/fence.dart';

class MarkdownFenceScreen extends StatelessWidget {

  final MarkdownFence _token;

  const MarkdownFenceScreen({super.key, required MarkdownFence token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    return Text(_token.code, softWrap: true);
  }
}