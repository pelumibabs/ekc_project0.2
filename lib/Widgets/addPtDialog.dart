import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../myUtil.dart';

// Pt = Project or Task
class AddPtDialog extends StatelessWidget {
  final bool isProject;
  final String? title;
  final VoidCallback? onPressed;
  final TextEditingController? nameFieldController;
  final TextEditingController? contentFieldController;
  final List<Widget> actions;

  AddPtDialog({
    required this.isProject,
    this.title,
    this.onPressed,
    this.nameFieldController,
    this.contentFieldController,
    this.actions = const [],
  });

  //  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget _myTextField({controller, name}) {
      return TextField(
        controller: controller,
        style: const TextStyle(color: eckLightBlue),
        decoration: InputDecoration(
            hintText: name,
            hintStyle: const TextStyle(color: eckLightBlue),
            fillColor: eckBlue,
            filled: true,
            border: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide.none,
            )),
      );
    }

    return AlertDialog(
      backgroundColor: eckDarkBlue,
      // backgroundColor: Colors.blueGrey[700],
      title: Column(
        children: [
          _myTextField(
              controller: nameFieldController,
              name: isProject ? 'New project name' : 'New task name'),
          isProject ? Container() : const SizedBox(height: 20),
          isProject
              ? Container()
              : _myTextField(
                  controller: contentFieldController, name: 'add some details..')
        ],
      ),
      actions: actions,
      content: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Add image', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
