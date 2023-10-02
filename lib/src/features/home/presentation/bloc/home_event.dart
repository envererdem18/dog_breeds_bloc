part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class SplashOperationsEvent extends HomeEvent {
  const SplashOperationsEvent(this.context);
  final BuildContext context;
  @override
  List<Object> get props => [context];
}

final class GenerateImageEvent extends HomeEvent {
  const GenerateImageEvent(this.breedName);
  final String breedName;

  @override
  List<Object> get props => [breedName];
}

final class SearcBreedEvent extends HomeEvent {
  const SearcBreedEvent(this.term);
  final String term;

  @override
  List<Object> get props => [term];
}

final class RefreshFilterEvent extends HomeEvent {
  const RefreshFilterEvent();

  @override
  List<Object> get props => [];
}
