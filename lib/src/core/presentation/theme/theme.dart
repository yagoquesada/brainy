import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tfg_v3/src/core/presentation/theme/widget_theme/app_bar_theme.dart';
import 'package:tfg_v3/src/core/presentation/theme/widget_theme/elevated_button_theme.dart';
import 'package:tfg_v3/src/core/presentation/theme/widget_theme/text_field_theme.dart';
import 'package:tfg_v3/src/core/presentation/theme/widget_theme/text_theme.dart';

import '../utils/constants/colors.dart';

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
  cardColor: YColors.cardColorLight,
  scaffoldBackgroundColor: YColors.scaffoldBackgroundColorLight,
  colorSchemeSeed: YColors.backgroundColorLight,
  dialogBackgroundColor: YColors.scaffoldBackgroundColorLightSettings,
  unselectedWidgetColor: Colors.black,
  shadowColor: YColors.shadowColorLight,
  hoverColor: YColors.menuBackgroundColorLight,
  canvasColor: YColors.messageColorLight,
  textTheme: lightTextTheme,
  elevatedButtonTheme: YElevatedButtonTheme.lightElevatedButtonTheme,
  inputDecorationTheme: lightInputDecorationTheme,
  brightness: Brightness.light,
);

/* -- Theme DarkMode -- */
ThemeData darkTheme = ThemeData(
  appBarTheme: YAppBarTheme.appBarDarkTheme,
  cardColor: YColors.cardColorDark,
  scaffoldBackgroundColor: YColors.scaffoldBackgroundColorDark,
  colorSchemeSeed: YColors.backgroundColorDark,
  dialogBackgroundColor: YColors.scaffoldBackgroundColorDarkSettings,
  unselectedWidgetColor: Colors.white,
  shadowColor: YColors.shadowColorDark,
  hoverColor: YColors.menuBackgroundColorDark,
  canvasColor: YColors.messageColorDark,
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