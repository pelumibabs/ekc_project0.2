import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../theme/colors.dart';

PreferredSizeWidget? myAppBar(String? title, {bool stf = false, actions = const <Widget> []}) {
  return AppBar(
    // backgroundColor: neutral0,
    backgroundColor: cGrey100,
    elevation: 2,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
    title: Text(title ?? '', style: const TextStyle(color: Colors.black),),
    actions: actions,
  );}
