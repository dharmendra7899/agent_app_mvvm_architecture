import 'package:agent_app/res/widgets/colors.dart' show appColors;
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    fontFamily: 'LibreFont',
    scaffoldBackgroundColor: appColors.appWhite,
    appBarTheme: AppBarTheme(
      surfaceTintColor: appColors.appWhite,
      color: appColors.appWhite,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: appColors.appBlack),
      bodyMedium: TextStyle(color: appColors.appBlack),
      bodySmall: TextStyle(color: appColors.appBlack),
      titleMedium: TextStyle(color: appColors.appBlack),
      titleSmall: TextStyle(color: appColors.appBlack),
      titleLarge: TextStyle(color: appColors.appBlack),
    ),
    cardTheme: CardTheme(
      color: appColors.appWhite,
      surfaceTintColor: appColors.appWhite,
    ),
    iconTheme: IconThemeData(color: appColors.appBlack),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: appColors.appBlack,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: appColors.borderColor),
      labelStyle: TextStyle(color: appColors.borderColor),
      floatingLabelStyle: TextStyle(color: appColors.appBlack),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.borderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.appBlack),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.appBlack),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.secondary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.secondary),
      ),
    ),
  );
}
