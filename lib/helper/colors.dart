import 'dart:ui';

class ColorHelper {

    ColorHelper._internal();

  static final ColorHelper _instance = ColorHelper._internal();

  factory ColorHelper() {
    return _instance;
  }

  static const Color primaryColor = Color(0xFF673AB7);
  static const Color blue = Color(0xFF90CAF9);
  static const Color weatherCardColor = Color(0xFF1E232B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color dialogLocationCardColor = Color(0xFF1C1F26);
}