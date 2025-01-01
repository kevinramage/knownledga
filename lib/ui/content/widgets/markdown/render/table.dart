import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/markdown/table.dart';

class MarkdownTableScreen extends StatelessWidget {

  final MarkdownTable _token;

  const MarkdownTableScreen({super.key, required MarkdownTable token}) : _token = token;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [ _buildHeaders() ];
    widgets.addAll(_token.lines.map((l) => _buildLine(l)).toList());
    return Column(children: widgets);
  }

  Widget _buildHeaders() {
    return Row(children: _token.headers.map((h) => _buildHeader(h)).toList());
  }
  Widget _buildHeader(MarkdownTableHeader header) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100),
      decoration: BoxDecoration(border: Border.all(width: 0.8, color: Colors.grey.shade800)),
      padding: const EdgeInsets.all(5),
      child: Center(child: Text(header.headerName, style: const TextStyle(fontWeight: FontWeight.w600)))
    );
  }

  Widget _buildLine(MarkdownTableLine line) {
    return Row(children: line.cells.map((c) => _buildCell(c)).toList());
  }

  Widget _buildCell(MarkdownTableCell cell) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100),
      decoration: BoxDecoration(border: Border.all(width: 0.7, color: Colors.grey.shade700)),
      padding: const EdgeInsets.all(5),
      child: Center(child: Text(cell.content))
    ); 
  }
}