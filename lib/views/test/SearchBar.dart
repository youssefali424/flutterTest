// // import 'package:alagamy_institute/ui/library/widgets/TransformTransition.dart';
// import 'dart:math';
// import 'dart:ui';

// import 'package:alagamy_institute/utilities/AppLocalizations.dart';
// import 'package:alagamy_institute/utilities/FontsManager.dart';
// import 'package:alagamy_institute/utilities/LocalSettings.dart';
// import 'package:alagamy_institute/utilities/app_colors.dart';
// import 'package:flutter/material.dart';

// typedef OnSearch = Function(String search);

// class SearchBar extends StatefulWidget {
//   final OnSearch onSearch;
//   final String header;
//   SearchBar({Key key, this.onSearch, this.header}) : super(key: key);

//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> animation;
//   bool opened;
//   FocusNode focusNode;
//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     animation = controller.drive(
//       Tween<double>(
//         begin: 0,
//         end: 1,
//       ),
//     );
//     opened = false;
//     focusNode = FocusNode();
//   }

//   openSearch() {
//     if (!opened) {
//       controller.forward().whenComplete(() => focusNode.requestFocus());
//     }
//     setState(() {
//       opened = true;
//     });
//   }

//   closeSearch() {
//     if (opened) {
//       controller.reverse();
//     }
//     focusNode.unfocus();
//     setState(() {
//       opened = false;
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context);
//     var mainColor = Color.fromRGBO(170, 6, 57, 1);
//     return Container(
//       child: Card(
//           elevation: 10,
//           margin: const EdgeInsets.all(0.0),
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 500),
//             decoration: BoxDecoration(
//                 color: opened ? Color.fromRGBO(120, 0, 46, 1) : Colors.white),
//             height: 72,
//             // width: MediaQuery.of(context).size.width,
//             alignment: Alignment.center,
//             child: Stack(
//               // fit: StackFit.expand,
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: 70,
//                   width: mediaQuery.size.width - 65,
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: AnimatedBuilder(
//                       animation: animation,
//                       builder: (context, child) {
//                         return Opacity(
//                           child: child,
//                           opacity: 1 - animation.value,
//                         );
//                       },
//                       child: Text(
//                         widget.header ?? "",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 25,
//                             fontFamily: FontsManager.getBahijFont(),
//                             fontWeight: FontWeight.bold,
//                             color: mainColor,
//                             decoration: TextDecoration.none),
//                       ),
//                     ),
//                   ),
//                 ),
//                 AnimatedBuilder(
//                   builder: (context, child) {
//                     return Transform(
//                       transform: Matrix4.identity()
//                         // ..scale(animation.value, animation.value, 1.0)
//                         ..translate((LocalSettings.appLocale == "en" ? -1 : 1) *
//                             mediaQuery.size.width *
//                             (1 - animation.value)),
//                       alignment: AlignmentDirectional.centerStart,
//                       child: child,
//                     );
//                   },
//                   animation: animation,
//                   child: Container(
//                     // constraints: BoxConstraints(maxHeight: 45),
//                     width: mediaQuery.size.width,
//                     height: 55,
//                     decoration: BoxDecoration(
//                         color: AppColors.TEXTFEILD_COLOR,
//                         borderRadius: BorderRadius.circular(10)),
//                     padding: EdgeInsetsDirectional.only(
//                       start: 50,
//                     ),
//                     margin: EdgeInsetsDirectional.only(end: 50, start: 15),
//                     child: TextField(
//                       focusNode: focusNode,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           labelText: AppLocalizations.of(context).search,
//                           labelStyle: TextStyle(
//                               color: Color.fromRGBO(102, 102, 102, 1))),
//                       style: TextStyle(color: Colors.black),
//                       cursorColor: Color.fromRGBO(102, 102, 102, 0.5),
//                       onSubmitted: widget.onSearch,
//                       enabled: opened,
//                     ),
//                   ),
//                 ),
//                 AnimatedBuilder(
//                   animation: animation,
//                   builder: (context, child) {
//                     return PositionedDirectional(
//                         start: lerpDouble(10, 25,
//                             max(0, (animation.value - 0.9) / (1 - 0.9))),
//                         child: InkWell(
//                             onTap: opened ? null : openSearch,
//                             enableFeedback: false,
//                             child: Icon(
//                               Icons.search,
//                               color: Color.lerp(
//                                   Color.fromRGBO(102, 102, 102, 1),
//                                   mainColor,
//                                   animation.value),
//                               // color: Colors.white70,
//                               size: 30,
//                             )));
//                   },
//                 ),
//                 PositionedDirectional(
//                     end: 8,
//                     child: InkWell(
//                         onTap: opened ? closeSearch : null,
//                         child: FadeTransition(
//                             child: Icon(
//                               Icons.close,
//                               color: Colors.white,
//                               size: 35,
//                             ),
//                             opacity: animation))),
//               ],
//             ),
//           )),
//     );
//   }
// }
