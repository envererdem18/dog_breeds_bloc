import 'package:dog_breeds_bloc/src/core/constants/sizes.dart';
import 'package:dog_breeds_bloc/src/core/theme/app_text_styles.dart';
import 'package:dog_breeds_bloc/src/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {}

class LightTheme extends AppTheme {
  static ThemeData data = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: Sizes.p20,
        fontWeight: FontWeight.w600,
        color: LightColors.titleBlue,
      ),
      titleMedium: TextStyle(
        fontSize: Sizes.p20,
        fontWeight: FontWeight.w600,
        color: LightColors.title,
      ),
      bodyMedium: TextStyle(
        fontSize: Sizes.p16,
        fontWeight: FontWeight.w500,
        color: LightColors.title,
      ),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: AppTextStyles.title3.copyWith(color: LightColors.title),
    ),
    dividerTheme: DividerThemeData(
      color: LightColors.divider,
      thickness: 2,
    ),
    listTileTheme: ListTileThemeData(
      textColor: LightColors.title,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: _inputBorder,
      enabledBorder: _inputBorder,
      focusedBorder: _inputBorder,
      disabledBorder: _inputBorder,
      hintStyle: const TextStyle(
        fontSize: Sizes.p16,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(
        fontSize: Sizes.p16,
        fontWeight: FontWeight.w500,
        color: ColorPalette.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        fixedSize: const Size(double.infinity, Sizes.p64),
        textStyle: AppTextStyles.body,
      ),
    ),
  );

  static get _inputBorder => InputBorder.none;
  static get _borderRadius => BorderRadius.circular(Sizes.p8);
}

class DarkTheme extends AppTheme {
  static ThemeData data = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: AppBarTheme(
      titleTextStyle: AppTextStyles.title3.copyWith(color: DarkColors.title),
    ),
  );
}
