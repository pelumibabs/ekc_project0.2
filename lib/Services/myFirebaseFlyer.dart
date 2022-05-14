import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekc_project/Pages/flyerChat.dart';
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

class Task {
  String? name;
  String? content;
  int? orderIndex;

  Map<String, dynamic> toJson() {
    // AKA toMap()
    return {
      'name': name,
      'content': content,
      // 'orderIndex': orderIndex,
    };
  }

  Task fromJson(Map<String, dynamic> json) {
    // AKA fromMap()
    return Task(
      name: json['name'],
      content: json['content'],
      // orderIndex: json['orderIndex'],
    );
  }

  Task({
    this.name,
    this.content,
    /*this.orderIndex*/
  });
}

// Room Project is actually a 1 user Group Room in Flyer
Future addProjectRoom(
    BuildContext context, String name, GoogleSignInAccount currentUser) async {
  final room = await FirebaseChatCore.instance.createGroupRoom(
      name: name, users: [], metadata: {'defaultKey': 'defaultValue'});
  print(room.id);
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => FlyerChatOriginal(
              room: room,
              currentUser: currentUser,
              // user: _user,
            )),
  );
  // Navigate to the Chat screen
}

// User? firebaseUser = FirebaseAuth.instance.currentUser;
// final currentUser = await fetchUser(
//   firebaseUser!.uid,
//   config.usersCollectionName,
// );

Future<void> getFirestoreUser(uid) async {
  var getUser =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
  // List currentUsers = user.get('userIds');
  // print('currentUsersA ${currentUsers.length} $currentUsers');

  var userSearch = FirebaseFirestore.instance
      .collection('users')
      // .where('lastName', isEqualTo: user2search)
      .snapshots();

  var user = userSearch.first;
  print('USERX $user');
  // return user;
}

Future<void> addUsers2Project(roomId, String? user2search) async {
  var thisRoom =
      await FirebaseFirestore.instance.collection('rooms').doc(roomId).get();
  List currentUsers = thisRoom.get('userIds');
  print('currentUsersA ${currentUsers.length} $currentUsers');

  var userSearch = FirebaseFirestore.instance
      .collection('users')
      .where('lastName', isEqualTo: user2search)
      .snapshots();

  print('userSearch Email & ID:');
  String? newUserId; // get newUserId by newUserEmail
  // var newUserId = 'q4iaRKgFydSjpR4OprLn7k1aDuE3'; // get newUserId by newUserEmail
  await userSearch.forEach((element) async {
    if (element.docs.length != 1) {
      return print('Failed to add user: ${element.docs.length} users found!');
    }
    print('currentUsersB ${currentUsers.length} $currentUsers');
    print(element.docs.length);
    print(element.docs[0].id);
    newUserId = element.docs[0].id;
    print('newUserId $newUserId');
    currentUsers.add(newUserId);

    print('currentUsersC ${currentUsers.length} $currentUsers');

    // currentUsers.add(newUserId);
    // currentUsers.add('q4iaRKgFydSjpR4OprLn7k1aDuE3');

    return await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .update({
      'userIds': currentUsers
    })
        .then((value) => print("User Added."))
        .catchError((error) => print("Failed to add user: $error"));

  });
}

Future<void> addTask(
  roomId,
  name,
  content,
  /*int? orderIndex*/
) {
  return FirebaseFirestore.instance
      .collection('rooms/$roomId/tasks')
      .add(Task(
        name: name,
        content: content, /*orderIndex: orderIndex*/
      ).toJson())
      .then((value) => print("Task Added."))
      .catchError((error) => print("Failed to add user: $error"));
}

/// Returns a stream of messages from Firebase for a given room
Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks({String? roomId}) {
  return FirebaseFirestore.instance
      .collection('rooms/$roomId/tasks')
      .get()
      .asStream();
}
