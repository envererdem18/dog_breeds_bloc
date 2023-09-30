import 'package:dog_breeds_bloc/src/core/constants/sizes.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double elevation;
  final String? text;
  final VoidCallback? onPressed;
  final MainAxisAlignment textAlignment;
  final Color? backgroundColor;
  final Color? textColor;
  const PrimaryButton({
    Key? key,
    this.elevation = 5,
    this.text,
    this.onPressed,
    this.textAlignment = MainAxisAlignment.start,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      height: Sizes.p64,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p8),
      ),
      color: backgroundColor ?? Colors.blue,
      visualDensity: VisualDensity.comfortable,
      child: Row(
        mainAxisAlignment: textAlignment,
        children: [
          Text(
            text ?? '',
            style: context.textTheme.bodyMedium!.copyWith(
              color: textColor ?? Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
