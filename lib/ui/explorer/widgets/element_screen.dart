import 'package:flutter/material.dart';
import 'package:knownledga/ui/core/widgets/expansion_element.dart';
import 'package:knownledga/ui/explorer/view_models/element_viewmodel.dart';

class ElementExplorerScreen extends StatefulWidget {

  final ElementViewModel _viewModel;

  const ElementExplorerScreen({super.key, required ElementViewModel elementViewModel}) : 
    _viewModel = elementViewModel;

  @override
  State<StatefulWidget> createState() {
    return _ElementExplorerScreen();
  }
}

class _ElementExplorerScreen extends State<ElementExplorerScreen> {

  final TextEditingController _controllerRenameElement = TextEditingController(text: "");
  final FocusNode _focusRenameElement = FocusNode();

  @override
  void dispose() {
    _controllerRenameElement.dispose();
    _focusRenameElement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: elementViewModel, builder: (context, builder) {
      return ExpansionElement(
        leading: const Icon(Icons.text_snippet_sharp, color: Colors.white, size: 15),
        title: _buildChildTextElement(elementViewModel),
        isExpandable: false,
        commands: [
          _openElementBtn(elementViewModel),
          _renameElementBtn(elementViewModel),
          _deleteElementBtn(elementViewModel)
        ],
      );
    });
  }

    Widget _buildChildTextElement(ElementViewModel elementViewModel) {
    if (elementViewModel.isRenaming) {
      return Container(width: 200, padding: const EdgeInsets.all(0), child: TextField(
        cursorHeight: 12,
        cursorColor: Colors.white,
        focusNode: _focusRenameElement,
        canRequestFocus: true,
        style: const TextStyle(fontSize: 12, height: 2, color: Colors.white, decoration: TextDecoration.none),
        textAlignVertical: const TextAlignVertical(y: 0),
        controller: _controllerRenameElement,
        decoration: const InputDecoration(isDense: true),
        onSubmitted: (value) {
          elementViewModel.renameElement(value);
        },
        onTapOutside: (_) {
          elementViewModel.cancelRenaming();
        },
      ));
    } else {
      return Text(elementViewModel.elementName, 
        style: const TextStyle(fontSize: 12, color: Colors.white, decoration: TextDecoration.none)
      );
    }
  }

  Widget _openElementBtn(ElementViewModel element) {
    return IconButton(
      onPressed: () {
        element.openElement();
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.launch, size: 15, color: Colors.white)
    );
  }

  Widget _renameElementBtn(ElementViewModel element) {
    return IconButton(
      onPressed: () async {
        _controllerRenameElement.text = element.elementName;
        element.isRenaming = true;
        _focusRenameElement.requestFocus();
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.edit, size: 15, color: Colors.white)
    );
  }

  Widget _deleteElementBtn(ElementViewModel element) {
    return IconButton(
      onPressed: () {
        element.projectViewModel.deleteElement(element);
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.delete, size: 15, color: Colors.white)
    );
  }


  ElementViewModel get elementViewModel {
    return widget._viewModel;
  }
}