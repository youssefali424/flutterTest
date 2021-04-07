import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospitals/views/test/AnimatedRail/AnimatedRailRaw.dart';

import 'RailItem.dart';

class AnimatedRail extends StatefulWidget {
  final double width;
  final double maxWidth;
  final TextDirection direction;
  final List<RailItem> items;
  final Color iconBackground;
  final Color activeColor;
  final Color iconColor;
  final int selectedIndex;
  final Color background;

  const AnimatedRail(
      {Key key,
      this.width = 50,
      this.maxWidth = 350,
      this.direction = TextDirection.ltr,
      this.items = const [],
      this.iconBackground = Colors.white,
      this.activeColor,
      this.iconColor,
      this.selectedIndex,
      this.background})
      : super(key: key);

  @override
  _AnimatedRailState createState() => _AnimatedRailState();
}

class _AnimatedRailState extends State<AnimatedRail> {
  // int selectedIndex = 0;
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  void didUpdateWidget(covariant AnimatedRail oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != null) {
      selectedIndexNotifier.value =
          (widget.selectedIndex ?? 0) > (widget.items.length - 1)
              ? 0
              : widget.selectedIndex;
    }
  }

  _changeIndex(int i) {
    selectedIndexNotifier.value = i;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: Container(
        child: LayoutBuilder(
          builder: (cx, constraints) {
            var items = widget.items;
            return Stack(
              alignment: widget.direction == TextDirection.ltr
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              children: [
                ValueListenableBuilder(
                  valueListenable: selectedIndexNotifier,
                  builder: (cx, index, _) =>
                      items.isNotEmpty ? items[index].screen : Container(),
                ),
                AnimatedRailRaw(
                  constraints: constraints,
                  items: widget.items,
                  width: widget.width,
                  activeColor: widget.activeColor,
                  iconColor: widget.iconColor,
                  background: widget.background,
                  direction: widget.direction,
                  maxWidth: widget.maxWidth,
                  selectedIndex: widget.selectedIndex,
                  iconBackground: widget.iconBackground,
                  onTap: _changeIndex,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
