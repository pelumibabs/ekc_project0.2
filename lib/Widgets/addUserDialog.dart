import 'package:ekc_project/Pages/flyerChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:ekc_project/Services/myFirebaseFlyer.dart';
import 'package:ekc_project/Widgets/addUserDialog.dart';
import 'package:ekc_project/Widgets/myAppBar.dart';
import 'package:ekc_project/Widgets/myDrawers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../myUtil.dart';

class AddUserDialog extends StatelessWidget {
  final List<String>? currentUsers;
  final TextEditingController? contentFieldController;
  // final Future<VoidCallback>? onPressed;
  final List<Widget> actions;
  final types.Room room;
  final GoogleSignInAccount? currentUser;

  AddUserDialog({
    this.currentUsers,
    this.contentFieldController,
    this.actions = const [],
    required this.room,
    this.currentUser
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
              controller: contentFieldController, name: 'Insert user email'),
        ],
      ),
      actions: actions,
      content: Container(
        height: 110,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // popPress;
                  // getFirestoreUser(room.id, projectAddUserController.text);

/*                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FireBaseChatPage(
                      room: room,
                          currentUser: currentUser,
                          // user: _user,
                        )),
                  );*/
                },
                child: const Text('Add user',
                    style: TextStyle(color: Colors.white)),
              ),
              Text(
                '(${currentUsers?.length})\n${currentUsers.toString().replaceAll('[', '').replaceAll(']', '')}',
                style: const TextStyle(color: eckLightBlue),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
