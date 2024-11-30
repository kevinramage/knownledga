import 'package:knownledga/modules/explorer/models/projectelement.dart';

class ContentApi {
  Function? _getActiveEltFunc;
  Function? _setActiveEltFunc;

  registerGetActiveElt(Function getActiveElt) {
    _getActiveEltFunc = getActiveElt;
  }
  registerSetActiveElt(Function setActiveElt) {
    _setActiveEltFunc = setActiveElt;
  }

  ProjectElement? getActiveElt() {
    final func = _getActiveEltFunc;
    if (func != null) {
      return func();
    } else {
      return null;
    }
  }
  void setActiveElt(ProjectElement? activeElt) {
    final func = _setActiveEltFunc;
    if (func != null) {
      func(activeElt);
    }
  }

  void openFile(ProjectElement elt) {
    setActiveElt(elt);
  }

}