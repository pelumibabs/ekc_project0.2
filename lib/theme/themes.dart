import 'package:flutter/material.dart';

import 'colors.dart';

ColorScheme kColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primaryVariant: cGrey500,     // 500
  primary: cRilPurple,          // 450 --
  onPrimary: cRilPurple,        // 400 --
  secondaryVariant: cRilPurple, // 350 --
  secondary: cGrey300,          // 300
  onSecondary: cRilPurple,      // 250 --
  surface: cRilPurple,          // 200 --
  onSurface: cGrey150,          // 150
  background: cGrey100,         // 100
  onBackground: cGrey50,        // 50
  error: kErrorRed,
  onError: kColorSpiderRed,
);

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    splashColor: Colors.grey.withOpacity(0.15),
    hintColor: cRilSecondaryPurple,
    highlightColor: cRilDeepPurple,
    canvasColor: cRilSurfacePurple,
    primaryColorDark: cLightPurple,
    primaryColorLight: cLightPurple,
    colorScheme: kColorScheme,
    primaryColor: primaryColor, // Colors.black,
    backgroundColor: backgroundColor, // Colors.white,
    scaffoldBackgroundColor: scaffoldBackground,
    iconTheme: IconThemeData(color: cGrey300),
  );
}

 // A perfect opposite of  kColorScheme
ColorScheme kColorSchemeDark = const ColorScheme(
  brightness: Brightness.light,
  primaryVariant: cGreyDark500,     // 500
  primary: cRilPurple,              // 450 --
  onPrimary: cRilPurple,            // 400 --
  secondaryVariant: cRilPurple,     // 350 --
  secondary: cGreyDark300,          // 300
  onSecondary: cRilPurple,          // 250 --
  surface: cRilPurple,              // 200 --
  onSurface: cGreyDark150,          // 150
  background: cGreyDark100,         // 100
  onBackground: cGreyDark50,        // 50
  error: kErrorRed,
  onError: kColorSpiderRed,
);

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    splashColor: Colors.grey.withOpacity(0.15),
    hintColor: cRilSecondaryPurple,
    highlightColor: cRilDeepPurple,
    canvasColor: cRilSurfacePurple,
    primaryColorDark: cLightPurple,
    primaryColorLight: cLightPurple,
    colorScheme: kColorScheme,  // Todo
    primaryColor: backgroundColor, // Colors.white,
    backgroundColor: primaryColor, // Colors.black,
    scaffoldBackgroundColor: scaffoldDarkBackground,
  );
}