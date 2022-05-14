
import 'package:flutter/material.dart';


// Contexts shortcuts
MediaQueryData kMediaQuery(context) => MediaQuery.of(context);
ThemeData kTheme(context) => Theme.of(context);
NavigatorState kNavigator(context) => Navigator.of(context);

// Provider models shortcuts
// UniModel kUniModel(context, {bool listen = false})
//             => Provider.of<UniModel>(context, listen: listen);


// Smart navigation shortcuts
Future<dynamic> kPushNavigator(context, screen,{bool replace = false}) {
    // Fixing push replacement
    if (replace) Navigator.of(context).popUntil((route) => route.isFirst);
    return
        replace ?  Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => screen))
            :  Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen));
}

/*Future<dynamic> kPushProvider(context, {
  required ChangeNotifier? Function(BuildContext) model,
  required Widget Function(BuildContext context, Widget? child)? screen
}) =>
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider(
                create: model,
                builder: screen)
        ));*/

