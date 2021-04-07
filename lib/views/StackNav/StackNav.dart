// import 'package:flutter/material.dart';
// import 'package:hospitals/views/BaseNavigator/BaseNavigator.dart';
// import 'package:hospitals/views/Route/NamedRoute.dart';

// class StackNav extends StatelessWidget with BaseNavigator {
//   final String? initialRoute;
//   final List<NamedRoute>? routes;
//   StackNav({this.initialRoute, this.routes});



//   @override
//   Widget build(BuildContext context) {
//     // SignUpPage builds its own Navigator which ends up being a nested
//     // Navigator in our app.
//     return Navigator(
//       initialRoute: initialRoute,
//       onGenerateRoute: (RouteSettings settings) {
//         WidgetBuilder builder;
//         var route = routes?.firstWhere((e) => e.name == settings.name);
//         if (route != null) {
//           builder = (BuildContext _) => getCurrentRoute(route);
//         } else {
//           throw Exception('Invalid route: ${settings.name}');
//         }
//         return MaterialPageRoute(builder: builder, settings: settings);
//       },
//     );
//   }
// }
