import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// - [ ] Elt1
// - [x] Elt2
class MarkdownChecklist extends MarkdownToken {
  List<MarkdownChecklistElement> elements = [];

  MarkdownChecklist({required super.type, required super.raw, required this.elements});
}

class MarkdownChecklistElement {
  bool checked = false;
  String title = "";

  MarkdownChecklistElement({required this.checked, required this.title});
}