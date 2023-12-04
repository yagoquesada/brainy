import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class YAppBarTheme {
  YAppBarTheme._();

  /* -- AppBar LightMode --*/
  static const AppBarTheme appBarLightTheme = AppBarTheme(
    toolbarHeight: 70,
    elevation: 2,
    centerTitle: true,
    color: YColors.cardColorLight,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
  );

  /* -- AppBar DarkMode --*/
  static const AppBarTheme appBarDarkTheme = AppBarTheme(
    toolbarHeight: 70,
    elevation: 2,
    centerTitle: true,
    color: YColors.cardColorDark,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
  );
}
