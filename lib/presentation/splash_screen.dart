import 'package:flutter/material.dart';
import 'package:grid_view_demo/presentation/grid_view_screen.dart';
import 'package:grid_view_demo/resources/color_manager.dart';
import 'package:grid_view_demo/resources/font_manager.dart';
import 'package:grid_view_demo/resources/string_manager.dart';
import 'package:grid_view_demo/resources/theme_manager.dart';
import 'package:grid_view_demo/resources/value_manager.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GridFormInput()),
      );
    });

    return Scaffold(
      backgroundColor: ColorManager.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.startTitle,
              style: TextStyle(
                fontSize: FontSize.s36,
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
            ),
            const SizedBox(height: AppSize.s20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
            ),
            const SizedBox(height: AppSize.s20),
            Text(AppStrings.loading,
                style: ButtonThemeConstant.buttonTextStyle),
          ],
        ),
      ),
    );
  }
}
