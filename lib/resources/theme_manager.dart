import 'package:flutter/material.dart';
import 'package:grid_view_demo/resources/font_manager.dart';
import 'color_manager.dart';

///appbar text theme
class AppBarThemeConstant {
  static TextStyle appBarTextStyle = TextStyle(
    fontSize: FontSize.s20,
    fontWeight: FontWeight.w700,
    color: ColorManager.white,
  );
}

///buttonTheme
class ButtonThemeConstant{
  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: ColorManager.white,
  );
}
