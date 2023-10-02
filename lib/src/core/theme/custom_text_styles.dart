import 'package:dog_breeds_bloc/src/core/constants/sizes.dart';
import 'package:dog_breeds_bloc/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'color_palette.dart';

/// It allows us to access theme arguments through the [BuildContext].
extension CustomTextStylesExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  // Custom Text Styles
  TextStyle get imageBoxCaption => AppTextStyles.body.copyWith(
        color: ColorPalette.white,
        shadows: _textShadow,
      );

  List<Shadow> get _textShadow => [
        const Shadow(
          color: ColorPalette.black,
          blurRadius: Sizes.p10,
          offset: Offset(0.0, 0.0),
        ),
        const Shadow(
          color: ColorPalette.black,
          blurRadius: Sizes.p10,
          offset: Offset(0.0, 0.0),
        ),
      ];
}
