// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import "package:flutter/widgets.dart";
// import "dart:math";

// import 'package:hospitals/views/test/interpolate.dart';

// typedef Builder = Widget Function(
//     BuildContext context, int index, double progress, double maxHeight);

// class SnappingListView extends StatefulWidget {
//   final Axis scrollDirection;
//   final ScrollController controller;

//   final Builder itemBuilder;
//   // final List<Widget> children;
//   final int itemCount;

//   final double itemExtent;
//   final double maxExtent;
//   final ValueChanged<int> onItemChanged;

//   final EdgeInsets padding;

//   // SnappingListView(
//   //     {this.scrollDirection,
//   //     this.controller,
//   //     @required this.children,
//   //     @required this.itemExtent,
//   //     this.onItemChanged,
//   //     this.padding = const EdgeInsets.all(0.0)})
//   //     : assert(itemExtent > 0),
//   //       itemCount = null,
//   //       itemBuilder = null;

//   SnappingListView.builder(
//       {this.scrollDirection,
//       this.controller,
//       @required this.itemBuilder,
//       this.itemCount,
//       @required this.itemExtent,
//       this.onItemChanged,
//       this.padding = const EdgeInsets.only(top: 0),
//       @required this.maxExtent})
//       : assert(itemExtent != null && itemExtent > 0),
//         assert(maxExtent != null && maxExtent > 0),
//         assert(maxExtent > itemExtent);
//   // children = null;

//   @override
//   createState() => _SnappingListViewState();
// }

// class _SnappingListViewState extends State<SnappingListView>
//     with WidgetsBindingObserver {
//   int _lastItem = 0;
//   double position = 0.0;
//   double defaultPadding = 0;
//   StreamController<double> currentPositionStream;
//   DummyChangePhysics dummy = DummyChangePhysics.H;
//   Orientation currentOrientation;
//   Size currSize;
//   ScrollController controller;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     currentPositionStream = StreamController.broadcast()..add(position);
//     WidgetsBinding.instance.addObserver(this);
//     currSize = window.physicalSize;
//     controller = ScrollController();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     currentPositionStream.close();
//     super.dispose();
//   }

//   didChangeMetrics() {
//     print("change dummy " + window.physicalSize.toString());
//     if (currSize.width != window.physicalSize.width ||
//         currSize.height != window.physicalSize.height) {
//       setState(() {
//         dummy = (dummy == DummyChangePhysics.H
//             ? DummyChangePhysics.L
//             : DummyChangePhysics.H);
//       });
//       final startPadding = widget.scrollDirection == Axis.horizontal
//           ? widget.padding.left
//           : widget.padding.top;
//       controller.jumpTo(startPadding + defaultPadding);
//     }
//   }

//   didUpdateWidget(oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.maxExtent != widget.maxExtent) {
//       dummy = (dummy == DummyChangePhysics.H
//           ? DummyChangePhysics.L
//           : DummyChangePhysics.H);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final startPadding = widget.scrollDirection == Axis.horizontal
//         ? widget.padding.left
//         : widget.padding.top;
//     return OrientationBuilder(builder: (_, orientation) {
//       // print("build");
//       return LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//         var maxSize = min(
//             widget.scrollDirection == Axis.vertical
//                 ? constraints.maxHeight
//                 : constraints.maxWidth,
//             widget.maxExtent);
//         var remain = 0.0;
//         if ((widget.scrollDirection == Axis.vertical &&
//                 !constraints.hasInfiniteHeight) ||
//             (widget.scrollDirection == Axis.horizontal &&
//                 !constraints.hasInfiniteWidth)) {
//           remain = (widget.scrollDirection == Axis.vertical
//                   ? constraints.maxHeight
//                   : constraints.maxWidth) -
//               maxSize;
//         }
//         return NotificationListener<ScrollNotification>(
//             child: _buildList(startPadding, maxSize, remain, orientation),
//             onNotification: (notif) {
//               if (notif.depth == 0 && notif is ScrollUpdateNotification) {
//                 final currPosition =
//                     (notif.metrics.pixels - startPadding - defaultPadding) /
//                         maxSize;
//                 final currItem = currPosition.truncate();
//                 if (currItem != _lastItem) {
//                   setState(() {
//                     _lastItem = currItem;
//                   });
//                   widget.onItemChanged?.call(currItem);
//                 }
//                 position = currPosition;
//                 currentPositionStream.add(currPosition);
//               }
//               return false;
//             });
//       });
//     });
//   }

