import 'package:flutter/material.dart';

class ExpansionElement extends StatefulWidget {

  final Widget _title;
  final Icon? _leading;
  final List<Widget>? _commands;
  final List<Widget>? _children;
  final bool? _expanded;
  final bool? _isExpandable;
  final Function? _onClick;

  const ExpansionElement({
    super.key,
    required Widget title,
    Icon? leading,
    List<Widget>? children,
    List<Widget>? commands,
    bool? expanded,
    bool? isExpandable,
    Function? onClick,
  }) : _title = title, 
      _leading = leading, 
      _children = children,
      _commands = commands,
      _expanded = expanded,
      _isExpandable = isExpandable,
      _onClick = onClick;

  @override
  State<StatefulWidget> createState() {
    return _ExpansionElement();
  }
}

class _ExpansionElement extends State<ExpansionElement> {

  bool expanded = false;

  @override
  void initState() {
    if (widget._expanded != null) {
      setState(() { expanded = widget._expanded as bool; });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildExpansionContent(),
      onTap: () {
        if (widget._isExpandable == null || widget._isExpandable == true) {
          setState(() { expanded = !expanded; });
        }
      },
    );
  }

  Widget _buildExpansionContent() {
    List<Widget> widgets = [ SizedBox(
      height: 22, 
      child: Padding(
        padding: const EdgeInsets.only(top: 2, left: 10),
        child: _buildExpansionTitle(),
      ) 
    )];
    if (expanded) {
      if (widget._children != null) {
        widgets.addAll(widget._children as List<Widget>);
      } else {
        widgets.add(const SizedBox(height: 20));
      }
      widgets.add(const Divider());
    }
    return Column(children: widgets);
  }

  Widget _buildExpansionTitle() {
    List<Widget> widgets = [];
    if (widget._leading != null) {
      widgets.add(Padding(padding: const EdgeInsets.only(right: 15), child: widget._leading));
    }
    if (widget._onClick != null && (widget._isExpandable == null || widget._isExpandable == false)) {
      widgets.add(_buildExpansionClickableTitle());
    } else {
      widgets.add(widget._title);
    }
    widgets.add(const Expanded(child: Text("")));
    if (widget._commands != null) {
      widgets.addAll(widget._commands as List<Widget>);
    }
    if (widget._isExpandable == null || widget._isExpandable == true) {
      widgets.add(Padding(padding: const EdgeInsets.only(left: 5, right: 5), child: _buildExpansionIcon()));
    }

    return Row(children: widgets);
  }

  Widget _buildExpansionClickableTitle() {
    return GestureDetector(
      child: widget._title,
      onTap: () {
        final onClick = widget._onClick;
        print("OnTap");
        if ((widget._expanded == null || widget._expanded == false) && onClick != null) {
          onClick();
        }
      },
    );
  }

  Widget _buildExpansionIcon() {
    if (expanded) {
      return const Icon(Icons.expand_less, color: Colors.white);
    } else {
      return const Icon(Icons.expand_more, color: Colors.white);
    }
  }
}