import 'dart:math' as math;

import 'package:dog_breeds_bloc/src/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
        itemCount: settingsScreenItems.length,
        itemBuilder: (context, index) {
          final item = settingsScreenItems[index];
          return _SettingScreenItem(
            leading: item.icon,
            title: item.title,
            trailing: item.trailing,
          );
        },
      ),
    );
  }
}

class _SettingScreenItem extends StatelessWidget {
  final Widget leading;
  final Widget? trailing;
  final String title;
  const _SettingScreenItem({
    Key? key,
    required this.leading,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      trailing: Visibility(
        visible: trailing == null,
        replacement: trailing ?? const SizedBox.shrink(),
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: const Icon(
            Icons.arrow_forward,
            size: 16,
            color: ColorPalette.fadedDarkGrey,
          ),
        ),
      ),
    );
  }
}
