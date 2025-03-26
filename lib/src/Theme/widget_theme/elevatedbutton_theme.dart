import 'package:flutter/material.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/constants/size.dart';

class DelevatedButtonTheme {
  DelevatedButtonTheme._();
  static final ElevatedButtonThemeData lightelevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: dPrimaryColor,
      backgroundColor: dSecondaryColor,
      side: const BorderSide(
        color: dSecondaryColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: dButtonHeight),
    ),
  );
  static final ElevatedButtonThemeData darkelevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: dSecondaryColor,
      backgroundColor: dPrimaryColor,
      side: const BorderSide(
        color: dPrimaryColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: dButtonHeight),
    ),
  );
}
