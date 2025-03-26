import 'package:flutter/material.dart';
import 'package:trackit/src/constants/color.dart';

class DfloatingActionButtonTheme {
  DfloatingActionButtonTheme._();
  static final FloatingActionButtonThemeData lightfloatingActionButtonTheme =
      FloatingActionButtonThemeData(
    backgroundColor: dSecondaryColor,
    foregroundColor: dPrimaryColor,
    elevation: 0,
  );
  static final FloatingActionButtonThemeData darkfloatingActionButtonTheme =
      FloatingActionButtonThemeData(
    backgroundColor: dPrimaryColor,
    foregroundColor: dSecondaryColor,
    elevation: 0,
  );
}
