abstract class MarkdownToken {
  MarkdownTokenType type;
  String raw;

  MarkdownToken({required this.type, required this.raw});
}

enum MarkdownTokenType { heading, paragraph, unorderedList, orderedList, checklist, fence, lineBreak, blockQuote, table, link, text, bold, strike, italic}

/// BLOCK
var regexHeading = RegExp(r'^ {0,3}(#{1,6})(?=\s|$)(.*)(?:\n+|$)');
var regexHeadingAlternative = RegExp(r'^ {0,3}(.*)\n([=|-]{2,})^ {0,3}(.*)\n([=|-]{2,})');
var regexParagraph = RegExp(r'^([^\n]+(?:\n[^\n]+)*)');
var regexOrderedList = RegExp(r'^(( {0,})(?:\d{1,9}[.)]))([ \t][^\n]+?)?(?:\n|$)');
var regexUnorderedList = RegExp(r'^(( {0,})(?:[*+-]))([ \t][^\n]+?)?(?:\n|$)');
var regexChecklist = RegExp(r'^( {0,3}(?:[*+-]))[ \t]\[(x|X| )\]([^\n]+?)?(?:\n|$)');
var regexFence = RegExp(r'^ {0,3}(`{3,}(?=[^`\n]*(?:\n|$))|~{3,})([^\n]*)(?:\n|$)(?:|([\s\S]*?)(?:\n|$))(?: {0,3}\1[~`]* *(?=\n|$)|$)');
var regexLineBreak = RegExp(r'^\n(?!\s*$)');
var regexBlockQuote = RegExp(r'^( {0,3}> ?([^\n]*)(?:\n|$))+');
var regexTable = RegExp(r'^ *([^\\n ].*)\n {0,3}((?:\| *)?:?-+:? *(?:\| *:?-+:? *)*(?:\| *)?)(?:\n((?:(?! *\n).*(?:\n|$))*)\n*|$)');

/// INLINE
var regexLink = RegExp(r'^\[([^\n]+)\]\(([a-zA-Z][a-zA-Z0-9+.-]{1,31}:\/\/[^\s\x00-\x1f<>]*)\)');
var regexText = RegExp(r'^(`+|[^`])(?:(?= {2,}\n)|[\s\S]*?(?:(?=[\\<!\[`*_]|\b_|$|\n|~~.+~~|[\*|_]{1,2}.+[\*|_]{1,2})|[^ ](?= {2,}\n)))');
var regexBold = RegExp(r'^[(\*|_]{2}([^\n]+)[(\*|_]{2}');
var regexItalic = RegExp(r'^[(\*|_]([^\n]+)[(\*|_]');
var regexStrike = RegExp(r'^(~~?)(?=[^\s~])([\s\S]*?[^\s~])\1(?=[^~]|$)');