import 'package:flutter/material.dart';
import 'colors.dart' as colors;

const String fontFamily = "SanFrancisco";
final ThemeData lightTheme = _buildlightTheme();

ThemeData _buildlightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: base.textTheme.apply(fontFamily: fontFamily),
    primaryTextTheme: base.primaryTextTheme.apply(fontFamily: fontFamily),
    accentTextTheme: base.accentTextTheme.apply(fontFamily: fontFamily),
    primaryColor: colors.primary,
    primaryColorLight: colors.primaryLight,
    primaryColorDark: colors.primaryDark,
    accentColor: colors.secondary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 16),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
        alignment: Alignment.center,
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 40),
        ),
        backgroundColor: MaterialStateProperty.all(colors.primary),
      ),
    ),
    appBarTheme: base.appBarTheme.copyWith(
      titleTextStyle: TextStyle(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: base.cardTheme.copyWith(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
