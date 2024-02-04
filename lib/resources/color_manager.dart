import 'package:flutter/material.dart';
class ColorManager{
  static Color primary = HexColor.fromHex("#ED9728");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black  = HexColor.fromHex("#000000");
  static Color blue = Colors.blue;
  static Color? teal = Colors.teal[200];
  static Color? blueFaint = Colors.blue[50];
  static Color? greenDark = Colors.green[800];
  static Color transparent = Colors.transparent;
  static Color blueGrey = Colors.blueGrey;
  static Color indigo = Colors.indigo;

}

extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length == 6){
      hexColorString = "FF"+ hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}