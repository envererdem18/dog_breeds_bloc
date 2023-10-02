import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';

class DragHandleWidget extends StatelessWidget {
  const DragHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.p16,
        bottom: Sizes.p12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 6,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(Sizes.p16),
            ),
          ),
        ],
      ),
    );
  }
}
