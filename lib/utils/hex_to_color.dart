import 'package:flutter/material.dart';

class ColorExtension extends Color {
  ColorExtension(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    //Redix == เลขฐาน
    return int.parse(hexColor, radix: 16);
  }
}
