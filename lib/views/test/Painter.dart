import 'dart:developer';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

class Painter extends StatefulWidget {
  Painter({Key key}) : super(key: key);

  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> with SingleTickerProviderStateMixin {
  List<List<Offset>> points;
  List<Offset> currentPoints;
  AnimationController _controller;
  Animation anim;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    points = List();
    currentPoints = List();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    anim = _controller.drive(
      Tween<double>(
        begin: 0,
        end: 0,
      ),
    );
  }

  startAnim() {
    print("start");
    var width=MediaQuery.of(context).size.width;
    anim = _controller.drive(
      Tween<double>(
        begin: -width/2,
        end: width,
      ),
    );
    _controller.repeat();
  }

  num mix(num min, num max, double a) {
    return min + a * (max - min);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("timeStamp " + _controller.isAnimating.toString());
      inspect(_controller);
      if (!_controller.isAnimating) {
        startAnim();
      }
    });
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AnimatedBuilder(
          animation: anim,
          builder: (context, _) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: GestureDetector(
                  onPanStart: (details) {
                    currentPoints = List();
                    points.add(currentPoints);
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      currentPoints.add(Offset(
                          details.localPosition.dx, details.localPosition.dy));
                    });
                    print("details");
                  },
                  child: CustomPaint(
                    painter: FaceOutlinePainter(
                        anim.value, (mix(0.5, 1.0, anim.value / width))),
                  )),
            );
          },
        ),
        // RaisedButton(
        //   onPressed: () {
        //     setState(() {
        //       points.clear();
        //     });
        //   },
        //   child: Container(
        //     child: Icon(Icons.delete_forever),
        //   ),
        // ),
      ],
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  // final List<List<Offset>> points;
  double valX;
  double valY;
  FaceOutlinePainter(this.valX, this.valY);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: draw something with canvas
    Paint paint = Paint();
    paint.color = Colors.cyan;
    paint.strokeWidth = 2.0;
    Path mpath = new Path();
    // var valY = 1.0;
    // var valX = valX;
    mpath.moveTo(valX, 0);
    mpath.quadraticBezierTo((size.width / 4) + valX, valY * size.width / 4,
        (size.width / 2) + valX, 0);
    // mpath.relativeQuadraticBezierTo(40, val * size.width/4, size.width/2, 0);
    // mpath.relativeQuadraticBezierTo(40, val * 100, 80, 0);
    canvas.drawPath(mpath, paint);
    // for (var po in points) {
    //   canvas.drawPoints(PointMode.polygon, po, paint);
    // }
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) {
    // if (points.length == oldDelegate.points.length) {
    //   return !_listsAreEqual(points, oldDelegate.points);
    // }
    return true;
  }

  bool _listsAreEqual(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;

      return two[i] == element;
    });
  }
}