//   _buildList(double startPadding, double maxSize, double remain,
//       Orientation orientation) {
//     // print("orientation " + orientation.toString());
//     // if (currentOrientation != null && currentOrientation != orientation) {
//     //   dummy = (dummy == DummyChangePhysics.H
//     //       ? DummyChangePhysics.L
//     //       : DummyChangePhysics.H);
//     //   currentOrientation = orientation;
//     //   print("dummy " + dummy.toString());
//     // }
//     print("dummy " + dummy.toString());
//     return ListView.builder(
//         scrollDirection: widget.scrollDirection,
//         controller: controller,
//         itemBuilder: (context, index) {
//           if (index > widget.itemCount - 1) {
//             if (remain < 0) {
//               return Container();
//             }
//             return Container(
//               height: remain,
//             );
//           }

//           var currItem = _lastItem;
//           if (currItem >= index - 1.0 && currItem <= index + 1.0) {
//             return StreamBuilder(
//                 stream: currentPositionStream.stream,
//                 builder: (context, snapshot) {
//                   var currPos = snapshot.hasData ? snapshot.data : position;
//                   var interpolation = interpolate(
//                       currPos,
//                       InterpolateConfig([
//                         (index - 1.0),
//                         (index + 0.0),
//                         index + 1.0
//                       ], [
//                         0,
//                         1,
//                         2,
//                       ], extrapolate: Extrapolate.CLAMP));
//                   return SizedBox(
//                       height: widget.scrollDirection == Axis.vertical
//                           ? lerpDouble(widget.itemExtent, maxSize,
//                               interpolation > 1 ? 1 : interpolation)
//                           : null,
//                       width: widget.scrollDirection == Axis.horizontal
//                           ? lerpDouble(widget.itemExtent, maxSize,
//                               interpolation > 1 ? 1 : interpolation)
//                           : null,
//                       child: widget.itemBuilder(
//                           context, index, interpolation, maxSize));
//                 });
//           }
//           return SizedBox(
//               height: widget.scrollDirection == Axis.vertical
//                   ? lerpDouble(widget.itemExtent, maxSize,
//                       currItem > index + 1.0 ? 1 : 0)
//                   : null,
//               width: widget.scrollDirection == Axis.horizontal
//                   ? lerpDouble(widget.itemExtent, maxSize,
//                       currItem > index + 1.0 ? 1 : 0)
//                   : null,
//               child: widget.itemBuilder(
//                   context, index, currItem > (index + 1.0) ? 2 : 0, maxSize));
//         },
//         itemCount: widget.itemCount + 1,
//         physics: dummy == DummyChangePhysics.H
//             ? DummyHScrollPhysics(
//                 mainAxisStartPadding: startPadding + defaultPadding,
//                 itemExtent: maxSize)
//             : DummyVScrollPhysics(
//                 mainAxisStartPadding: startPadding + defaultPadding,
//                 itemExtent: maxSize),
//         padding: widget.padding);
//   }
// }

// // class CustomScroll extends ScrollController {
// // @override

// // }

// enum DummyChangePhysics { L, H }

// class DummyHScrollPhysics extends ScrollPhysics {
//   final double mainAxisStartPadding;
//   final double itemExtent;

//   const DummyHScrollPhysics({
//     ScrollPhysics parent,
//     this.mainAxisStartPadding = 0.0,
//     @required this.itemExtent,
//   }) : super(
//           parent: parent,
//         );
//   @override
//   DummyHScrollPhysics applyTo(ScrollPhysics ancestor) {
//     print("applyTo " + itemExtent.toString());
//     return DummyHScrollPhysics(
//       parent: buildParent(ancestor),
//       mainAxisStartPadding: mainAxisStartPadding,
//       itemExtent: itemExtent,
//     );
//   }

//   double _getItem(ScrollPosition position) {
//     return ((position.pixels - mainAxisStartPadding) / itemExtent);
//   }

