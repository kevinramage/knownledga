import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// 1. Level1
//   1.1. Level 1.1
//     1.1.1. Level 1.1.1
// 2. Level 2
class MarkdownOrderedList extends MarkdownToken {
  final List<MarkdownOrderedListElement> elements;

  MarkdownOrderedList({required super.type, required super.raw, required this.elements});
}

abstract class MarkdownOrderedListElement {
  int level = 1;
}

class MarkdownOrderedListSubList extends MarkdownOrderedListElement {
  List<MarkdownOrderedListElement> elements = [];
}
class MarkdownOrderedListContent extends MarkdownOrderedListElement {
  String index = "";
  String content = "";

  MarkdownOrderedListContent({required this.index, required this.content});
}