// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:hospitals/views/BaseNavigator/BaseNavigator.dart';
// import 'package:hospitals/views/Route/NamedRoute.dart';
// import 'package:hospitals/views/Route/TabRoute.dart';
// import 'Tabbar.dart' as CustomTabbar;

// class TabBarNavigator extends StatefulWidget {
//   final List<TabRoute>? routes;

//   TabBarNavigator({
//     Key? key,
//     @required this.routes,
//     this.isScrollable = false,
//     this.indicatorColor,
//     this.indicatorWeight = 2.0,
//     this.indicatorPadding = EdgeInsets.zero,
//     this.indicator,
//     this.indicatorSize,
//     this.labelColor,
//     this.labelStyle,
//     this.labelPadding,
//     this.unselectedLabelColor,
//     this.unselectedLabelStyle,
//     this.dragStartBehavior = DragStartBehavior.start,
//     this.mouseCursor,
//     this.onTap,
//     this.physics,
//     this.isIndicatorAtBottom,
//     this.intialIndex = 0,
//   })  : assert(routes != null),
//         super(key: key);

//   /// intial choosen tab
//   final int intialIndex;

//   final bool isScrollable;

//   /// if tab indicator is at the bottom
//   final bool? isIndicatorAtBottom;

//   /// The color of the line that appears below the selected tab.
//   ///
//   /// If this parameter is null, then the value of the Theme's indicatorColor
//   /// property is used.
//   ///
//   /// If [indicator] is specified or provided from [TabBarTheme],
//   /// this property is ignored.
//   final Color? indicatorColor;

//   /// The thickness of the line that appears below the selected tab.
//   ///
//   /// The value of this parameter must be greater than zero and its default
//   /// value is 2.0.
//   ///
//   /// If [indicator] is specified or provided from [TabBarTheme],
//   /// this property is ignored.
//   final double indicatorWeight;

//   /// The horizontal padding for the line that appears below the selected tab.
//   ///
//   /// For [isScrollable] tab bars, specifying [kTabLabelPadding] will align
//   /// the indicator with the tab's text for [Tab] widgets and all but the
//   /// shortest [Tab.text] values.
//   ///
//   /// The [EdgeInsets.top] and [EdgeInsets.bottom] values of the
//   /// [indicatorPadding] are ignored.
//   ///
//   /// The default value of [indicatorPadding] is [EdgeInsets.zero].
//   ///
//   /// If [indicator] is specified or provided from [TabBarTheme],
//   /// this property is ignored.
//   final EdgeInsetsGeometry indicatorPadding;

//   /// Defines the appearance of the selected tab indicator.
//   ///
//   /// If [indicator] is specified or provided from [TabBarTheme],
//   /// the [indicatorColor], [indicatorWeight], and [indicatorPadding]
//   /// properties are ignored.
//   ///
//   /// The default, underline-style, selected tab indicator can be defined with
//   /// [UnderlineTabIndicator].
//   ///
//   /// The indicator's size is based on the tab's bounds. If [indicatorSize]
//   /// is [TabBarIndicatorSize.tab] the tab's bounds are as wide as the space
//   /// occupied by the tab in the tab bar. If [indicatorSize] is
//   /// [TabBarIndicatorSize.label], then the tab's bounds are only as wide as
//   /// the tab widget itself.
//   final Decoration? indicator;

//   /// Defines how the selected tab indicator's size is computed.
//   ///
//   /// The size of the selected tab indicator is defined relative to the
//   /// tab's overall bounds if [indicatorSize] is [TabBarIndicatorSize.tab]
//   /// (the default) or relative to the bounds of the tab's widget if
//   /// [indicatorSize] is [TabBarIndicatorSize.label].
//   ///
//   /// The selected tab's location appearance can be refined further with
//   /// the [indicatorColor], [indicatorWeight], [indicatorPadding], and
//   /// [indicator] properties.
//   final TabBarIndicatorSize? indicatorSize;

//   /// The color of selected tab labels.
//   ///
//   /// Unselected tab labels are rendered with the same color rendered at 70%
//   /// opacity unless [unselectedLabelColor] is non-null.
//   ///
//   /// If this parameter is null, then the color of the [ThemeData.primaryTextTheme]'s
//   /// bodyText1 text color is used.
//   final Color? labelColor;

