import 'dart:ui';

import 'package:flutter/material.dart';

class PointerPainter extends CustomPainter {
  final TextDirection direction;
  final double animation;
  final Color arrowTintColor;
  final Color color;
  PointerPainter(
      {this.direction,
      this.animation,
      this.color,
      this.arrowTintColor = Colors.purple});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: draw something with canvas
    const pointerHeight = 100;
    const arrowHeight = 20;

    Paint paint = Paint();
    paint.color = color;
    var startRadius = (size.height / 2) - (pointerHeight / 2);
    Path mpath = Path();

    mpath.moveTo(0, startRadius);
    mpath.quadraticBezierTo(0, (startRadius) + (pointerHeight / 9), 5,
        startRadius + (pointerHeight / 7));
    mpath.quadraticBezierTo(55, (size.height / 2), 5,
        (startRadius + pointerHeight) - (pointerHeight / 7));
    mpath.quadraticBezierTo(
        0,
        (startRadius + pointerHeight) - (pointerHeight / 9),
        0,
        startRadius + pointerHeight);
    mpath.lineTo(0, size.height);
    Paint arrowPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    Path arrow = Path()
      ..moveTo(5, (size.height / 2) - arrowHeight)
      ..cubicTo(
          25,
          (size.height / 2) + (arrowHeight * 0.1),
          25,
          (size.height / 2) + (arrowHeight * 0.1),
          5,
          (size.height / 2) + arrowHeight)
      ..fillType = PathFillType.nonZero;

    canvas.drawShadow(mpath, Colors.black, 5.0, false);
    // canvas.drawPath(
    //     spath,
    //     Paint()
    //       ..color = Colors.black.withAlpha(50)
    //       ..style = PaintingStyle.stroke
    //       ..strokeWidth = 7
    //       ..maskFilter =
    //           MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(10)));
    canvas.drawPath(mpath, paint);
    canvas.drawPath(arrow, arrowPaint);
    if (animation > 0) {
      Paint arrowPaint = Paint()
        ..color = arrowTintColor
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      final path = createAnimatedPath(arrow, animation);
      canvas.drawPath(path, arrowPaint);
    }
  }

  Path createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(
    Path originalPath,
    double length,
  ) {
    var currentLength = 0.0;

    final path = new Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }
      currentLength = nextLength;
    }

    return path;
  }
  // static double convertRadiusToSigma(double radius) {
  //   return radius * 0.57735 + 0.5;
  // }

  @override
  bool shouldRepaint(PointerPainter oldDelegate) {
    if (oldDelegate.direction == direction &&
        oldDelegate.animation == animation &&
        oldDelegate.arrowTintColor == arrowTintColor) {
      return false;
    }

    return true;
  }
}
