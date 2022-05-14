import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 1. Set Class
// 2. Insert details to class
// 3. Get Details any time!
class UserDetails extends ChangeNotifier {
// Set Up Values
  String? email;
  String? name;
  String? id;
  String? photoUrl;

  bool? isGoogleSign_user;
  GoogleSignInAccount? googleSign_user;
  UserCredential? classic_currentUser;

// To Get Provider Values any time
  String? get getEmail {
    return email;
  }

  String? get getName {
    return name;
  }

  String? get getId {
    return id;
  }

  String? get getPhotoUrl {
    return photoUrl;
  }

  bool? get getIsGoogleSign_user {
    return isGoogleSign_user;
  }

  GoogleSignInAccount? get getGoogleSign_user {
    return googleSign_user;
  }

  UserCredential? get getClassic_currentUser {
    return classic_currentUser;
  }

  // USAGE 1 (Source: https://www.freecodecamp.org/news/provider-pattern-in-flutter/)
  // Use the normal void as you wish for
  // But with notifyListeners()
  // So Provider.of<Counter>(context, listen: false).incrementName();
  // Will update
  void incrementName() {
    name = 'incrementName';
    notifyListeners();
  }

// USAGE 2 (Source: https://flutterbyexample.com/lesson/the-most-basic-example-using-provider)
// Just like regular Stateful attributes
// But create save it to use the values any time.
// instaed MyApp(name: "Yohan", age: 25)
// create a Person class and update it there
/*  Provider(
  create: (_) => Person(name: "Yohan", age: 25),
  child: MyApp(),
  ),*/
}
