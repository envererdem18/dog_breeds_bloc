import 'package:flutter/material.dart';

/// App Color Types
final class ColorPalette {
  static const Color black = Color(0XFF000000);
  static const Color white = Color(0XFFFFFFFF);
  static const Color fadedLightGrey = Color(0XFFE5E5EA);
  static const Color fadedDarkGrey = Color(0XFFC7C7CC);
  static const Color blue = Color(0XFF0055D3);
}

/// Color types those dedicated for [ThemeData.light]
final class LightColors {
  static Color title = ColorPalette.black;
  static Color titleBlue = ColorPalette.blue;
  static Color divider = ColorPalette.fadedLightGrey;
}

/// Color types those dedicated for [ThemeData.dark]
final class DarkColors {
  static Color title = ColorPalette.white;
  static Color divider = ColorPalette.fadedLightGrey;
}