//   double _getPixels(ScrollPosition position, double item) {
//     return min(item * itemExtent, position.maxScrollExtent);
//   }

//   double _getTargetPixels(
//       ScrollPosition position, Tolerance tolerance, double velocity) {
//     double item = _getItem(position);
//     // print(item.toString() + " item before");
//     if (velocity < -tolerance.velocity)
//       item -= 0.5;
//     else if (velocity > tolerance.velocity) item += 0.5;
//     // print(item.toString() + " item");
//     return _getPixels(position, item.roundToDouble());
//   }

//   @override
//   Simulation createBallisticSimulation(
//       ScrollMetrics position, double velocity) {
//     // If we're out of range and not headed back in range, defer to the parent
//     // ballistics, which should put us back in range at a page boundary.
//     if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//         (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//       return super.createBallisticSimulation(position, velocity);
//     final Tolerance tolerance = this.tolerance;
//     final double target = _getTargetPixels(position, tolerance, velocity);
//     if (target != position.pixels)
//       return ScrollSpringSimulation(spring, position.pixels, target, velocity,
//           tolerance: tolerance);
//     return null;
//   }

//   @override
//   bool get allowImplicitScrolling => false;
// }

// class DummyVScrollPhysics extends ScrollPhysics {
//   final double mainAxisStartPadding;
//   final double itemExtent;

//   const DummyVScrollPhysics({
//     ScrollPhysics parent,
//     this.mainAxisStartPadding = 0.0,
//     @required this.itemExtent,
//   }) : super(
//           parent: parent,
//         );
//   @override
//   DummyVScrollPhysics applyTo(ScrollPhysics ancestor) {
//     return DummyVScrollPhysics(
//       parent: buildParent(ancestor),
//       mainAxisStartPadding: mainAxisStartPadding,
//       itemExtent: itemExtent,
//     );
//   }

//   double _getItem(ScrollPosition position) {
//     return ((position.pixels - mainAxisStartPadding) / itemExtent);
//   }

//   double _getPixels(ScrollPosition position, double item) {
//     return min(item * itemExtent, position.maxScrollExtent);
//   }

//   double _getTargetPixels(
//       ScrollPosition position, Tolerance tolerance, double velocity) {
//     double item = _getItem(position);
//     // print(item.toString() + " item before");
//     if (velocity < -tolerance.velocity)
//       item -= 0.5;
//     else if (velocity > tolerance.velocity) item += 0.5;
//     // print(item.toString() + " item");
//     return _getPixels(position, item.roundToDouble());
//   }

//   @override
//   Simulation createBallisticSimulation(
//       ScrollMetrics position, double velocity) {
//     // If we're out of range and not headed back in range, defer to the parent
//     // ballistics, which should put us back in range at a page boundary.
//     if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//         (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//       return super.createBallisticSimulation(position, velocity);
//     final Tolerance tolerance = this.tolerance;
//     final double target = _getTargetPixels(position, tolerance, velocity);
//     if (target != position.pixels)
//       return ScrollSpringSimulation(spring, position.pixels, target, velocity,
//           tolerance: tolerance);
//     return null;
//   }

//   @override
//   bool get allowImplicitScrolling => false;
// }

// // mixin SnappingListScrollPhysics {
// //   final double mainAxisStartPadding;
// //   final double itemExtent;

// //   // const SnappingListScrollPhysics({
// //   //   ScrollPhysics parent,
// //   //   this.mainAxisStartPadding = 0.0,
// //   //   @required this.itemExtent,
// //   // });

// //   double _getItem(ScrollPosition position) {
// //     return ((position.pixels - mainAxisStartPadding) / itemExtent);
// //   }

// //   double _getPixels(ScrollPosition position, double item) {
// //     return min(item * itemExtent, position.maxScrollExtent);
// //   }

// //   double _getTargetPixels(
// //       ScrollPosition position, Tolerance tolerance, double velocity) {
// //     double item = _getItem(position);
// //     // print(item.toString() + " item before");
// //     if (velocity < -tolerance.velocity)
// //       item -= 0.5;
// //     else if (velocity > tolerance.velocity) item += 0.5;
// //     // print(item.toString() + " item");
// //     return _getPixels(position, item.roundToDouble());
// //   }
// // }
