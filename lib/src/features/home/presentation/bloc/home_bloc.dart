import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds_bloc/src/core/router/go_router.dart';
import 'package:dog_breeds_bloc/src/features/home/data/dog_repository.dart';
import 'package:dog_breeds_bloc/src/features/home/domain/breed.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';
part 'home_state.dart';

// usage exapmle: https://github.com/felangel/fluttersaurus/blob/master/lib/search/bloc/search_bloc.dart
EventTransformer<E> _restartableDebounce<E>() {
  return (events, mapper) {
    return restartable<E>()(
      events.debounce(const Duration(milliseconds: 1000)),
      mapper,
    );
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._dogRepository) : super(HomeInitial()) {
    on<SplashOperationsEvent>(_getAllBreeds);

    on<GenerateImageEvent>(_getBreedImage);

    on<SearcBreedEvent>(
      _onSearchTermChanged,
      transformer: _restartableDebounce(),
    );

    on<RefreshFilterEvent>(_onRefresh);
  }

  final DogRepository _dogRepository;

  Future<void> _getAllBreeds(
    SplashOperationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    final context = event.context;
    final allBreeds = await _dogRepository.getAllBreeds();
    final breedsWithImage = <Breed>[];
    await Future.wait(
      allBreeds.map(
        (breed) async {
          String imagePath = await _dogRepository.generate(breed: breed.name);
          if (context.mounted) await _loadImage(imagePath, context);

          breedsWithImage.add(Breed(
            name: breed.name,
            subBreeds: breed.subBreeds,
            imagePath: imagePath,
          ));
        },
      ).toList(),
    );
    emit(HomeSplashSuccess(breedsWithImage));
    if (context.mounted && breedsWithImage.isNotEmpty) {
      context.goNamed(AppRoute.home.name);
    }
  }

  Future<void> _loadImage(String imageUrl, BuildContext context) async {
    try {
      await precacheImage(CachedNetworkImageProvider(imageUrl), context);
      debugPrint('Image loaded and cached successfully!');
    } catch (e) {
      debugPrint('Failed to load and cache the image: $e');
    }
  }

  Future<void> _getBreedImage(
    GenerateImageEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _dogRepository.generate(breed: event.breedName);
  }

  Future<void> _onSearchTermChanged(
    SearcBreedEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (event.term.isEmpty) {
      return emit(HomeFilterSuccess(const [], state.allBreeds, null));
    }
    final all = state.allBreeds;
    final filtered = all
        .where(
          (breed) =>
              breed.name.toLowerCase().contains(event.term.toLowerCase()),
        )
        .toList();
    emit(
      HomeFilterSuccess(filtered.isEmpty ? [] : filtered, all, event.term),
    );
  }

  void _onRefresh(
    RefreshFilterEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeFilterSuccess(null, state.allBreeds, null));
  }
}
