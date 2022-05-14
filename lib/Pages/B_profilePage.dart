import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekc_project/Pages/ril_gDashboard.dart';
import 'package:ekc_project/Pages/usersPage.dart';
import 'package:ekc_project/Widgets/addPtDialog.dart';
import 'package:ekc_project/Widgets/myAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:convert';
import 'package:ekc_project/Widgets/myDrawers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';

import '../theme/constants.dart';
import 'dummyPage.dart';
import 'flyerChat.dart';
import 'flyerChatV2.dart';

class ProfilePage extends StatefulWidget {
  // bool isGoogleSign_user;
  final types.User? userData;

  // UserCredential? classic_currentUser;
  // final currentUser;
  //
  // AllUsersPage({this.currentUser, required this.isGoogleSign_user});
  const ProfilePage({Key? key, this.userData}) : super(key: key);

  // const AllUsersPage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Create a user with an ID of UID if you don't use
// `FirebaseChatCore.instance.users()` stream

  @override
  Widget build(BuildContext context) {
    var selectedTime = DateTime.now();
    var fUSer = FirebaseAuth.instance.currentUser;

    return Scaffold(

      // appBar: myAppBar('Find someone to chat'),
        appBar: myAppBar('${widget.userData?.firstName}'),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('${widget.userData?.imageUrl}'),
                )),
            const SizedBox(height: 20),
            const Text(
              'מה תאריך הלידה שלך?',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 125,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime dTime)
                  {
                    selectedTime = dTime;
                  },
                ),
              ),
            ),

            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                child:
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    var user = widget.userData;

                    //the birthday's date
                    var difference = DateTime.now().difference(selectedTime).inDays;
                    var age = difference/365;
                    print('Age is $age');

                    var userData = widget.userData?.copyWith(
                        firstName: '${user?.firstName}',
                        imageUrl: '${user?.imageUrl}',
                        // lastName: '${fireStoreUser?.email}'.toLowerCase(),
                        metadata: {
                          'id' : '${user?.id ?? UniqueKey()}',
                          'email' : user?.metadata?.values.first,
                          'birthDay' : '$selectedTime',
                          'age' : age,
                          'lastHomeMessage': '${DateTime(01, 01, 2000)}',
                        }
                    );

                    if(age < 12){
                      print('True - AGE: $age');
                      cleanSnack(context, text: 'אתה חייב להיות מעל גיל 12.');
                    } else {
                      print('False - AGE: $age');
                      setState(() async {
                        // create or update
                        FirebaseChatCore.instance.createUserInFirestore(userData!)
                            .whenComplete(() =>
                            print(
                                'firebaseDatabase_basedFlyer Completed \n(FirebaseChatCore.instance.createUserInFirestore)'
                                    '\n userData: $userData'))
                            .onError((error, stackTrace) =>
                            print(
                                'firebaseDatabase_basedFlyer FAILED: $error \n-|- $stackTrace \n(FirebaseChatCore.instance.createUserInFirestore)'));


                        // final room = await FirebaseChatCore.instance
                        //     .room('1OepWQhysrUuqzU6eYOR');

                        // Fixing push replacement
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        kPushNavigator(context,
                            GDashboard(homePage:
                              FlyerChatV2(
                                room: types.Room(
                                    users: [widget.userData!], // Adds the user to group
                                    type: types.RoomType.group,
                                    id: '1OepWQhysrUuqzU6eYOR'),
                                // currentUser: widget.userData,),
                                currentUser: userData,),),
                          replace: true);

                      });
                    }
                  },
                  child:
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      // color: StreamChatTheme.of(context).colorTheme.barsBg,
                      border: Border.all(
                        // color: StreamChatTheme.of(context).colorTheme.borders,
                          color: Colors.deepPurple,
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      visualDensity: VisualDensity.compact,
                      title: const Text(
                        'סיום',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),

                      ),

/*                subtitle: Text(
                        AppLocalizations.of(context).streamTestAccount,
                        style: StreamChatTheme.of(context)
                            .textTheme
                            .footnote
                            .copyWith(
                          color: StreamChatTheme.of(context)
                              .colorTheme
                              .textLowEmphasis,
                        ),
                      ),*/
                      trailing: Transform.scale(
                          scale: -1,
                          child: const Icon(Icons.add)
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}


cleanSnack(BuildContext context,{
  required String text,
  Color? color,
  Color? textColor,
  int sec = 3,
  SnackBarAction? action,
}){
  return
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          behavior: SnackBarBehavior.floating,
          // padding: const EdgeInsets.only(bottom: 15),
          // backgroundColor: kColorSpiderRed.withOpacity(0.80),
          // backgroundColor: Colors.grey[100]?.withOpacity(0.85),
          backgroundColor: color == null ?
          Colors.grey[100]?.withOpacity(0.85) : color,
          padding: const EdgeInsets.all(10),
          // content: Text(S.of(context).warning(message)),
          content: Text(
            '$text',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor == null ? Colors.black : textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: sec),
          action: action,
          // action: SnackBarAction(
          //   label: 'סגור',
          //   onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),),
        )
    );
}