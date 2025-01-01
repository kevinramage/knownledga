import 'package:knownledga/data/repositories/markdown/token.dart';

class MarkdownTable extends MarkdownToken {
  List<MarkdownTableHeader> headers = [];
  List<MarkdownTableLine> lines = [];

  MarkdownTable({required super.type, required super.raw, required this.headers, required this.lines});
}

class MarkdownTableHeader {
  String headerName = "";

  MarkdownTableHeader({required this.headerName});
}

class MarkdownTableLine {
  List<MarkdownTableCell> cells = [];

  MarkdownTableLine({required this.cells});
}

class MarkdownTableCell {
  String content = "";

  MarkdownTableCell({required this.content});
}