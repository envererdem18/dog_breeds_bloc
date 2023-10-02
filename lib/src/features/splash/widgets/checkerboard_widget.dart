import 'package:flutter/material.dart';

import '../../../core/constants/sizes.dart';

class CheckerboardWidget extends StatelessWidget {
  const CheckerboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(Sizes.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Row(),
          _Row(startWithBlack: false),
          _Row(),
          _Row(startWithBlack: false),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final bool startWithBlack;
  _Row({
    Key? key,
    this.startWithBlack = true,
  }) : super(key: key);

  final _colorOrder = [
    Colors.black,
    Colors.white,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: startWithBlack
            ? _colorOrder
                .map((color) => _RowItem(
                      color: color,
                    ))
                .toList()
            : _colorOrder.reversed
                .map((color) => _RowItem(
                      color: color,
                    ))
                .toList());
  }
}

class _RowItem extends StatelessWidget {
  final Color color;
  const _RowItem({
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      color: color,
    );
  }
}
