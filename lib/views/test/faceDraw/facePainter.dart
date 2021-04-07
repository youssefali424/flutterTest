// import 'dart:developer' as dev;
// import 'dart:ui';
// import 'dart:math';

import 'package:animated_image_list/interpolate.dart';
import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vc;

class FaceOutlinePainter extends CustomPainter {
  double smilePercent;
  FaceOutlinePainter({this.smilePercent = 0});
  @override
  void paint(Canvas canvas, Size size) {
    var eyeSize = size.width / 5;
    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = eyeSize / 5
      ..color = Colors.black;
    // var padding = size.width / 5;
    final paintCircle = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = eyeSize / 5
      ..color = Colors.yellow;
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paintCircle,
    );
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    // Left eye
    canvas.drawOval(
      Rect.fromLTWH(eyeSize, eyeSize, eyeSize, eyeSize),
      paint,
    );
    // Right eye
    canvas.drawOval(
      Rect.fromLTWH(size.width - eyeSize * 2, eyeSize, eyeSize, eyeSize),
      paint,
    );
    // double smilePercent = 0.5;
    var mouthHeight = size.height * 0.7;
    var maxSmile = size.height * 0.7;
    // print(size.height * 0.1);
    // print(interpolate(
    //     smilePercent,
    //     InterpolateConfig([0, 0.2], [0, size.height * 0.1],
    //         extrapolate: Extrapolate.CLAMP)));
    // Mouth
    final mouth = Path();
    mouth.moveTo(size.width * 0.8, mouthHeight);
    mouth.arcToPoint(
      Offset(size.width * 0.2, mouthHeight),
      radius: Radius.elliptical(
        size.width * 0.6,
        interpolate(
            smilePercent,
            InterpolateConfig([-1, 0, 0.2], [maxSmile, 0, size.height * 0.1],
                extrapolate: Extrapolate.CLAMP)),
      ),
      clockwise: smilePercent < 0 ? false : true,
    );
    mouth.arcToPoint(
      Offset(size.width * 0.8, mouthHeight),
      radius: Radius.lerp(Radius.elliptical(size.width * 0.6, 0.0),
          Radius.elliptical(size.width * 0.6, maxSmile), smilePercent.abs()),
      clockwise: smilePercent < 0 ? true : false,
    );
    canvas.drawPath(mouth, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) =>
      smilePercent != oldDelegate.smilePercent;
}

class FacePainter extends StatefulWidget {
  FacePainter({Key key}) : super(key: key);

  @override
  _FacePainterState createState() => _FacePainterState();
}

class _FacePainterState extends State<FacePainter>
    with SingleTickerProviderStateMixin {
  // List<List<Offset>> points;
  // List<Offset> currentPoints;
  AnimationController _controller;
  Animation anim;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // points = [];
    // currentPoints = [];
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        value: 0,
        lowerBound: -1,
        upperBound: 1);
    // anim = _controller.drive(
    //   Tween<double>(
    //     begin: -1,
    //     end: 1,
    //   ),
    // );
    // _controller.addListener(() {

    // });
  }
  ///[to] value from -1 to 1 ,1 equivalent to most smile , and -1 equivalent for sad face
  startAnim(double to) {
    print("start");
    // var width=MediaQuery.of(context).size.width;
    _controller.animateTo(to);
    // _controller.repeat();
  }

  num mix(num min, num max, double a) {
    return min + a * (max - min);
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print("timeStamp " + _controller.isAnimating.toString());
    //   inspect(_controller);
    //   if (!_controller.isAnimating) {
    //     startAnim();
    //   }
    // });
    var width = MediaQuery.of(context).size.width;
    return Center(
        child: Container(
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "How you feel about the app",
              )),
          Container(
            width: 150,
            height: 150,
            child: GestureDetector(
                onPanStart: (details) {
                  // currentPoints = List();
                  // points.add(currentPoints);
                },
                onPanUpdate: (details) {
                  // setState(() {
                  //   currentPoints.add(Offset(
                  //       details.localPosition.dx, details.localPosition.dy));
                  // });
                  print("details");
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (cx, _) => CustomPaint(
                    painter:
                        FaceOutlinePainter(smilePercent: _controller.value),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => startAnim(-1), child: Text("not happy")),
              TextButton(
                  onPressed: () => startAnim(-0.3),
                  child: Text("not convinced")),
              TextButton(
                  onPressed: () => startAnim(0), child: Text("not sure")),
              TextButton(onPressed: () => startAnim(0.5), child: Text("ok")),
              TextButton(onPressed: () => startAnim(1), child: Text("happy"))
            ],
          )
        ],
      ),
    ));
  }
}
