import 'package:dog_breeds_bloc/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../core/router/go_router.dart';

class DogBreedsApp extends StatelessWidget {
  const DogBreedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dog Breeds',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'Dog Breeds',
      routerConfig: routerConfig,
      themeMode: ThemeMode.light,
      theme: LightTheme.data,
      darkTheme: DarkTheme.data,
    );
  }
}
