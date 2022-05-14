import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

String timeAgo(intDate, {bool numericDates = true}) {
  // print('intDate: $intDate');
  var date = DateTime.fromMicrosecondsSinceEpoch(intDate * 1000);
  // print('date: $date');

  final date2 = DateTime.now();
  final difference = date2.difference(date);

  if ((difference.inDays / 7).floor() >= 1) {
    // return (numericDates) ? '1 week ago' : 'Last week';
    return (numericDates) ? ' שבוע' : 'שבוע שעבר';
  } else if (difference.inDays >= 2) {
    // return '${difference.inDays} days ago';
    return '${difference.inDays} ימים ';
  } else if (difference.inDays >= 1) {
    // return (numericDates) ? '1 day ago' : 'Yesterday';
    return (numericDates) ? ' יום' : 'אתמול';
  } else if (difference.inHours >= 2) {
    // return '${difference.inHours} hours ago';
    return '${difference.inHours} שעות';
  } else if (difference.inHours >= 1) {
    // return (numericDates) ? '1 hour ago' : 'An hour ago';
    return (numericDates) ? ' שעה' : 'לפני שעה';
  } else if (difference.inMinutes >= 2) {
    // return '${difference.inMinutes} minutes ago';
    return '${difference.inMinutes} דקות ';
  } else if (difference.inMinutes >= 1) {
    // return (numericDates) ? '1 minute ago' : 'A minute ago';
    return (numericDates) ? ' דקה' : 'לפני דקה';
  } else if (difference.inSeconds >= 3) {
    // return '${difference.inSeconds} seconds ago';
    return '${difference.inSeconds} שניות ';
  } else {
    // return 'Just now';
    // return 'בדיוק הרגע';
    return 'רגע';
  }
}

/*

class CardPost extends StatelessWidget {
  final User user;
  final Message msgDetails;
  // final String postContent;
  // final DateTime dateTime;
  final MessageWidget defaultMessage;
  final VoidCallback onTap;

  const CardPost({
    required this.user,
    required this.msgDetails,
    // required this.postContent,
    // required this.dateTime,
    required this.defaultMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool currentUserCard = StreamChat.of(context).currentUser?.id == user.id;
    String channelId = StreamChannel.of(context).channel.id!;
    // print('XX ${StreamChannel.of(context).channel.id}');

    // int numLines = Random().nextInt(5) + 1;
    // String text = // A perfect 51 len sentence X 5 = 255
    // 'זה בסה"כ מדובר משפט זהה שחוזר על עצמו 😁 מס\' פעמים ' * numLines;
    // 'This is the Just a multiple of random sentences 😁 ' * numLines;

    // Icons.arrow_right_rounded,
    // Icons.question_answer,
    // Icons.send_rounded,


// region commented switch
*/
/*    switch (sIndex) {
      case 1:
        sColor = cRilPurple;
        sText = 'Questions';
        sIcon =  Icons.question_answer;
        sButton = 'Answer';
        break;
      case 2:
        sColor = cRilDeepPurple;
        sText = 'Ideas & Stuff';
        sIcon =  Icons.send_rounded;
        // sIcon =  Icons.arrow_right_rounded;
        break;
    }*//*

// endregion commented switch

    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child:
        GestureDetector(
          onTap: !currentUserCard  ? onTap : (){},
          child:
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            shape:
            RoundedRectangleBorder(
              side: BorderSide( color: cGrey100, width: 1.5 ),
              borderRadius: BorderRadius.circular(6.0),),
            elevation: 0,
            shadowColor: Colors.black87,
            // color: kTheme(context).backgroundColor,
            color: cGrey50,
            child: Column(
              children: [
                SizedBox(height: 2,),
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  alignment: Alignment.centerRight,
                  child:
                  InkWell(
                    child:
                    Icon(
                      Icons.more_horiz,
                      color: cGrey150,
                    ),
                    onTap:(){

                      final channel = StreamChannel.of(context).channel;
                      final chatThemeData = StreamChatTheme.of(context);
                      var isSendFailed = false;
                      var isUpdateFailed = false;
                      var isFailedState = false;
                      var isDeleteFailed = false;

                      showDialog(
                        useRootNavigator: false,
                        context: context,
                        barrierColor: chatThemeData.colorTheme.overlay,
                        // barrierColor: Colors.black12,
                        builder: (context) => StreamChannel(
                          channel: channel,
                          child: MessageActionsModal(
                            messageWidget: defaultMessage.copyWith(
                              key: const Key('MessagedefaultMessage'),
                              message: defaultMessage.message.copyWith(
                                text: (defaultMessage.message.text?.length ?? 0) > 200
                                    ? '${defaultMessage.message.text!.substring(0, 200)}...'
                                    : defaultMessage.message.text,
                              ),
                              showReactions: false,
                              showUsername: false,
                              showTimestamp: false,
                              translateUserAvatar: false,
                              showSendingIndicator: false, // blue ticks
                              padding: const EdgeInsets.all(0),
                              showReactionPickerIndicator: defaultMessage.showReactions &&
                                  (defaultMessage.message.status == MessageSendingStatus.sent),
                              showPinHighlight: false,
                              showUserAvatar:
                              defaultMessage.message.user!.id == channel.client.state.currentUser!.id
                                  ? DisplayWidget.gone
                                  : DisplayWidget.show,
                            ),
                            onCopyTap: (message) =>
                                Clipboard.setData(ClipboardData(text: message.text)),
                            messageTheme: defaultMessage.messageTheme,
                            reverse: defaultMessage.reverse,
                            showDeleteMessage: false,
                            message: defaultMessage.message,
                            showResendMessage: false,
                            showCopyMessage: defaultMessage.showCopyMessage &&
                                !isFailedState &&
                                defaultMessage.message.text?.trim().isNotEmpty == true,
                            showEditMessage: false,
                            showReactions: false,
                            showReplyMessage: false,
                            showThreadReplyMessage: false,
                            showFlagButton: !currentUserCard, // flag & Report
                            showPinButton: false,
                          ),
                        ),
                      );

                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  alignment: Alignment.topRight,
                  child: Text(
                    // postContent: '${details.message.text}',
                    // dateTime: details.message.createdAt,
                    kDebugMode && cShowAgeAndPostLen ?
                    '(${msgDetails.text?.length}), ${msgDetails.text}'
                        : '${msgDetails.text}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.only(right: 10),
                  // color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade300,
                  // color: cGrey100,
                  child:
                  Row(
                    children: [
                      Flexible(
                        child:
                        Container(
                          // margin: EdgeInsets.only(right: 8, bottom: 22, left: 8),
                          // color: cGrey100,
                            child:
                            ListTile(
                                dense: true,
                                visualDensity: VisualDensity.standard,
                                title:
                                Text(
                                  kDebugMode && cShowAgeAndPostLen ?
                                  '${user.name} (${user.extraData['birthdayAge']})'
                                      : '${user.name}',
                                  style: TextStyle(
                                    // color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade600,
                                    // color: Colors.black
                                      color: cGrey300,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  // style: bodyText1Format(context)
                                ),
                                subtitle:
                                Text(
                                  */
