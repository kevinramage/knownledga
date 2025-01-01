import 'package:knownledga/data/repositories/markdown/blockquote.dart';
import 'package:knownledga/data/repositories/markdown/checklist.dart';
import 'package:knownledga/data/repositories/markdown/fence.dart';
import 'package:knownledga/data/repositories/markdown/heading.dart';
import 'package:knownledga/data/repositories/markdown/linebreak.dart';
import 'package:knownledga/data/repositories/markdown/orderedlist.dart';
import 'package:knownledga/data/repositories/markdown/paragraph.dart';
import 'package:knownledga/data/repositories/markdown/table.dart';
import 'package:knownledga/data/repositories/markdown/token.dart';
import 'package:knownledga/data/repositories/markdown/unorderedList.dart';

class MarkdownParser {
  parse(String content) {
    List<MarkdownToken> tokens = [];
    String text = content.replaceAll("\r", "");
    while (text.isNotEmpty) {

      // Heading
      if (_isHeadingExpression(text)) {
        var token = _generateHeadingToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Checklist
      } else if (_isChecklistExpression(text)) {
        var token = _generateChecklistToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Ordered List
      } else if (_isOrderedListExpression(text)) {
        var token = _generateOrderedToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Unordered List
      } else if (_isUnorderedListExpression(text)) {
        var token = _generateUnorderedToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Fence
      } else if (_isFenceExpression(text)) {
        var token = _generateFenceToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Line break
      } else if (_isLineBreakExpression(text)) {
        var token = _generateLineBreakToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Block quote
      } else if (_isBlockQuoteExpression(text)) {
        var token = _generateBlockQuoteToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Table
      } else if (_isTableExpression(text)) {
        var token = _generateTableToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      // Paragraph (Must be the last condition)
      } else if (_isParagraphExpression(text)) {
        var token = _generateParagraphToken(text);
        text = text.substring(token.raw.length);
        tokens.add(token);

      } else {
        throw Exception("MarkdownParser.parse - Invalid block token");
      }
    }
    return tokens;
  }

  _isHeadingExpression(String text) {
    return regexHeading.hasMatch(text);
  }

  _isParagraphExpression(String text) {
    return regexParagraph.hasMatch(text);
  }

  _isOrderedListExpression(String text) {
    return regexOrderedList.hasMatch(text);
  }

  _isUnorderedListExpression(String text) {
    return regexUnorderedList.hasMatch(text);
  }

  _isChecklistExpression(String text) {
    return regexChecklist.hasMatch(text);
  }

  _isFenceExpression(String text) {
    return regexFence.hasMatch(text);
  }

  _isLineBreakExpression(String text) {
    return regexLineBreak.hasMatch(text);
  }

  _isBlockQuoteExpression(String text) {
    return regexBlockQuote.hasMatch(text);
  }

  _isTableExpression(String text) {
    return regexTable.hasMatch(text);
  }

  _generateHeadingToken(String text) {
    var matches = regexHeading.firstMatch(text);
    if (matches != null) {
      String raw = matches.group(0).toString();
      int level = matches.group(1)!.length;
      String content = matches.group(2).toString();
      return MarkdownHeadingToken(type: MarkdownTokenType.heading, level: level, raw: raw, content: content);
    } else {
      return null;
    }
  }

  _generateParagraphToken(String text) {
    var matches = regexParagraph.allMatches(text);
    if (matches.isNotEmpty) {
      String raw = matches.first.group(0).toString();
      String content = matches.first.group(1).toString();
      return MarkdownParagraphToken(type: MarkdownTokenType.paragraph, raw: raw, text: content);
    } else {
      return null;
    }
  }

