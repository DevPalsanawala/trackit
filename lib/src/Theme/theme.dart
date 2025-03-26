import 'package:flutter/material.dart';
import 'package:trackit/src/Theme/widget_theme/appbar_theme.dart';
import 'package:trackit/src/Theme/widget_theme/elevatedbutton_theme.dart';
import 'package:trackit/src/Theme/widget_theme/floatbutton_theme.dart';
import 'package:trackit/src/Theme/widget_theme/outlinebutton_theme.dart';
import 'package:trackit/src/Theme/widget_theme/textfromfield_theme.dart';

class DAppTheme {
  DAppTheme._();
  static ThemeData lighttheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF0F0F0),
    // textTheme: DtextTheme.lightTextTheme,
    outlinedButtonTheme: DOutlineButtonTheme.lightOutlineButtonTheme,
    elevatedButtonTheme: DelevatedButtonTheme.lightelevatedButtonTheme,
    inputDecorationTheme: Dtextformfield.lightInputdecoration,
    appBarTheme: DAppbarTheme.lightAppbarTheme,
    floatingActionButtonTheme:
        DfloatingActionButtonTheme.lightfloatingActionButtonTheme,
    // iconTheme: IconThemeData(color: dSecondaryColor),
  );
  static ThemeData darktheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0XFF101010),
    // textTheme: DtextTheme.darkTextTheme,
    outlinedButtonTheme: DOutlineButtonTheme.darkOutlineButtonTheme,
    elevatedButtonTheme: DelevatedButtonTheme.darkelevatedButtonTheme,
    inputDecorationTheme: Dtextformfield.darkInputdecoration,
    appBarTheme: DAppbarTheme.darkAppbarTheme,
    floatingActionButtonTheme:
        DfloatingActionButtonTheme.darkfloatingActionButtonTheme,
    // iconTheme: IconThemeData(color: dPrimaryColor),
  );
}
