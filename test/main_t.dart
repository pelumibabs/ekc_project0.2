// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AddUser(age: 8, company: 'A', fullName: 'B'),
    // home: MainPage(),
  ));
}

class AddUser extends StatelessWidget {
  String? fullName;
  String? company;
  int? age;

  Map<String, dynamic> toJson() {
    // AKA toMap()
    return {
      'fullName': fullName,
      'company': company,
      'age': age,
    };
  }

  AddUser fromJson(Map<String, dynamic> json) {
    // AKA fromMap()
    return AddUser(
      fullName: json['fullName'],
      company: json['company'],
      age: json['age'],
    );
  }

  AddUser({this.fullName, this.company, this.age});

  @override
  Widget build(BuildContext context) {
    Future<void> _addUser() {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> _addTask(roomId) {
      return FirebaseFirestore.instance
          .collection('rooms/$roomId/tasks')
          .add(AddUser(company: 'spit', age: 69, fullName: 'idan').toJson())
          .then((value) => print("Task Added."))
          .catchError((error) => print("Failed to add user: $error"));
    }

    /// Returns a stream of messages from Firebase for a given room
    Future<QuerySnapshot<Map<String, dynamic>>> futureTasks({String? roomId}) {
      return FirebaseFirestore.instance.collection('rooms/$roomId/tasks').get();
    }

    /// Returns a stream of messages from Firebase for a given room
    Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks({String? roomId}) {
      return FirebaseFirestore.instance
          .collection('rooms/$roomId/tasks')
          // .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
        (snapshot) {
          // print('streamTasks:');
          // // print(snapshot.data?.docs.first.data());
          // snapshot.docs.forEach((element) {
          //   print(element.data());
          // });
          // print('---------------');
          return snapshot;
        },
      );
    }

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _addUser,
          child: const Text(
            "Add User",
          ),
        ),
        TextButton(
          onPressed: () => _addTask('Nl9iHDaJsd1rXTsOxQuA'),
          child: const Text(
            "Add Task",
          ),
        ),
        FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: futureTasks(roomId: 'Nl9iHDaJsd1rXTsOxQuA'),
          builder: (context, snapshot) {
            print(snapshot);
            print('future snapshot.data:');
            // print(snapshot.data?.docs.first.data());
            snapshot.data?.docs.forEach((element) {
              print(element.data());
            });
            print('-----------------');
            return Text('Future: ${snapshot.data?.docs.length}');
          },
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // initialData: const {},
          stream: streamTasks(roomId: 'Nl9iHDaJsd1rXTsOxQuA'),
          builder: (context, snapshot) {
            print('stream snapshot.data:');
            // print(snapshot.data?.docs.first.data());
            snapshot.data?.docs.forEach((element) {
              print(element.data());
            });
            print('-----------------');
            return Text('Stream: ${snapshot.data?.docs.length}');
          },
        ),
      ],
    )));
  }
}
