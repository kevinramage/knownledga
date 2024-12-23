import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/explorer/project.dart';
import 'package:knownledga/ui/application/view_models/application_viewmodel.dart';
import 'package:knownledga/ui/dialog/view_models/create_project_viewmodel.dart';
import 'package:knownledga/ui/explorer/view_models/project_viewmodel.dart';

class DialogCreateProjectScreen {
  
  Future<ProjectViewModel> show(BuildContext context, ApplicationViewModel applicationModel) async {
    final CreateProjectViewModel model = CreateProjectViewModel(application: applicationModel);
    await showDialog(context: context, builder: (_) {
      return CreateProjectScreen(model: model);
    });
    return model.toProjectViewModel(applicationModel);
  }
}

class CreateProjectScreen extends StatefulWidget {

  final CreateProjectViewModel _model;

  const CreateProjectScreen({super.key, required model }) : _model = model;

  @override
  State<StatefulWidget> createState() {
    return _CreateProjectScreen();
  }
}

class _CreateProjectScreen extends State<CreateProjectScreen> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _gitUrlController = TextEditingController();
  //final TextEditingController _gitUsernameController = TextEditingController();
  //final TextEditingController _gitPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget._model.initHomeDirectory();
    _projectNameController.text = widget._model.projectName;
    _gitUrlController.text = widget._model.gitUrl;
    //_gitUsernameController.text = widget._model.gitUsername;
    //_gitPasswordController.text = widget._model.gitPassword;
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _gitUrlController.dispose();
    //_gitUsernameController.dispose();
    //_gitPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [ _buildProjectName() ];
    widgetList.add(_buildProjectLocation());
    //widgetList.add(_buildProjectType());
    //widgetList.addAll(_buildGitWidgets());

    return ListenableBuilder(
      listenable: widget._model, builder: (context, child) {
        return  AlertDialog(
          title: const Text("Create a new project"),
          content: Center(child: SizedBox(width: 400, height: 600, child: Column(children: [
            _buildProjectName(),
            _buildProjectLocation(),
            _buildProjectType(),
            if (widget._model.projectType == ProjectType.gitProject)
              const Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: Divider()),
            if (widget._model.projectType == ProjectType.gitProject)
              _buildProjectGitUrl(),
            /*
            if (widget._model.projectType == ProjectType.gitProject)
              _buildProjectGitUsername(),
            */
            /*
            if (widget._model.projectType == ProjectType.gitProject)
              _buildProjectGitPassword()
            */
        
          ]))),
          actions: [
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel"), onPressed: () { 
              widget._model.projectName = "";
              Navigator.pop(context, "Cancel");  
            }),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.green),
              onPressed: widget._model.isValidProperties ? () { Navigator.pop(context, "OK");  } : null,
              child: const Text("Create"),
            )
          ]
        );
      }
    );
  }

  Widget _buildProjectName() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Project Name",
        suffixIcon: _buildValidationIcon(widget._model.isValidProjectName)
      ),
      controller: _projectNameController,
      autofocus: true,
      onChanged: (value) {  widget._model.projectName = value; },
    );
  }

  Icon _buildValidationIcon(bool validation) {
    if (validation) {
      return const Icon(Icons.done, color: Colors.green);
    } else {
      return const Icon(Icons.close, color: Colors.red);
    }
  }

  Widget _buildProjectLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Project Location",
          suffixIcon: _buildValidationIcon(widget._model.isValidProjectLocation)
        ),
        enabled: false,
        controller: TextEditingController(text: widget._model.projectLocation)
      )
    );
  }

  Widget _buildProjectType() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          const SizedBox(width: 150, child: Text("Project type: ")),
          DropdownButton<ProjectType>(
            value: widget._model.projectType,
            items: [
              DropdownMenuItem(value: ProjectType.localProject, child: Text(ProjectTypeUtils.toText(ProjectType.localProject))),
              DropdownMenuItem(value: ProjectType.gitProject, child: Text(ProjectTypeUtils.toText(ProjectType.gitProject))),
            ], onChanged: (ProjectType? value) => {
              if (value != null) {
                widget._model.projectType = value
              }
            }
          )
        ],
      ),
    );
  }

  Widget _buildProjectGitUrl() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Repository Url",
        prefixIcon: const Icon(Icons.http),
        suffixIcon: _buildValidationIcon(widget._model.isValidGitURL)
      ),
      controller: _gitUrlController,
      autofocus: true,
      onChanged: (value) {  widget._model.gitUrl = value; },
    );
  }

  /*
  Widget _buildProjectGitUsername() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Username",
        prefixIcon: const Icon(Icons.people),
        suffixIcon: _buildValidationIcon(widget._model.isValidGitUserName)
      ),
      controller: _gitUsernameController,
      autofocus: true,
      onChanged: (value) {  widget._model.gitUsername = value; },
    );
  }
  */

  /*
  Widget _buildProjectGitPassword() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.password),
        suffixIcon: _buildValidationIcon(widget._model.isValidGitPassword)
      ),
      controller: _gitPasswordController,
      obscureText: true,
      autofocus: true,
      onChanged: (value) {  widget._model.gitPassword = value; },
    );
  }
  */
}