//   /// The color of unselected tab labels.
//   ///
//   /// If this property is null, unselected tab labels are rendered with the
//   /// [labelColor] with 70% opacity.
//   final Color? unselectedLabelColor;

//   /// The text style of the selected tab labels.
//   ///
//   /// If [unselectedLabelStyle] is null, then this text style will be used for
//   /// both selected and unselected label styles.
//   ///
//   /// If this property is null, then the text style of the
//   /// [ThemeData.primaryTextTheme]'s bodyText1 definition is used.
//   final TextStyle? labelStyle;

//   /// The padding added to each of the tab labels.
//   ///
//   /// If this property is null, then kTabLabelPadding is used.
//   final EdgeInsetsGeometry? labelPadding;

//   /// The text style of the unselected tab labels.
//   ///
//   /// If this property is null, then the [labelStyle] value is used. If [labelStyle]
//   /// is null, then the text style of the [ThemeData.primaryTextTheme]'s
//   /// bodyText1 definition is used.
//   final TextStyle? unselectedLabelStyle;

//   /// {@macro flutter.widgets.scrollable.dragStartBehavior}
//   final DragStartBehavior dragStartBehavior;

//   /// The cursor for a mouse pointer when it enters or is hovering over the
//   /// individual tab widgets.
//   ///
//   /// If this property is null, [SystemMouseCursors.click] will be used.
//   final MouseCursor? mouseCursor;

//   /// An optional callback that's called when the [TabBar] is tapped.
//   ///
//   /// The callback is applied to the index of the tab where the tap occurred.
//   ///
//   /// This callback has no effect on the default handling of taps. It's for
//   /// applications that want to do a little extra work when a tab is tapped,
//   /// even if the tap doesn't change the TabController's index. TabBar [onTap]
//   /// callbacks should not make changes to the TabController since that would
//   /// interfere with the default tap handler.
//   final ValueChanged<int>? onTap;

//   /// How the [TabBar]'s scroll view should respond to user input.
//   ///
//   /// For example, determines how the scroll view continues to animate after the
//   /// user stops dragging the scroll view.
//   ///
//   /// Defaults to matching platform conventions.
//   final ScrollPhysics? physics;

//   @override
//   _TabBarNavigatorState createState() => _TabBarNavigatorState();
// }

// class _TabBarNavigatorState extends State<TabBarNavigator>
//     with SingleTickerProviderStateMixin<TabBarNavigator>, BaseNavigator {
//   TabController? defaultTabController;

//   @override
//   void initState() {
//     super.initState();
//     defaultTabController = TabController(
//         length: widget.routes?.length ?? 0,
//         initialIndex: widget.intialIndex,
//         vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget?>? screens = widget.routes?.map((e) => getCurrentRoute(e)).toList();
//     List<Tab>? tabs = widget.routes?.map((e) => e.tab).toList();
//     return SafeArea(
//       maintainBottomViewPadding: true,
//       bottom: true,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Test'),
//         ),
//         body: SafeArea(
//           bottom: true,
//           child: TabBarView(
//             controller: defaultTabController,
//             children: screens,
//           ),
//         ),
//         // BottomNavigationBar
//         bottomNavigationBar: Semantics(
//           explicitChildNodes: true,
//           child: Container(
//             color: Color(0xFF8B9CCA),
//             child: CustomTabbar.TabBar(
//               controller: defaultTabController,
//               tabs: tabs, //current tabs
//               isScrollable: widget.isScrollable,
//               indicatorColor: widget.indicatorColor,
//               indicatorWeight: widget.indicatorWeight,
//               indicatorPadding: widget.indicatorPadding,
//               indicator: widget.indicator,
//               indicatorSize: widget.indicatorSize,
//               labelColor: widget.labelColor,
//               labelStyle: widget.labelStyle,
//               labelPadding: widget.labelPadding,
//               unselectedLabelColor: widget.unselectedLabelColor,
//               unselectedLabelStyle: widget.unselectedLabelStyle,
//               dragStartBehavior: widget.dragStartBehavior,
//               mouseCursor: widget.mouseCursor,
//               onTap: widget.onTap,
//               physics: widget.physics,
//               isIndicatorAtBottom: widget.isIndicatorAtBottom,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
