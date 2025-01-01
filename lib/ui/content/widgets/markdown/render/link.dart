import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownLinkScreen extends StatelessWidget {

  final MarkdownLink _token;

  const MarkdownLinkScreen({super.key, required MarkdownLink token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Text(_token.title), onTap: (){
      launchUrl(Uri.parse(_token.link));
    });
  }
}