import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds_bloc/src/core/constants/sizes.dart';
import 'package:dog_breeds_bloc/src/core/theme/color_palette.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:dog_breeds_bloc/src/features/home/domain/breed.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Breed breed;
  final VoidCallback? onTap;

  /// A simple card displays breed name and image as [CachedNetworkImage]
  const ImageCard({
    Key? key,
    required this.breed,
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
            CachedNetworkImage(
              imageUrl: breed.imagePath,
              width: 160,
              height: 160,
              fit: BoxFit.cover,
              fadeInDuration: Duration.zero,
              placeholderFadeInDuration: Duration.zero,
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.image,
                  size: Sizes.p44,
                  color: ColorPalette.fadedDarkGrey,
                );
              },
            ),
            Positioned(
              left: Sizes.p8,
              bottom: Sizes.p8,
              child: Text(breed.name, style: context.imageBoxCaption),
            ),
          ],
        ),
      ),
    );
  }
}
