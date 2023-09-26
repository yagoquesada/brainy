import 'package:flutter/material.dart';

import 'package:tfg_v3/src/constants/colors.dart';

/* -- AppBar LightMode --*/
AppBarTheme appBarLightTheme = const AppBarTheme(
  toolbarHeight: 70,
  elevation: 2,
  centerTitle: true,
  color: tCardColorLight,
  titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
);

/* -- AppBar DarkMode --*/
AppBarTheme appBarDarkTheme = const AppBarTheme(
  toolbarHeight: 70,
  elevation: 2,
  centerTitle: true,
  color: tCardColorDark,
  titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
);
