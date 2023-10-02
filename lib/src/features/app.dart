import 'package:dog_breeds_bloc/src/core/theme/app_theme.dart';
import 'package:dog_breeds_bloc/src/features/home/data/dog_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/router/go_router.dart';
import 'home/presentation/bloc/home_bloc.dart';

class DogBreedsApp extends StatelessWidget {
  final DogRepository dogRepository;
  const DogBreedsApp({
    Key? key,
    required this.dogRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: dogRepository,
      child: BlocProvider(
        create: (context) => HomeBloc(dogRepository),
        lazy: false,
        child: MaterialApp.router(
          title: 'Dog Breeds',
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          onGenerateTitle: (BuildContext context) => 'Dog Breeds',
          routerConfig: routerConfig,
          themeMode: ThemeMode.light,
          theme: LightTheme.data,
          darkTheme: DarkTheme.data,
        ),
      ),
    );
  }
}
