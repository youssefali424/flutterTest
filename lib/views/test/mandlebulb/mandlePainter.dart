import 'dart:developer' as dev;
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

import 'test.dart';

class MandlePainter extends StatefulWidget {
  MandlePainter({Key key}) : super(key: key);

  @override
  _MandlePainterState createState() => _MandlePainterState();
}

class _MandlePainterState extends State<MandlePainter>
    with SingleTickerProviderStateMixin {
  // List<List<Offset>> points;
  // List<Offset> currentPoints;
  // AnimationController _controller;
  // Animation anim;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   points = [];
  //   currentPoints = [];
  //   _controller = AnimationController(
  //       vsync: this, duration: Duration(milliseconds: 2000));
  //   anim = _controller.drive(
  //     Tween<double>(
  //       begin: 0,
  //       end: 0,
  //     ),
  //   );
  // }

  startAnim() {
    print("start");
    // var width=MediaQuery.of(context).size.width;
    // anim = _controller.drive(
    //   Tween<double>(
    //     begin: -width/2,
    //     end: width,
    //   ),
    // );
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
    return Stack(
      children: [
        Container(
          width: 20,
          height: 30,
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
              child: CustomPaint(
                painter: MandleCustomPainter(),
              )),
        )
      ],
    );
  }
}

class MandleCustomPainter extends CustomPainter {
  // final List<List<Offset>> points;
  // double valX;
  // double valY;
  MandleCustomPainter();
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: draw something with canvas
    Matrix4 modelMatrix = Matrix4.identity();
    var eye = Vector3(0, 1, 0.0);
    var paint = Paint();

    for (double xpixel = 0; xpixel < size.width; xpixel++) {
      for (double ypixel = 0; ypixel < size.height; ypixel++) {
        var color = renderPixel(Vector3(xpixel, ypixel, 1000).normalized(), size,
            modelMatrix, eye.normalized(), 1.0);
        dev.log([color.r.floor(), color.g.floor(), color.b.floor()].join("-"));
        canvas.drawPoints(
            PointMode.points,
            [Offset(xpixel, ypixel)],
            paint
              ..color = Color.fromRGBO(
                  color.r.floor(), color.g.floor(), color.b.floor(), 1));
      }
    }
  }

  @override
  bool shouldRepaint(MandleCustomPainter oldDelegate) {
    return false;
  }
}

// String cocatNum
class PointCustom {
  Offset point;
  Vector4 color;
}
double mandelbulb(int px,int py,int pz) {
            var zx=px; var zy=py; var zz=pz;        
            var dr = 1;
            double r = 0;
            var iterations = 100;
            var bailout = 2;
            var power = 8;
            var j=0;

            for (var i=0 ; i < iterations ; i++) {                
                r = sqrt(zx*zx + zy*zy + zz*zz);
                if (r>bailout) break;
                
                // convert to polar coordinates
                var theta = acos(zz/r);
                var phi = atan2(zy,zx);
                
                dr =  pow( r, power-1.0)*power*dr + 1.0;
                
                // scale and rotate the point
                var zzr = pow( r,power);
                theta = theta*power;
                phi = phi*power;
                
                // convert back to cartesian coordinates
                zx = zzr * sin(theta) * cos(phi);
                zy = zzr * sin(phi) * sin(theta);
                zz = zzr * cos(theta);
                zx+=px;
                zy+=py;
                zz+=pz;

                j++;
            }
            return 0.5*log(r)*r/dr;
        }