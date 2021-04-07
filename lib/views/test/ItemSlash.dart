// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// class TrianglePainter extends CustomPainter {
//   final Color strokeColor;
//   final PaintingStyle paintingStyle;
//   final double strokeWidth;

//   TrianglePainter(
//       {this.strokeColor = Colors.black,
//       this.strokeWidth = 3,
//       this.paintingStyle = PaintingStyle.stroke});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = strokeColor
//       ..strokeWidth = strokeWidth
//       ..style = paintingStyle;

//     canvas.drawPath(getTrianglePath(size.width, size.height), paint);
//   }

//   Path getTrianglePath(double width, double height) {
//     return Path()
//       ..moveTo(0, 0)
//       ..lineTo(width, 0)
//       ..lineTo(0, height)
//       ..lineTo(0, 0);
//   }

//   @override
//   bool shouldRepaint(TrianglePainter oldDelegate) {
//     return oldDelegate.strokeColor != strokeColor ||
//         oldDelegate.paintingStyle != paintingStyle ||
//         oldDelegate.strokeWidth != strokeWidth;
//   }
// }

// class ItemSlash extends StatelessWidget {
//   final String text;
//   final double width;
//   const ItemSlash({Key key, this.text, this.width = 50}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var diagonal = sqrt(pow(width, 2) * 2);
//     print("diagonal " + diagonal.toString());
//     return RawMaterialButton(
//       onPressed: () {},
//       child: Container(
//         width: width,
//         height: width,
//         child: CustomPaint(
//           painter: TrianglePainter(
//             strokeColor: Colors.red,
//             strokeWidth: 10,
//             paintingStyle: PaintingStyle.fill,
//           ),
//           // child: Transform(
//           //   transform: Matrix4.identity()..rotateZ(-45),
//           // ..translate(0.0, width / 2.1, 0.0)
//           // ..rotateZ(-45),
//           child: Container(
//             // width: diagonal - width / 3,
//             child: Center(
//               // widthFactor: 0.3,
//               child: Transform(
//                 transform: Matrix4.identity()
//                   ..rotateZ((-(pi / 4) - 0.01) * 1)
//                   ..translate(-width / 6,-width / 15),
//                 child: FractionallySizedBox(
//                   widthFactor: 0.5,
//                   child: FittedBox(
//                     fit: BoxFit.fitWidth,
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: width / 5,
//                           ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // ),
//         ),
//       ),
//     );
//   }
// }
