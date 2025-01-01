import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// * Level1
//   * Level 1.1
//     * Level 1.1.1
// * Level 2
class MarkdownUnorderedList extends MarkdownToken {
  final List<MarkdownUnorderedListElement> elements;

  MarkdownUnorderedList({required super.type, required super.raw, required this.elements});
}

abstract class MarkdownUnorderedListElement {
  int level = 1;
}

class MarkdownUnorderedListSubList extends MarkdownUnorderedListElement {
  List<MarkdownUnorderedListElement> elements = [];
}
class MarkdownUnorderedListContent extends MarkdownUnorderedListElement {
  String content = "";

  MarkdownUnorderedListContent({required this.content});
}