// import 'dart:developer';
// import 'dart:math' as Math;
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:hospitals/views/test/CustomAnimation.dart';
// import 'package:hospitals/views/test/InterpolationTransition.dart';
// import 'package:hospitals/views/test/TransformTransition.dart';
// import 'package:hospitals/views/test/interpolate.dart';
// import 'package:rect_getter/rect_getter.dart';
// // import 'package:getwidget/getwidget.dart';

// class Accordion extends StatefulWidget {
//   /// An accordion is used to show (and hide) content. Use [showAccordion] to hide & show the accordion content.
//   const Accordion(
//       {Key key,
//       this.titleChild,
//       this.content,
//       this.collapsedTitleBackgroundColor = Colors.white,
//       this.expandedTitleBackgroundColor = Colors.white,
//       this.collapsedIcon = const Icon(Icons.keyboard_arrow_down),
//       this.expandedIcon = const Icon(Icons.keyboard_arrow_up),
//       this.title,
//       this.textStyle = const TextStyle(color: Colors.black, fontSize: 16),
//       this.titlePadding = const EdgeInsets.all(10),
//       this.contentBackgroundColor,
//       this.contentPadding = const EdgeInsets.all(10),
//       this.contentChild,
//       this.titleBorder = const Border(),
//       this.contentBorder = const Border(),
//       this.margin,
//       this.showAccordion = false,
//       this.onToggleCollapsed,
//       this.titleBorderRadius = const BorderRadius.all(Radius.circular(10)),
//       this.contentBorderRadius = const BorderRadius.all(Radius.circular(0))})
//       : super(key: key);

//   /// controls if the accordion should be collapsed or not making it possible to be controlled from outside
//   final bool showAccordion;

//   /// child of  type [Widget]is alternative to title key. title will get priority over titleChild
//   final Widget titleChild;

//   /// content of type[String] which shows the messages after the [GFAccordion] is expanded
//   final String content;

//   /// contentChild of  type [Widget]is alternative to content key. content will get priority over contentChild
//   final Widget contentChild;

//   /// type of [Color] or [GFColors] which is used to change the background color of the [GFAccordion] title when it is collapsed
//   final Color collapsedTitleBackgroundColor;

//   /// type of [Color] or [GFColors] which is used to change the background color of the [GFAccordion] title when it is expanded
//   final Color expandedTitleBackgroundColor;

//   /// collapsedIcon of type [Widget] which is used to show when the [GFAccordion] is collapsed
//   final Widget collapsedIcon;

//   /// expandedIcon of type[Widget] which is used when the [GFAccordion] is expanded
//   final Widget expandedIcon;

//   /// text of type [String] is alternative to child. text will get priority over titleChild
//   final String title;

//   /// textStyle of type [textStyle] will be applicable to text only and not for the child
//   final TextStyle textStyle;

//   /// titlePadding of type [EdgeInsets] which is used to set the padding of the [GFAccordion] title
//   final EdgeInsets titlePadding;

//   /// descriptionPadding of type [EdgeInsets] which is used to set the padding of the [GFAccordion] description
//   final EdgeInsets contentPadding;

//   /// type of [Color] or [GFColors] which is used to change the background color of the [GFAccordion] description
//   final Color contentBackgroundColor;

//   /// margin of type [EdgeInsets] which is used to set the margin of the [GFAccordion]
//   final EdgeInsets margin;

//   /// titleBorderColor of type  [Color] or [GFColors] which is used to change the border color of title
//   final Border titleBorder;

//   /// contentBorderColor of type  [Color] or [GFColors] which is used to change the border color of content
//   final Border contentBorder;

//   /// titleBorderRadius of type  [Radius]  which is used to change the border radius of title
//   final BorderRadius titleBorderRadius;

//   /// contentBorderRadius of type  [Radius]  which is used to change the border radius of content
//   final BorderRadius contentBorderRadius;

//   /// function called when the content body collapsed
//   final Function(bool) onToggleCollapsed;

//   @override
//   _GFAccordionState createState() => _GFAccordionState();
// }

// const duration = Duration(seconds: 1);

