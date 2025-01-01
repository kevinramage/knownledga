import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/blockquote.dart';
import 'package:knownledga/data/repositories/markdown/checklist.dart';
import 'package:knownledga/data/repositories/markdown/fence.dart';
import 'package:knownledga/data/repositories/markdown/heading.dart';
import 'package:knownledga/data/repositories/markdown/orderedlist.dart';
import 'package:knownledga/data/repositories/markdown/paragraph.dart';
import 'package:knownledga/data/repositories/markdown/table.dart';
import 'package:knownledga/data/repositories/markdown/token.dart';
import 'package:knownledga/data/repositories/markdown/unorderedList.dart';
import 'package:knownledga/data/services/markdown/parser.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/blockquote.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/checklist.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/fence.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/heading.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/linebreak.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/orderedlist.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/paragraph.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/table.dart';
import 'package:knownledga/ui/content/widgets/markdown/render/unorderedlist.dart';

class MarkdownRendererScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const MarkdownRendererScreen({super.key, required EditorViewModel editorViewModel})
     : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _MarkdownRendererScreen();
  }
}

class _MarkdownRendererScreen extends State<MarkdownRendererScreen> {

  List<MarkdownToken> _tokens = [];

  @override
  void initState() {
    final currentElement = widget._editorViewModel.currentElement;
    if (currentElement != null) {
      setState(() {
        _tokens = MarkdownParser().parse(currentElement.elementContent);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTokens(_tokens);
  }

  Widget _buildTokens(List<MarkdownToken> tokens) {
    List<Widget> widgets = [];
    for (var token in tokens) {
      var widget = _buildToken(token);
      if (widget != null) {
        widgets.add(widget);
      }
    }
    return Padding(padding: const EdgeInsets.only(top: 10), child: Align(alignment: Alignment.topLeft, child: Column(children: widgets)));
  }

  Widget? _buildToken(MarkdownToken token) {
    // Heading
    if (token.type == MarkdownTokenType.heading) {
      return MarkdownHeadingScreen(token: token as MarkdownHeadingToken);

    // Paragraph
    } else if (token.type == MarkdownTokenType.paragraph) {
      return MarkdownParagraphScreen(token: token as MarkdownParagraphToken);

    // Ordered list
    } else if (token.type == MarkdownTokenType.orderedList) {
      return MarkdownOrderedScreen(token: token as MarkdownOrderedList);
    
    // Unordored list
    } else if (token.type == MarkdownTokenType.unorderedList) {
      return MarkdownUnorderedScreen(token: token as MarkdownUnorderedList);
    
    // Checklist
    } else if (token.type == MarkdownTokenType.checklist) {
      return MarkdownCheckListScreen(token: token as MarkdownChecklist);
    
    // Fence
    } else if (token.type == MarkdownTokenType.fence) {
      return MarkdownFenceScreen(token: token as MarkdownFence);
    
    // Line break
    } else if (token.type == MarkdownTokenType.lineBreak) {
      return const MarkdownLineBreakScreen();
    
    // Block quote
    } else if (token.type == MarkdownTokenType.blockQuote) {
      return MarkdownBlockQuoteScreen(token: token as MarkdownBlockQuote);
    
    // Table
    } else if (token.type == MarkdownTokenType.table) {
      return MarkdownTableScreen(token: token as MarkdownTable);

    } else {
      return null;
    }
  }
}