  _generateUnorderedToken(String text) {
    var iterator = regexUnorderedList.allMatches(text).iterator;
    String totalRaw = "";
    List<MarkdownUnorderedListElement> elements = [];
    while (iterator.moveNext()) {
      String raw = iterator.current.group(0).toString();
      //int level = iterator.current.group(2).toString().length;
      String content = iterator.current.group(3).toString();
      elements.add(MarkdownUnorderedListContent(content: content));
      totalRaw += raw;
    }
    return MarkdownUnorderedList(type: MarkdownTokenType.unorderedList, raw: totalRaw, elements: elements);
  }

  _generateOrderedToken(String text) {
    int indexElt = 1;
    var iterator = regexOrderedList.allMatches(text).iterator;
    String totalRaw = "";
    List<MarkdownOrderedListElement> elements = [];
    
    while (iterator.moveNext()) {
      String raw = iterator.current.group(0).toString();
      //int level = iterator.current.group(2).toString().length;
      String content = iterator.current.group(3).toString();
      elements.add(MarkdownOrderedListContent(index: indexElt.toString(), content: content));
      totalRaw += raw;
      indexElt++;
    }
    return MarkdownOrderedList(type: MarkdownTokenType.orderedList, raw: totalRaw, elements: elements);
  }

  _generateChecklistToken(String text) {
    var iterator = regexChecklist.allMatches(text).iterator;
    String totalRaw = "";
    List<MarkdownChecklistElement> elements = [];
    while (iterator.moveNext()) {
      String raw = iterator.current.group(0).toString();
      bool checked = iterator.current.group(2).toString().toUpperCase() == "X";
      String title = iterator.current.group(3).toString();
      elements.add(MarkdownChecklistElement(checked: checked, title: title));
      totalRaw += raw;
    }
    return MarkdownChecklist(type: MarkdownTokenType.checklist, raw: totalRaw, elements: elements);
  }

  _generateFenceToken(String text) {
    var matches = regexFence.firstMatch(text);
    if (matches != null) {
      String raw = matches.group(0).toString();
      String code = matches.group(3).toString().trim();
      return MarkdownFence(type: MarkdownTokenType.fence, raw: raw, code: code);
    } else {
      return null;
    }
  }

  _generateLineBreakToken(String text) {
    var matches = regexLineBreak.firstMatch(text);
    if (matches != null) {
      String raw = matches.group(0).toString();
      return MarkdownLineBreak(type: MarkdownTokenType.lineBreak, raw: raw);
    } else {
      return null;
    }
  }

  _generateBlockQuoteToken(String text) {
    var matches = regexBlockQuote.firstMatch(text);
    if (matches != null) {
      String raw = matches.group(0).toString();
      String code = matches.group(2).toString();
      return MarkdownBlockQuote(type: MarkdownTokenType.blockQuote, raw: raw, text: code);
    } else {
      return null;
    }
  }

  _generateTableToken(String text) {
    var matches = regexTable.firstMatch(text);
    if (matches != null) {
      String raw = matches.group(0).toString();
      String headersContent = matches.group(1).toString();
      String cellsContent = matches.group(3).toString();
      List<MarkdownTableHeader> headers = _generateTableHeaders(headersContent);
      List<MarkdownTableLine> lines = _generateTableLines(cellsContent);
      return MarkdownTable(type: MarkdownTokenType.table, raw: raw, headers: headers, lines: lines);
    } else {
      return null;
    }
  }

  List<MarkdownTableHeader> _generateTableHeaders(String headersContent) {
    List<String> headers = headersContent.trim().split("|").map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
    return headers.map((h) => MarkdownTableHeader(headerName: h)).toList();
  }
  List<MarkdownTableLine> _generateTableLines(String cellsContent) {
    var lines = cellsContent.trim().split("\n");
    return lines.map((l) => _generateTableLine(l)).toList();
  }
  MarkdownTableLine _generateTableLine(String lineContent) {
    List<String> cellsList = lineContent.trim().split("|").map((c) => c.trim()).where((c) => c.isNotEmpty).toList();
    List<MarkdownTableCell> cells = cellsList.map((c) => MarkdownTableCell(content: c)).toList();
    return MarkdownTableLine(cells: cells);
  }
}