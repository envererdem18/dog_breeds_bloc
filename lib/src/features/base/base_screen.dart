import 'package:dog_breeds_bloc/src/core/router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/breakpoints.dart';

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));

  void _goBranch(BuildContext context, int index) => switch (index) {
        1 => context.pushNamed(AppRoute.settings.name),
        _ => navigationShell.goBranch(
            index,
            initialLocation: true,
          ),
      };

  bool collapseNavBar(int index) => index != 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final index = navigationShell.currentIndex;
      final isCollapse = collapseNavBar(index);
      if (constraints.maxWidth < Breakpoint.tablet) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: index,
          onDestinationSelected: (value) => _goBranch(context, value),
          showNavigationBar: isCollapse,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: index,
          onDestinationSelected: (value) => _goBranch(context, value),
          showNavigationRail: isCollapse,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final bool showNavigationBar;
  final ValueChanged<int> onDestinationSelected;

  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.showNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: Visibility(
        visible: showNavigationBar,
        child: NavigationBar(
          selectedIndex: selectedIndex,
          destinations: const [
            NavigationDestination(
              label: 'Home',
              selectedIcon: Icon(Icons.home_filled),
              icon: Icon(Icons.home),
              tooltip: '',
            ),
            NavigationDestination(
              label: 'Settings',
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings),
              tooltip: '',
            ),
          ],
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final bool showNavigationRail;
  final ValueChanged<int> onDestinationSelected;

  const ScaffoldWithNavigationRail({
    Key? key,
    required this.body,
    required this.selectedIndex,
    required this.showNavigationRail,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Row(
        children: [
          Visibility(
            visible: showNavigationRail,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                    labelType: NavigationRailLabelType.all,
                    leading: height <= 450
                        ? null
                        : GestureDetector(
                            onDoubleTap: () =>
                                context.goNamed(AppRoute.home.name),
                            child: IntrinsicWidth(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.logo_dev),
                                  const Text(
                                    'Dogs',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Divider(
                                    height: 30,
                                    color: Theme.of(context)
                                        .dividerColor
                                        .withOpacity(.2),
                                  )
                                ],
                              ),
                            ),
                          ),
                    destinations: const <NavigationRailDestination>[
                      NavigationRailDestination(
                        label: Text('Home'),
                        selectedIcon: Icon(Icons.home_filled),
                        icon: Icon(Icons.home),
                      ),
                      NavigationRailDestination(
                        label: Text('Settings'),
                        selectedIcon: Icon(Icons.settings),
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
