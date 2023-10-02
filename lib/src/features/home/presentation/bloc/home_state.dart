part of 'home_bloc.dart';

enum GenerateImageStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  const HomeState({
    this.generateImageStatus = GenerateImageStatus.initial,
    this.allBreeds = const <Breed>[],
    this.filteredBreeds,
    this.searchTerm,
  });

  final GenerateImageStatus generateImageStatus;
  final List<Breed> allBreeds;
  final List<Breed>? filteredBreeds;
  final String? searchTerm;

  @override
  List<Object?> get props => [generateImageStatus, allBreeds, filteredBreeds];
}

final class HomeInitial extends HomeState {}

final class HomeSplashSuccess extends HomeState {
  final List<Breed> breeds;
  const HomeSplashSuccess(this.breeds) : super(allBreeds: breeds);

  @override
  List<Object> get props => [breeds];
}

final class HomeFilterSuccess extends HomeState {
  final List<Breed>? breeds;
  final List<Breed> oldBreeds;
  final String? term;
  const HomeFilterSuccess(this.breeds, this.oldBreeds, this.term)
      : super(
          filteredBreeds: breeds,
          allBreeds: oldBreeds,
          searchTerm: term,
        );

  @override
  List<Object?> get props => [breeds];
}
