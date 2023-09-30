import 'package:flutter/material.dart';

final class ColorPalette {
  // Colors
  static const Color black = Color(0XFF000000);
  static const Color white = Color(0XFFFFFFFF);
  static const Color fadedLightGrey = Color(0XFFE5E5EA);
  static const Color fadedDarkGrey = Color(0XFFC7C7CC);
}

final class LightColors {
  static Color title = ColorPalette.black;
  static Color divider = ColorPalette.fadedLightGrey;
}

final class DarkColors {
  static Color title = ColorPalette.white;
  static Color divider = ColorPalette.fadedLightGrey;
}
