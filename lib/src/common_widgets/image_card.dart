import 'package:dog_breeds_bloc/src/core/constants/sizes.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  const ImageCard({
    Key? key,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.p8),
        child: Stack(
          children: [
            Image.network(
              imagePath,
              fit: BoxFit.fitHeight,
              height: 160,
              width: 160,
            ),
            Positioned(
              left: Sizes.p8,
              bottom: Sizes.p8,
              child: Text('Breed', style: context.imageBoxCaption),
            ),
          ],
        ),
      ),
    );
  }
}
