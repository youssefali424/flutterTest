// import 'package:flutter/material.dart';
// import 'package:hospitals/util/colorUtil.dart';
// import 'package:hospitals/views/photoViewer/PhotoViewer_screen.dart';

// class PhotoViewerPage extends StatefulWidget {
//   static const String routeName = '/photoViewer';

//   @override
//   _PhotoViewerPageState createState() => _PhotoViewerPageState();
// }

// class _PhotoViewerPageState extends State<PhotoViewerPage> {
//   @override
//   Widget build(BuildContext context) {
//     final String url = ModalRoute.of(context).settings.arguments as String;
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text('PhotoViewer'),
//         // ),
//         body: Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//               colors: [hexToColor('#005C97'), hexToColor('#363795')])),
//       child: PhotoViewerScreen(url),
//     ));
//   }
// }
