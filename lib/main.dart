import 'package:flutter/material.dart';
import 'package:grid_view_demo/presentation/splash_screen.dart';
import 'package:grid_view_demo/resources/string_manager.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.startTitle,
     debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

