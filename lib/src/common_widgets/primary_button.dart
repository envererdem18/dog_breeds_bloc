import 'package:dog_breeds_bloc/src/core/constants/sizes.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double elevation;
  final String? text;
  final VoidCallback? onPressed;
  final Alignment textAlignment;
  final Color? backgroundColor;
  final Color? textColor;
  const PrimaryButton({
    Key? key,
    this.elevation = 5,
    this.text,
    this.onPressed,
    this.textAlignment = Alignment.centerLeft,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        fixedSize: const Size(double.infinity, Sizes.p64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p8),
        ),
        backgroundColor: backgroundColor,
        visualDensity: VisualDensity.comfortable,
        alignment: textAlignment,
      ),
      child: Text(
        text ?? '',
        style: context.textTheme.bodyMedium!.copyWith(
          color: textColor ?? Colors.grey,
        ),
      ),
    );
  }
}
