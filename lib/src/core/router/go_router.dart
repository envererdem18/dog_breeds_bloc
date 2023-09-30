import 'package:dog_breeds_bloc/src/features/home/presentation/home_screen.dart';
import 'package:dog_breeds_bloc/src/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/base/base_screen.dart';
import 'not_found_screen.dart';

enum AppRoute {
  home,
  settings,
  settingsPlaceholder,
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'home screen');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings screen');

final GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: false,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              name: AppRoute.home.name,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingsKey,
          routes: [
            GoRoute(
              path: '/settingsPlaceholder',
              name: AppRoute.settingsPlaceholder.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ScreenPlaceholder(description: 'Settings Placeholder'),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      name: AppRoute.settings.name,
      pageBuilder: (context, state) => const MaterialPage(
        fullscreenDialog: true,
        child: SettingsScreen(),
      ),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);

class ScreenPlaceholder extends StatelessWidget {
  final String description;

  const ScreenPlaceholder({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(description),
      ),
    );
  }
}

class FullScreenDialogFrame extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  const FullScreenDialogFrame({
    Key? key,
    required this.body,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close),
            ),
          ),
      body: body,
    );
  }
}
