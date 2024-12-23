import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knownledga/ui/content/view_models/editor_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class EditorFileScreen extends StatefulWidget {

  final EditorViewModel _editorViewModel;

  const EditorFileScreen({super.key, required EditorViewModel editorViewModel}) : _editorViewModel = editorViewModel;

  @override
  State<StatefulWidget> createState() {
    return _EditorFileScreen();
  }
}

class _EditorFileScreen extends State<EditorFileScreen> {

  final TextEditingController _textController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EditorFileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: viewModel, builder: (builder, context) {
      if (viewModel.currentElement != null) {
        _textController.text = viewModel.currentElement!.elementContent;
      }
      return Expanded(child: buildScreen());
    });
  }

  buildScreen() {
    final elt = viewModel.currentElement;
    if (elt != null) {
      return Padding(padding: const EdgeInsets.only(left: 10), child: Shortcuts(
        shortcuts: _buildShortcuts(),
        child: Actions(
          actions: _buildActions(),
          child: _buildTextField()
        )
      ));
    } else {
      return const Text("");
    }
  }

  Map<ShortcutActivator, Intent> _buildShortcuts() {
    return {
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS): const SaveFileIntent()
    };
  }

  Map<Type, Action<Intent>> _buildActions() {
    return {
      SaveFileIntent: CallbackAction(onInvoke: (i) {
        final currentElt = viewModel.currentElement as ElementViewModel;
        viewModel.applicationViewModel.saveElement(currentElt);
        return null;
      })
    };
  }

  Widget _buildTextField() {
    return TextField(
      key: UniqueKey(),
      autofocus: true,
      controller: _textController,
      scrollController: ScrollController(keepScrollOffset: true),
      maxLines: 200,
      onChanged: (value) {
        viewModel.currentElement!.elementContent = value;
      }
    );
  }

  EditorViewModel get viewModel {
    return widget._editorViewModel;
  }
}

class SaveFileIntent extends Intent {
  const SaveFileIntent();
}