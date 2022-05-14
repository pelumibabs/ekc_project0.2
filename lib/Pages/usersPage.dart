import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekc_project/Widgets/addPtDialog.dart';
import 'package:ekc_project/Widgets/myAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'dart:convert';
import 'package:ekc_project/Widgets/myDrawers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';

import 'flyerChat.dart';

class UsersPage extends StatefulWidget {
  // bool isGoogleSign_user;
  GoogleSignInAccount? googleSign_user;

  // UserCredential? classic_currentUser;
  // final currentUser;
  //
  // AllUsersPage({this.currentUser, required this.isGoogleSign_user});
  UsersPage({this.googleSign_user});

  // const AllUsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Create a user with an ID of UID if you don't use
// `FirebaseChatCore.instance.users()` stream
  void _createRoom(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FlyerChatOriginal(
                room: room,
                currentUser: widget.googleSign_user,         )),
    );

    // Navigate to the Chat screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: projectDrawer(context, widget.googleSign_user, true, null),

      appBar: myAppBar('Find someone to chat'),
      // appBar: myAppBar(''),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          initialData: const [],
          builder: (context, snapshot) {
            var users = snapshot.data!;
            // print('AllUsers StreamBuilder: $users');
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) {
                final user = snapshot.data![i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    onTap: () {
                      // print(user);
                      _createRoom(user, context);
                    },
                    title: Text('${users[i].firstName}'),
                    trailing: IconButton(
                      onPressed: () {
                        print(user);
                        setState(() {
                          var _user = user;
                          _createRoom(_user, context);
                        });
                      },
                      icon: const Icon(
                        Icons.send,
                        color: dark,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: '${users[i].imageUrl}',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          // print(error);
                          return Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