/*' · '*//*
  'לפני '  '${timeAgo(msgDetails.createdAt)}',
                                  textDirection: ui.TextDirection.rtl,
                                  style: TextStyle(
                                    // color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade600,
                                    // color: Colors.black
                                      color: cGrey300,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                  // style: bodyText1Format(context)
                                ),
                                contentPadding: EdgeInsets.zero,
                                leading:                     // user == null ?
                                // CircleAvatar(
                                //     backgroundColor: Colors.grey[200],
                                //     radius: 25),
                                Builder(
                                  builder: (context) {
                                    // print('UserAvatar() ${user.id}: ${user.image}');
                                    return UserAvatar(
                                      user: user,
                                      borderRadius: BorderRadius.circular(99),
                                      constraints: BoxConstraints.expand(
                                        height: 50,
                                        width: 50,
                                      ),
                                    );
                                  },
                                )
                            )
                          */
/*Column(
                          children: [
                            // user == null ?
                            // CircleAvatar(
                            //     backgroundColor: Colors.grey[200],
                            //     radius: 25),
                            UserAvatar(
                              user: user,
                              borderRadius: BorderRadius.circular(99),
                              constraints: BoxConstraints.expand(
                                height: 60,
                                width: 60,
                              ),
                              // todo: Export user_avatar.dart to enable edit, than change the online dot to circle
                              showOnlineStatus: true,

                            ),
                          ],
                        ),*//*

                        ),
                      ),


                      channelId == 'Home' ?
                      Builder(
                          builder: (context) =>
                          !currentUserCard ? Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child:
                              CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 20,
                                child: IconButton(
                                    onPressed: onTap,
                                    icon: Icon(Icons.send_rounded, color:
                                    Colors.grey[500],
                                      size: 20,)),
                              ),

                            ),
                          )
                              : Offstage()
                      )

                          : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child:
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.grey[200]),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            icon: Icon(Icons.question_answer, color: Colors.grey[500]),
                            label:
                            Builder(
                              builder: (context) {
                                String? labelButton;
                                if(msgDetails.replyCount == 0){
                                  user.id != StreamChat.of(context).currentUser!.id
                                      ? labelButton = 'השב ראשון!' : labelButton = 'אין תשובות';
                                } else if (msgDetails.replyCount == 1){
                                  labelButton = 'תשובה אחת';
                                } else {
                                  labelButton = '${msgDetails.replyCount}' ' תשובות';
                                }

                                return Text('$labelButton',
                                  style: TextStyle(color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),);
                              },
                            ),
                            onPressed: onTap,
                          ),
                        ),
                      )

*/
/*                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          // shape: StadiumBorder(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          side: BorderSide(width: 1.5, color: Colors.grey[400]!),
                        ),
                        child: Text('תשובות',
                          style: StreamChatTheme.of(context).textTheme.bodyBold.copyWith(
                              color:
                              // StreamChatTheme.of(context).colorTheme.accentPrimary
                              Colors.grey[600]),
                        ),

                        onPressed: () {},
                      ),*//*


                      // const SizedBox(width: 10),
                      // const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
*/
