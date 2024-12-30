import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/core/exception.dart';
import 'package:knownledga/data/repositories/explorer/project_element.dart';
import 'package:knownledga/ui/core/widgets/expansion_element.dart';
import 'package:knownledga/ui/dialog/widgets/error_viewer_screen.dart';
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
    return _buildElement(context, elementViewModel);
  }

  Widget _buildElement(BuildContext context, ElementViewModel elt) {
    return ListenableBuilder(listenable: elt, builder: (context, builder) {
      return ExpansionElement(
        leading: _buildElementIcon(elt),
        title: _buildTitleElement(context, elt),
        isExpandable: elt.isExpandable,
        commands: _buildElementCommands(context, elt),
        children: [ _buildChidrenElements(context, elt) ]
      );
    });
  }

  Icon _buildElementIcon(ElementViewModel elt) {
    if (elt.elementType == ProjectElement.typeFolder) {
      return const Icon(Icons.folder, color: Colors.white, size: 15);
    } else {
      return const Icon(Icons.text_snippet_sharp, color: Colors.white, size: 15);
    }
  }

  List<Widget> _buildElementCommands(BuildContext context, ElementViewModel elt) {
    List<Widget> commands = [];
    if (elt.elementType == ProjectElement.typeFile) {
      commands.add(_openElementBtn(context, elt));
    }
    commands.add(_renameElementBtn(elt));
    commands.add(_deleteElementBtn(context, elt));
    return commands;
  }

  Widget _buildTitleElement(BuildContext context, ElementViewModel elementViewModel) {
    if (elementViewModel.isRenaming) {
      return Container(width: 150, padding: const EdgeInsets.all(0), child: TextField(
        cursorHeight: 12,
        cursorColor: Colors.white,
        focusNode: _focusRenameElement,
        canRequestFocus: true,
        style: const TextStyle(fontSize: 12, height: 2, color: Colors.white, decoration: TextDecoration.none),
        textAlignVertical: const TextAlignVertical(y: 0),
        controller: _controllerRenameElement,
        decoration: const InputDecoration(isDense: true),
        onSubmitted: (value) async {
          try {
            await elementViewModel.renameElement(value);
          } on KnowledgaException catch (e) {
            if (context.mounted) {
              DialogErrorViewerScreen().show(context, e);
            } else {
              throw Exception("Impossible to display error, invalid context");
            }
          }
        },
        onTapOutside: (_) {
          elementViewModel.cancelRenaming();
        },
      ));
    } else {
      return Text(elementViewModel.elementName,  textAlign: TextAlign.left,
         style: const TextStyle(fontSize: 12, color: Colors.white, decoration: TextDecoration.none)
      );
    }
  }

  Widget _buildChidrenElements(BuildContext context, ElementViewModel elt) {
    return Padding(padding: const EdgeInsets.only(top: 3, left: 5), child: Column(
      children: elt.subElements.map((se) => _buildChildElement(context, se)).toList()
    ));
  }

  Widget _buildChildElement(BuildContext context, ElementViewModel elementViewModel) {
    return _buildElement(context, elementViewModel);
  }

  Widget _openElementBtn(BuildContext context, ElementViewModel element) {
    return IconButton(
      onPressed: () async {
        try {
          await element.openElement();
        } on KnowledgaException catch (e) {
          if (context.mounted) {
            DialogErrorViewerScreen().show(context, e);
          } else {
            throw Exception("Impossible to display error, invalid context");
          }
        }
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.launch, size: 15, color: Colors.white)
    );
  }

  Widget _renameElementBtn(ElementViewModel element) {
    return IconButton(
      onPressed: () {
        _controllerRenameElement.text = element.elementName;
        element.queryRenaming();
        _focusRenameElement.requestFocus();
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.edit, size: 15, color: Colors.white)
    );
  }

  Widget _deleteElementBtn(BuildContext context, ElementViewModel element) {
    return IconButton(
      onPressed: () async {
        try {
          await element.parentViewModel.deleteElement(element);
        } on KnowledgaException catch (e) {
          if (context.mounted) {
            DialogErrorViewerScreen().show(context, e);
          } else {
            throw Exception("Impossible to display error, invalid context");
          }
        }
      }, 
      padding: const EdgeInsets.all(0), 
      icon: const Icon(Icons.delete, size: 15, color: Colors.white)
    );
  }


  ElementViewModel get elementViewModel {
    return widget._viewModel;
  }
}