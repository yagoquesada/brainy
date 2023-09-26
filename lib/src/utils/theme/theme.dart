import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tfg_v3/src/constants/colors.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/app_bar_theme.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/text_field_theme.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/text_theme.dart';

class SharedPreference {
  final _controller = StreamController<bool>();

  Stream<bool> get darkMode async* {
    yield* _controller.stream;
  }

  void setTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isdark', value);
    _controller.add(value); // update value here.
  }

  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isdark') ?? false;
  }

  // call when user closes the app or something.
  void dispose() => _controller.close();
}

/* -- Change from DarkMode to LightMode -- */
StreamController<bool> isLightTheme = StreamController();

/* -- Bool to change Icon -- */
bool iconBool = false;

/* -- Icons DarkMode LightMode -- */
IconData iconLight = Icons.wb_sunny;
IconData iconDark = Icons.nights_stay;

/* -- Theme LightMode -- */
ThemeData lightTheme = ThemeData(
  appBarTheme: appBarLightTheme,
  cardColor: tCardColorLight,
  scaffoldBackgroundColor: tScaffoldBackgroundColorLight,
  colorSchemeSeed: tBackgroundColorLight,
  dialogBackgroundColor: tScaffoldBackgroundColorLightSettings,
  unselectedWidgetColor: Colors.black,
  shadowColor: tShadowColorLight,
  hoverColor: tMenuBackgroundColorLight,
  canvasColor: tMessageColorLight,
  textTheme: lightTextTheme,
  elevatedButtonTheme: lightElevatedButtonTheme,
  inputDecorationTheme: lightInputDecorationTheme,
  brightness: Brightness.light,
);

/* -- Theme DarkMode -- */
ThemeData darkTheme = ThemeData(
  appBarTheme: appBarDarkTheme,
  cardColor: tCardColorDark,
  scaffoldBackgroundColor: tScaffoldBackgroundColorDark,
  colorSchemeSeed: tBackgroundColorDark,
  dialogBackgroundColor: tScaffoldBackgroundColorDarkSettings,
  unselectedWidgetColor: Colors.white,
  shadowColor: tShadowColorDark,
  hoverColor: tMenuBackgroundColorDark,
  canvasColor: tMessageColorDark,
  textTheme: darkTextTheme,
  elevatedButtonTheme: darkElevatedButtonTheme,
  inputDecorationTheme: darkInputDecorationTheme,
  brightness: Brightness.dark,
);


/* 
colorScheme: ThemeData()
      .colorScheme
      .copyWith(
        primary: tVividSkyBlue,
        brightness: Brightness.dark,
      )
      .copyWith(background: tBackgroundColorDark), 
*/