import 'package:flutter/material.dart';
import 'package:price_tracker/theme/colors.dart';

class AppTheme {
  static final ThemeData lightTheme=ThemeData(
    brightness: Brightness.light,
    textTheme: lightTextTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(primary:primaryColor ),
    primaryColorDark: primaryColor,
  );
  static final ThemeData darkTheme=ThemeData(
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      textTheme: darkTextTheme
  );
  static const TextTheme lightTextTheme= TextTheme(
    bodyText1: _lightTextStyle,
    subtitle1:_lightSubTitleStyle ,
    button: _lightButtonStyle,
  );
  static const TextTheme darkTextTheme= TextTheme(
    bodyText1:    _darkTextStyle,
    subtitle1:   _darkSubTitleStyle,
  );
  static const TextStyle _lightTextStyle=TextStyle(
      color: Colors.black,
      fontSize: 28
  );
  static const TextStyle _lightSubTitleStyle=TextStyle(
      fontSize: 18,
      height: 1.5
  );
  static const TextStyle _lightButtonStyle=TextStyle(
      color: Colors.black,
      fontSize: 22
  );
  static const TextStyle _darkTextStyle=TextStyle(
      color: Colors.white,
      fontSize: 28
  );
  static const TextStyle _darkSubTitleStyle=TextStyle(
      color: Colors.white70,
      fontSize: 18,
      height: 1.5
  );
  static TextStyle lookUpTextStyle =const TextStyle(
    fontSize:13,
    color: textColor,
  );
}
