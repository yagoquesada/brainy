import 'package:flutter/material.dart';

import 'package:tfg_v3/src/constants/colors.dart';

/* -- Light Theme -- */
final lightElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(tVividSkyBlue),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.transparent;
        }
        return null; // Defer to the widget's default.
      },
    ),
  ),
);

/* -- Dark Theme -- */
final darkElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(tVividSkyBlue),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.transparent;
        }
        return null; // Defer to the widget's default.
      },
    ),
  ),
);
