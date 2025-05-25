import 'package:flutter/material.dart';
import 'package:waterapp/util/color.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.primarydark,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.onprimarydark,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.secondarydark,
      primary: AppColor.primarydark,
      onPrimary: AppColor.onprimarydark,
    ),
  );
}
