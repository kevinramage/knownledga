import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/heading.dart';

class MarkdownHeadingScreen extends StatelessWidget {

  final MarkdownHeadingToken _token;
  const MarkdownHeadingScreen({super.key, required MarkdownHeadingToken token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    if (_token.level == 1) {
      return _buildHead1();
    } else if (_token.level == 2) {
      return _buildHead2();
    } else if (_token.level == 3) {
      return _buildHead3();
    } else if (_token.level == 4) {
      return _buildHead4();
    } else if (_token.level == 5) {
      return _buildHead5();
    } else if (_token.level == 6) {
      return _buildHead6();
    } else {
      throw Exception("Invalid heading token - invalid level: ${_token.level}");
    }
  }

  _buildHead1() {
    return Text(_token.content, textAlign: TextAlign.left, style: const TextStyle(fontSize: 30));
  }

  _buildHead2() {
    return Text(_token.content, textAlign: TextAlign.left, style: const TextStyle(fontSize: 26));
  }

  _buildHead3() {
    return Text(_token.content, textAlign: TextAlign.left, style: const TextStyle(fontSize: 24));
  }

  _buildHead4() {
    return Text(_token.content, textAlign: TextAlign.left, style: const TextStyle(fontSize: 20));
  }

  _buildHead5() {
    return Text(_token.content, textAlign: TextAlign.left, style: const TextStyle(fontSize: 18));
  }

  _buildHead6() {
    return Text(_token.content, textAlign: TextAlign.left, style: const TextStyle(fontSize: 16));
  }
}