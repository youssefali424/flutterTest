// import 'package:flutter/material.dart';
// import 'package:hospitals/views/Route/NamedRoute.dart';
// import 'package:hospitals/views/Route/RouteType.dart';
// import 'package:hospitals/views/Route/StackRoute.dart';
// import 'package:hospitals/views/Route/TabRoute.dart';

// mixin BaseNavigator {
//   final List<String> routeState = [];
//   Widget? getCurrentRoute<T extends NamedRoute>(NamedRoute route) {
//     switch (route.type) {
//       case RouteType.NAVIGATOR:
//         return route as Widget;
//       case RouteType.STACK:
//         if (route.runtimeType == StackRoute) {
//           if ((route as StackRoute).screen is NamedRoute) {
//             return getCurrentRoute(route.screen as NamedRoute);
//           }
//           return route.screen;
//         } else
//           throw Exception('Invalid route type: ${route.runtimeType}');
//       case RouteType.Tab:
//         if (route.runtimeType == TabRoute) {
//           if ((route as TabRoute).screen is NamedRoute) {
//             return getCurrentRoute(route.screen as NamedRoute);
//           }
//           return route.screen;
//         } else
//           throw Exception('Invalid route type: ${route.runtimeType}');
//       default:
//         return Container();
//     }
//   }
// }
