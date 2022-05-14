

import 'package:flutter/material.dart';

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