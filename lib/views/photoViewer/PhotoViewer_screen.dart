import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerScreen extends StatefulWidget {
  PhotoViewerScreen(this.imgUrl, {Key key}) : super(key: key);
  final String imgUrl;
  @override
  PhotoViewerScreenState createState() {
    return PhotoViewerScreenState();
  }
}

class PhotoViewerScreenState extends State<PhotoViewerScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  PhotoViewerScreenState();
  double y = 0;
  double lastPos = 0;
  double velocity = 0;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.addListener(() {
      setState(() {
        y = _animation.value;
        print('_animation.value ${_animation.value}');
      });
      // print('${simulation.x(_animation.value)}');
    });
    // maxYDist = ;
    this._load();
  }

  double friction(x) => 0.80 * Math.pow((1 - x), 2);
  void _runAnimation() {
    // Tween
    _animation = _controller.drive(
      Tween(
        begin: y,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.elasticOut)),
    );
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double maxYDist() {
    return MediaQuery.of(context).size.height / 2.3;
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.imgUrl;

    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      color: Color.fromRGBO(0, 0, 0, 1),

      child: Transform(
        transform: Matrix4.identity()..translate(0.0, y, 0.0),
        alignment: FractionalOffset.center,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            lastPos += details.delta.dy;
            setState(() {
              log(((y + details.delta.dy) / maxYDist()).abs().toString());
              double delta =
                  friction(((y + details.delta.dy) / maxYDist()).abs()) *
                      details.delta.dy;
              y += delta;
            });
          },
          onVerticalDragEnd: (details) {
            velocity = details.velocity.pixelsPerSecond.dy;
            double height = MediaQuery.of(context).size.height;
            if (y > height * 0.15 || y < -height * 0.15) {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            } else {
              this._runAnimation();
            }
          },
          onVerticalDragStart: (details) {
            lastPos = 0;
            _controller.stop();
          },
          child: PhotoView(
            imageProvider: NetworkImage(
              url,
            ),
            loadingBuilder: (context, progress) => Center(
              child: CircularProgressIndicator(
                value: progress == null
                    ? null
                    : progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes,
              ),
            ),
            heroAttributes: PhotoViewHeroAttributes(
              tag: url,
              // transitionOnUserGestures: true,
            ),
          ),
        ),
      ),
    );
  }

  void _load() {}
}
