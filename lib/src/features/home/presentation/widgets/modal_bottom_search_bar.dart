import 'package:dog_breeds_bloc/src/common_widgets/primary_button.dart';
import 'package:dog_breeds_bloc/src/core/theme/custom_text_styles.dart';
import 'package:dog_breeds_bloc/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/sizes.dart';
import 'drag_handle_widget.dart';

class ModalButtomSearchBar extends StatefulWidget {
  final String? searchTerm;
  const ModalButtomSearchBar({
    Key? key,
    this.searchTerm,
  }) : super(key: key);

  @override
  State<ModalButtomSearchBar> createState() => _ModalButtomSearchBarState();
}

class _ModalButtomSearchBarState extends State<ModalButtomSearchBar> {
  late final DraggableScrollableController _draggableController;
  @override
  void initState() {
    _draggableController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _draggableController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  bool _showSearchButton = true;
  Offset _pointerDownPosition = const Offset(0, 0);
  bool _isFullScreen = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _showSearchButton,
      replacement: const SizedBox.shrink(),
      child: PrimaryButton(
        text: widget.searchTerm ?? 'Search',
        onPressed: () async {
          _toggleSearchButton();
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) {
              return Listener(
                onPointerDown: (details) {
                  _pointerDownPosition = details.position;
                },
                onPointerUp: _drag,
                child: DraggableScrollableSheet(
                  initialChildSize: .2,
                  minChildSize: .2,
                  maxChildSize: .9,
                  expand: false,
                  shouldCloseOnMinExtent: false,
                  controller: _draggableController,
                  builder: (_, scrollController) => ListView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.p16,
                    ),
                    children: [
                      const DragHandleWidget(),
                      TextFormField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: context.textTheme.bodyMedium,
                        onChanged: (value) {
                          context.read<HomeBloc>().add(SearcBreedEvent(value));
                        },
                        onEditingComplete: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          _searchController.clear();
          _toggleSearchButton();
        },
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
    );
  }

  void _toggleSearchButton() =>
      setState(() => _showSearchButton = !_showSearchButton);

  void _drag(PointerUpEvent details) {
    return switch (_pointerDownPosition.dy.compareTo(details.position.dy)) {
      1 => _onDraggedUpward(details),
      -1 => _onDraggedDownward(details, context),
      _ => null,
    };
  }

  void _onDraggedUpward(PointerUpEvent details) {
    if (_isFullScreen) return;

    _isFullScreen = true;
    _draggableController.animateTo(
      1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void _onDraggedDownward(PointerUpEvent details, BuildContext context) {
    if (!_isFullScreen) {
      context.pop();
      return;
    }

    _isFullScreen = false;
    _draggableController.animateTo(
      .2,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }
}
