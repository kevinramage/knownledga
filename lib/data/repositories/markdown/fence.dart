import 'package:knownledga/data/repositories/markdown/token.dart';

// Example
// ```java
// class Test {}
// ```
class MarkdownFence extends MarkdownToken {
  String language = "";
  String code = "";

  MarkdownFence({required super.type, required super.raw, required this.code});
}