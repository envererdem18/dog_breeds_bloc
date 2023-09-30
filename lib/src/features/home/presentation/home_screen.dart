import 'package:dog_breeds_bloc/src/common_widgets/image_card.dart';
import 'package:dog_breeds_bloc/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/sizes.dart';
import 'widgets/modal_bottom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$appName'),
      ),
      body: const Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: Sizes.p16,
                runSpacing: Sizes.p16,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ImageCard(imagePath: dogImage2),
                  ImageCard(imagePath: dogImage),
                  ImageCard(imagePath: dogImage),
                  ImageCard(imagePath: dogImage2),
                  ImageCard(imagePath: dogImage),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Sizes.p16,
            left: Sizes.p16,
            right: Sizes.p16,
            child: ModalButtomSearchBar(),
          ),
        ],
      ),
    );
  }
}