// class _GFAccordionState extends State<Accordion> with TickerProviderStateMixin {
//   AnimationController animationController;
//   AnimationController controller;
//   Animation<Offset> offset;
//   bool showAccordion;
//   var globalKey = RectGetter.createGlobalKey();
//   double childHeight = 0;
//   @override
//   void initState() {
//     showAccordion = widget.showAccordion;
//     animationController = AnimationController(duration: duration, vsync: this);
//     controller = AnimationController(duration: duration, vsync: this);
//     offset = Tween(
//       begin: const Offset(0, -0.3),
//       end: const Offset(0, 58),
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Curves.fastOutSlowIn,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var rectGetter = Positioned(
//         // top: 58,
//         child: InterpolationTransition(
//             animation: offset,
//             buildChild: (context, value) {
//               return AnimatedOpacity(
//                   duration: Duration(
//                       milliseconds: (duration.inMilliseconds / 4).ceil()),
//                   opacity: value,
//                   child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: widget.contentBorderRadius,
//                         border: widget.contentBorder,
//                         color: widget.contentBackgroundColor ?? Colors.white70,
//                       ),
//                       width: MediaQuery.of(context).size.width,
//                       // padding: widget.contentPadding,
//                       child: SlideTransition(
//                         position: offset,
//                         child: RectGetter(
//                           key: globalKey,
//                           child: widget.content != null
//                               ? Text(widget.content)
//                               : (widget.contentChild ?? Container()),
//                         ),
//                       )));
//             },
//             interpolateConfig: InterpolateConfig([-0.1, 0], [0, 1],
//                 extrapolate: Extrapolate.CLAMP),
//             transformFuntion: (offset) => (offset as Offset).dy));

//     print(childHeight);
//     return AnimatedContainer(
//       margin: widget.margin ?? const EdgeInsets.all(10),
//       height: showAccordion ? childHeight + 58 : 58,
//       color: Colors.red,
//       duration: duration,
//       child: OverflowBox(
//         child: Stack(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             rectGetter,
//             Card(
//                 elevation: 10,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: widget.titleBorderRadius),
//                 child: InkWell(
//                   onTap: _toggleCollapsed,
//                   child: AnimatedContainer(
//                     duration: duration,
//                     decoration: BoxDecoration(
//                       borderRadius: widget.titleBorderRadius,
//                       border: widget.titleBorder,
//                       color: showAccordion
//                           ? widget.expandedTitleBackgroundColor
//                           : widget.collapsedTitleBackgroundColor,
//                     ),
//                     padding: widget.titlePadding,
//                     height: 50,
//                     // transform: Matrix4.identity()..translate(0.0, 0, 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Expanded(
//                           child: widget.title != null
//                               ? Text(widget.title, style: widget.textStyle)
//                               : (widget.titleChild ?? Container()),
//                         ),
//                         // showAccordion ? widget.expandedIcon : widget.collapsedIcon,
//                         RotationTransition(
//                           turns: CustomAnimation<Offset, double>(
//                               offset,
//                               (offset) => interpolate(
//                                   offset.value.dy,
//                                   InterpolateConfig([-0.2, 0], [0, 0.5],
//                                       extrapolate: Extrapolate.CLAMP))),
//                           // child: Icon(Icons.keyboard_arrow_up),
//                           child: ImageFiltered(imageFilter: ImageFilter.blur(),),
//                         ),
//                         // TransformTransition(
//                         //   buildChild: (context, double value, child) {
//                         //     return Transform.rotate(
//                         //       angle: value,
//                         //       child: Icon(Icons.keyboard_arrow_up),
//                         //     );
//                         //   },
//                         //   turns: offset,
//                         //   transformFuntion: (Offset offset) {
//                         //     // log("offset " + offset.dy.toString());
//                         //     // log(interpolate(offset.dy,
//                         //     //         InterpolateConfig([-1, 0], [0, Math.pi]))
//                         //     //     .toString());
//                         //     return interpolate(
//                         //         offset.dy,
//                         //         InterpolateConfig([-0.2, 0], [0, Math.pi],
//                         //             extrapolate: Extrapolate.CLAMP));
//                         //   },
//                         // )
//                       ],
//                     ),
//                   ),
//                 )),

//             // showAccordion
//             //     ? Container(
//             //         decoration: BoxDecoration(
//             //           borderRadius: widget.contentBorderRadius,
//             //           border: widget.contentBorder,
//             //           color: widget.contentBackgroundColor ?? Colors.white70,
//             //         ),
//             //         width: MediaQuery.of(context).size.width,
//             //         padding: widget.contentPadding,
//             //         child: SlideTransition(
//             //           position: offset,
//             //           child: widget.content != null
//             //               ? Text(widget.content)
//             //               : (widget.contentChild ?? Container()),
//             //         ))
//             //     : Container()
//           ],
//         ),
//       ),
//     );
//   }

//   void _toggleCollapsed() {
//     setState(() {
//       Rect rect = RectGetter.getRectFromKey(globalKey);
//       childHeight = rect.height;
//       showAccordion ? controller.reverse() : controller.forward();
//       // switch (controller.status) {
//       //   case AnimationStatus.completed:
//       //     showAccordion
//       //         ? controller.reverse(from: 1)
//       //         : controller.forward(from: 0);
//       //     break;
//       //   case AnimationStatus.dismissed:
//       //     showAccordion ? controller.reverse() : controller.forward();
//       //     break;
//       //   default:
//       // }
//       showAccordion = !showAccordion;
//       if (widget.onToggleCollapsed != null) {
//         widget.onToggleCollapsed(showAccordion);
//       }
//     });
//   }
// }
