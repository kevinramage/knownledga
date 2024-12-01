import 'package:knownledga/modules/explorer/models/projectelement.dart';

class Project extends ParentElement {
  String name = "";
  String path = "";
  List<ProjectElement> elements = [];

  Project({required this.name});
}