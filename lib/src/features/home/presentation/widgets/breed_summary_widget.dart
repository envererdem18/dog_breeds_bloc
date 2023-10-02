import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds_bloc/src/common_widgets/primary_button.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:dog_breeds_bloc/src/features/home/data/dog_repository.dart';
import 'package:dog_breeds_bloc/src/features/home/domain/breed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/sizes.dart';

class BreedSummaryWidget extends StatelessWidget {
  final Breed breed;
  const BreedSummaryWidget({
    Key? key,
    required this.breed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p12),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: breed.imagePath,
                  fit: BoxFit.cover,
                ),
                gapH12,
                Text(
                  'Breed',
                  style: context.textTheme.titleLarge,
                ),
                const Divider(height: Sizes.p18),
                Text(
                  breed.name,
                  style: context.textTheme.bodyMedium,
                ),
                gapH12,
                Text(
                  'Sub-Breed',
                  style: context.textTheme.titleLarge,
                ),
                const Divider(height: Sizes.p18),
                ...breed.subBreeds
                    .map(
                      (subBreed) => Text(
                        subBreed,
                        style: context.textTheme.bodyMedium,
                      ),
                    )
                    .toList(),
                gapH16,
                Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: 'Generate',
                          textAlignment: Alignment.center,
                          textColor: Colors.white,
                          backgroundColor: Colors.blue,
                          onPressed: () async {
                            await _showInnerDialog(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const _CloseDialogButton()
        ],
      ),
    );
  }

  Future<void> _showInnerDialog(BuildContext context) async {
    final imagePath = await RepositoryProvider.of<DogRepository>(context)
        .generate(breed: breed.name);
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.hardEdge,
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.p12),
            ),
            child: SizedBox(
              width: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.p12),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  gapH16,
                  CloseButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

class _CloseDialogButton extends StatelessWidget {
  const _CloseDialogButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Sizes.p12,
      right: Sizes.p12,
      child: CloseButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}
