import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekc_project/Pages/usersPage.dart';
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

class MainPage extends StatefulWidget {
  // bool isGoogleSign_user;
  GoogleSignInAccount? googleSign_user;

  // UserCredential? classic_currentUser;
  // final currentUser;
  //
  // AllUsersPage({this.currentUser, required this.isGoogleSign_user});
  MainPage({this.googleSign_user});

  // const AllUsersPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Create a user with an ID of UID if you don't use
// `FirebaseChatCore.instance.users()` stream
  void _createRoom(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FlyerChatOriginal(
            room: room,
            currentUser: widget.googleSign_user,
            // user: _user,
          )),
    );

    // Navigate to the Chat screen
  }


  @override
  Widget build(BuildContext context) {
    var fUSer = FirebaseAuth.instance.currentUser;

    return Scaffold(
        drawer: projectDrawer(context, widget.googleSign_user, true, null),

        // appBar: myAppBar('Find someone to chat'),
        appBar: myAppBar('Home Page',
            actions: <Widget>[
              Builder(
                // builder needed for Scaffold.of(context).openEndDrawer()
                builder: (context) => IconButton(
                  icon: const Icon(Icons.people
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsersPage(
                            googleSign_user: widget.googleSign_user,
                          )),
                      // MaterialPageRoute(builder: (context) => MainPage(user: _user,)),
                    );
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ]),
        body: Center(
          child: Text('Hello ${widget.googleSign_user?.displayName}\n'
              'Choose a project to start\n'
              'X ${fUSer?.email} X',
            textAlign: TextAlign.center,),
        ));
  }
}
