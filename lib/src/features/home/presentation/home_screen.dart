import 'package:dog_breeds_bloc/src/common_widgets/image_card.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/sizes.dart';
import 'bloc/home_bloc.dart';
import 'widgets/breed_summary_widget.dart';
import 'widgets/modal_bottom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final breeds = isSearchSuccessful(state)
            ? state.filteredBreeds
            : isSearchFail(state)
                ? null
                : state.allBreeds;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dog Breeds'),
            actions: [
              Visibility(
                visible:
                    state.searchTerm != null && state.searchTerm!.isNotEmpty,
                replacement: const SizedBox.shrink(),
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<HomeBloc>().add(const RefreshFilterEvent());
                  },
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Visibility(
                visible: breeds != null,
                replacement: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'No results found\n',
                        style: context.textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Try searching with another word',
                            style: context.textTheme.bodyMedium,
                          )
                        ]),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: Sizes.p16,
                      runSpacing: Sizes.p16,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: breeds == null
                          ? []
                          : breeds
                              .map((breed) => ImageCard(
                                    breed: breed,
                                    onTap: () async {
                                      await showGeneralDialog(
                                        context: context,
                                        transitionBuilder:
                                            (context, a1, a2, widget) {
                                          final curvedValue = Curves
                                                  .easeInOutBack
                                                  .transform(a1.value) -
                                              1.0;
                                          return Transform(
                                            transform:
                                                Matrix4.translationValues(
                                              0.0,
                                              curvedValue * -300,
                                              0.0,
                                            ),
                                            child: Opacity(
                                              opacity: a1.value,
                                              child: widget,
                                            ),
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return BreedSummaryWidget(
                                              breed: breed);
                                        },
                                      );
                                    },
                                  ))
                              .toList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: Sizes.p16,
                left: Sizes.p16,
                right: Sizes.p16,
                child: ModalButtomSearchBar(
                  searchTerm: state.searchTerm,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isSearchSuccessful(HomeState state) =>
      state.searchTerm != null &&
      state.filteredBreeds != null &&
      state.filteredBreeds!.isNotEmpty;
  bool isSearchFail(HomeState state) =>
      state.searchTerm != null &&
      state.filteredBreeds != null &&
      state.filteredBreeds!.isEmpty;
}
