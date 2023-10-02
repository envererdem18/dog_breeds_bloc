import 'package:bloc/bloc.dart';
import 'package:dog_breeds_bloc/bloc_observer.dart';
import 'package:dog_breeds_bloc/src/features/app.dart';
import 'package:dog_breeds_bloc/src/features/home/data/dog_repository.dart';
import 'package:flutter/material.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  Bloc.observer = DogBreedsBlocObserver();

  runApp(DogBreedsApp(dogRepository: DogRepository()));
}
