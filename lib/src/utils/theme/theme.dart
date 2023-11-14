import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tfg_v3/src/utils/constants/colors.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/app_bar_theme.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/text_field_theme.dart';
import 'package:tfg_v3/src/utils/theme/widget_theme/text_theme.dart';

class YSharedPreference {
  final _controller = StreamController<bool>();

  Stream<bool> get darkMode async* {
    yield* _controller.stream;
  }

  void setTheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isdark', value);
    _controller.add(value);
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
  appBarTheme: YAppBarTheme.appBarLightTheme,
  cardColor: YColors.tCardColorLight,
  scaffoldBackgroundColor: YColors.tScaffoldBackgroundColorLight,
  colorSchemeSeed: YColors.tBackgroundColorLight,
  dialogBackgroundColor: YColors.tScaffoldBackgroundColorLightSettings,
  unselectedWidgetColor: Colors.black,
  shadowColor: YColors.tShadowColorLight,
  hoverColor: YColors.tMenuBackgroundColorLight,
  canvasColor: YColors.tMessageColorLight,
  textTheme: lightTextTheme,
  elevatedButtonTheme: YElevatedButtonTheme.lightElevatedButtonTheme,
  inputDecorationTheme: lightInputDecorationTheme,
  brightness: Brightness.light,
);

/* -- Theme DarkMode -- */
ThemeData darkTheme = ThemeData(
  appBarTheme: YAppBarTheme.appBarDarkTheme,
  cardColor: YColors.tCardColorDark,
  scaffoldBackgroundColor: YColors.tScaffoldBackgroundColorDark,
  colorSchemeSeed: YColors.tBackgroundColorDark,
  dialogBackgroundColor: YColors.tScaffoldBackgroundColorDarkSettings,
  unselectedWidgetColor: Colors.white,
  shadowColor: YColors.tShadowColorDark,
  hoverColor: YColors.tMenuBackgroundColorDark,
  canvasColor: YColors.tMessageColorDark,
  textTheme: darkTextTheme,
  elevatedButtonTheme: YElevatedButtonTheme.darkElevatedButtonTheme,
  inputDecorationTheme: darkInputDecorationTheme,
  brightness: Brightness.dark,
);



/* 
colorScheme: ThemeData()
      .colorScheme
      .copyWith(
        primary: TColors.primary,
        brightness: Brightness.dark,
      )
      .copyWith(background: tBackgroundColorDark), 
*/