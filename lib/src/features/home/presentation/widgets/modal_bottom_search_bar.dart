import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/sizes.dart';

class ModalButtomSearchBar extends StatefulWidget {
  const ModalButtomSearchBar({super.key});

  @override
  State<ModalButtomSearchBar> createState() => _ModalButtomSearchBarState();
}

class _ModalButtomSearchBarState extends State<ModalButtomSearchBar> {
  late final DraggableScrollableController _controller;
  @override
  void initState() {
    _controller = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _showSearchButton = true;
  Offset _pointerDownPosition = const Offset(0, 0);
  bool? _isFullScreen;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _showSearchButton,
      replacement: const SizedBox.shrink(),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _showSearchButton = !_showSearchButton;
          });
          _isFullScreen = null;
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) {
              return Listener(
                onPointerDown: (details) {
                  _pointerDownPosition = details.position;
                },
                onPointerUp: (details) {
                  _whenUserDraggedDownward(details, context);
                  _whenUserDraggedUpward(details);
                },
                child: DraggableScrollableSheet(
                  initialChildSize: .2,
                  minChildSize: .2,
                  maxChildSize: .9,
                  expand: false,
                  shouldCloseOnMinExtent: false,
                  controller: _controller,
                  builder: (_, scrollController) => ListView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.p16,
                    ),
                    children: [
                      const _DragHandleWidget(),
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: context.textTheme.bodyMedium,
                        onEditingComplete: () => context.pop(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          setState(() {
            _showSearchButton = !_showSearchButton;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: context.textTheme.bodyMedium!.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _whenUserDraggedUpward(PointerUpEvent details) {
    if (_isUpward(details)) {
      if (_isFullScreen == true) return;
      _isFullScreen = true;
      _controller.animateTo(
        1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void _whenUserDraggedDownward(PointerUpEvent details, BuildContext context) {
    if (_isDownward(details)) {
      if (_isFullScreen == false || _isFullScreen == null) {
        context.pop();
      } else {
        _isFullScreen = false;
        _controller.animateTo(
          .2,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      }
    }
  }

  bool _isUpward(PointerUpEvent details) =>
      _pointerDownPosition.dy - details.position.dy > 0.0;

  bool _isDownward(PointerUpEvent details) =>
      details.position.dy - _pointerDownPosition.dy > 0;
}

class _DragHandleWidget extends StatelessWidget {
  const _DragHandleWidget();

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
