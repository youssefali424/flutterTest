import 'dart:async';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import "dart:math";
import 'CustomScrollPhysics.dart';
import 'interpolate.dart';

typedef Builder = Widget Function(
    BuildContext context, int index, double progress, double maxHeight);

class SnappingListView extends StatefulWidget {
  final Axis scrollDirection;
  final ScrollController controller;
  final Builder itemBuilder;
  final int itemCount;
  final double itemExtent;
  final double maxExtent;
  final ValueChanged<int> onItemChanged;

  final EdgeInsets padding;
  SnappingListView.builder(
      {this.scrollDirection,
      this.controller,
      @required this.itemBuilder,
      this.itemCount,
      @required this.itemExtent,
      this.onItemChanged,
      this.padding = const EdgeInsets.only(top: 0),
      @required this.maxExtent})
      : assert(itemExtent != null && itemExtent > 0),
        assert(maxExtent != null && maxExtent > 0),
        assert(maxExtent >= itemExtent);

  @override
  createState() => _SnappingListViewState();
}

class _SnappingListViewState extends State<SnappingListView>
    with WidgetsBindingObserver {
  int _lastItem = 0;
  double position = 0.0;
  double defaultPadding = 0;
  StreamController<double> currentPositionStream;
  DummyChangePhysics dummy = DummyChangePhysics.H;
  Orientation currentOrientation;
  Size currSize;
  ScrollController controller;
  bool rotated;
  @override
  void initState() {
    super.initState();
    currentPositionStream = StreamController.broadcast()..add(position);
    WidgetsBinding.instance.addObserver(this);
    currSize = window.physicalSize;
    controller = ScrollController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    currentPositionStream.close();
    super.dispose();
  }

  didChangeMetrics() {
    // print("change dummy " + window.physicalSize.toString());
    if (currSize.width != window.physicalSize.width ||
        currSize.height != window.physicalSize.height) {
      setState(() {
        dummy = (dummy == DummyChangePhysics.H
            ? DummyChangePhysics.L
            : DummyChangePhysics.H);
        rotated = true;
      });
      final startPadding = widget.scrollDirection == Axis.horizontal
          ? widget.padding.left
          : widget.padding.top;
      controller.jumpTo(startPadding + defaultPadding);
    }
  }

  didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.maxExtent != widget.maxExtent) {
      if (rotated != null && !rotated) {
        dummy = (dummy == DummyChangePhysics.H
            ? DummyChangePhysics.L
            : DummyChangePhysics.H);
        // print("change dummy maxExtent");
      } else
        rotated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final startPadding = widget.scrollDirection == Axis.horizontal
        ? widget.padding.left
        : widget.padding.top;
    return OrientationBuilder(builder: (_, orientation) {
      // print("build");
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var maxSize = min(
            widget.scrollDirection == Axis.vertical
                ? constraints.maxHeight
                : constraints.maxWidth,
            widget.maxExtent);
        var remain = 0.0;
        print("maxSize $maxSize");
        print(constraints.maxWidth);
        if ((widget.scrollDirection == Axis.vertical &&
                !constraints.hasInfiniteHeight) ||
            (widget.scrollDirection == Axis.horizontal &&
                !constraints.hasInfiniteWidth)) {
          remain = (widget.scrollDirection == Axis.vertical
                  ? constraints.maxHeight
                  : constraints.maxWidth) -
              maxSize;
        }
        var padding = (constraints.maxWidth - widget.itemExtent) / 2;
        print('maxW ${constraints.maxWidth}');
        return NotificationListener<ScrollNotification>(
            child: _buildList(startPadding + padding, maxSize, remain,
                orientation, constraints.minHeight),
            onNotification: (notif) {
              if (notif.depth == 0 && notif is ScrollUpdateNotification) {
                final currPosition =
                    (notif.metrics.pixels - startPadding - defaultPadding) /
                        maxSize;
                final currItem = currPosition.truncate();
                if (currItem != _lastItem) {
                  setState(() {
                    _lastItem = currItem;
                  });
                  widget.onItemChanged?.call(currItem);
                }
                position = currPosition;
                currentPositionStream.add(currPosition);
              }
              return false;
            });
      });
    });
  }

  Matrix4 _pmat(num pv) {
    return new Matrix4(
      1.0, 0.0, 0.0, 0.0, //
      0.0, 1.0, 0.0, 0.0, //
      0.0, 0.0, 1.0, pv * 0.001, //
      0.0, 0.0, 0.0, 1.0,
    );
  }

  _buildList(
    double startPadding,
    double maxSize,
    double remain,
    Orientation orientation,
    double height,
  ) {
    print('startPadding $startPadding');
    double activePos = 50;
    return ListView.builder(
        scrollDirection: widget.scrollDirection,
        controller: controller,
        dragStartBehavior: DragStartBehavior.down,
        itemBuilder: (context, index) {
          if (index > widget.itemCount - 1) {
            if (remain < 0) {
              return Container();
            }
            return Container(
              height: remain,
            );
          }

          var currItem = _lastItem;

          // if (currItem >= index - 1.0 && currItem <= index + 1.0) {
          return StreamBuilder(
              stream: currentPositionStream.stream,
              builder: (context, snapshot) {
                var currPos = snapshot.hasData ? snapshot.data : position;
                var interpolation = interpolate(
                    currPos,
                    InterpolateConfig([
                      (index - 1.0),
                      (index + 0.0),
                      index + 1.0
                    ], [
                      0,
                      1,
                      2,
                    ], extrapolate: Extrapolate.CLAMP));
                double translate = interpolate(
                    currPos,
                    InterpolateConfig([
                      (index - 1.0),
                      (index + 0.0),
                      index + 1.0
                    ], [
                      0,
                      activePos,
                      0
                    ], extrapolate: Extrapolate.CLAMP));
                double translateZ = interpolate(
                    currPos,
                    InterpolateConfig(
                        [(index - 1.0), (index + 0.0), index + 1.0], [1, 20, 1],
                        extrapolate: Extrapolate.CLAMP));
                // double tZ = interpolate(
                //     currPos,
                //     InterpolateConfig([
                //       (index - 1.0),
                //       (index + 0.0),
                //       index + 1.0
                //     ], [
                //       -50,
                //       1,
                //       -50
                //     ], extrapolate: Extrapolate.CLAMP));

                // double rotate = interpolate(
                //     currPos,
                //     InterpolateConfig(
                //         [(index - 1.0), (index + 0.0), index + 1.0], [-1, 0, 1],
                //         extrapolate: Extrapolate.CLAMP));
                double opacity = interpolate(
                    currPos,
                    InterpolateConfig([
                      (index - 1.0),
                      (index + 0.0),
                      index + 1.0
                    ], [
                      0.5,
                      1,
                      0.5
                    ], extrapolate: Extrapolate.CLAMP));
                return Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: _pmat(translateZ)
                      // ..setRotationY(pi*0.5 * rotate)
                      ..translate(0.0, translate, 0.0),
                    child: SizedBox(
                        height: widget.scrollDirection == Axis.vertical
                            ? lerpDouble(widget.itemExtent, maxSize,
                                interpolation > 1 ? 1 : interpolation)
                            : height - activePos,
                        width: widget.scrollDirection == Axis.horizontal
                            ? lerpDouble(widget.itemExtent, maxSize,
                                interpolation > 1 ? 1 : interpolation)
                            : null,
                        child: widget.itemBuilder(
                            context, index, interpolation, maxSize)),
                  ),
                );
              });
          // }
          // return SizedBox(
          //     height: widget.scrollDirection == Axis.vertical
          //         ? lerpDouble(widget.itemExtent, maxSize,
          //             currItem > index + 1.0 ? 1 : 0)
          //         : null,
          //     width: widget.scrollDirection == Axis.horizontal
          //         ? lerpDouble(widget.itemExtent, maxSize,
          //             currItem > index + 1.0 ? 1 : 0)
          //         : null,
          //     child: widget.itemBuilder(
          //         context, index, currItem > (index + 1.0) ? 2 : 0, maxSize));
        },
        itemCount: widget.itemCount + 1,
        physics: dummy == DummyChangePhysics.H
            ? DummyHScrollPhysics(
                mainAxisStartPadding: startPadding + defaultPadding,
                itemExtent: maxSize,
              )
            : DummyVScrollPhysics(
                mainAxisStartPadding: startPadding + defaultPadding,
                itemExtent: maxSize,
              ),
        padding: widget.padding.copyWith(
            left: startPadding, right: startPadding, bottom: activePos));
  }
}
