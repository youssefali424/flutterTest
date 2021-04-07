import 'dart:developer';
import 'dart:math' as Math;
// import 'dart:ui';
// import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:hospitals/views/test/fishEyeEffect.dart';
import 'package:http/http.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:image/image.dart' as libImg;

//Arbnb Image Viewer Have Fun!
class PhotoViewerArbnbScreen extends StatefulWidget {
  PhotoViewerArbnbScreen(this.imgUrl, this.index, {Key key}) : super(key: key);
  final String imgUrl;
  final int index;
  @override
  PhotoViewerArbnbScreenState createState() {
    return PhotoViewerArbnbScreenState();
  }
}

class Position {
  double x;
  double y;
  Position(this.x, this.y);
}

class PhotoViewerArbnbScreenState extends State<PhotoViewerArbnbScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  PhotoViewerArbnbScreenState();
  Position position = Position(0, 0);
  double scale = 1;
  BorderRadius borderRadius = BorderRadius.circular(0.0);
  Animation<double> _animation;
  double opacity = 1;
  Image currImage;
  // double stigma = 100;
  // AnimationController blurController;
  // Animation<double> blurAnimation;
  // NetworkImage Image;
  // PhotoViewController controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _controller.addListener(() {
      setState(() {
        position.x += -(position.x * _animation.value);
        position.y += -(position.y * _animation.value);
        scale += (1 - scale) * _animation.value;
        double currentRadius = Math.min(50, ((1 - scale) / 0.1) * 50);
        borderRadius = BorderRadius.circular(currentRadius);
        opacity += (1 - opacity) * _animation.value;
        print('_animation.value ${_animation.value}');
      });
    });

    // NetworkImage(url)
    //     .resolve(ImageConfiguration())
    //     .addListener(ImageStreamListener((imageInfo, bool)async {
    //       var bytes=await imageInfo.image.toByteData();
    //         libImg.Image.fromBytes(width, height, bytes.);
    //     }));
    // blurController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 2000));
    // blurController.addListener(() {
    //   setState(() {
    //     stigma = blurAnimation.value;
    //   });
    // });
    // blurAnimation = blurController.drive(
    //   Tween<double>(
    //     begin: 10,
    //     end: 0,
    //   ),
    // );
    this._load();
  }

  Future<libImg.Image> getImage() async {
    String url = widget.imgUrl;
    print("loadin");
    final rawImg = (await get(url)).bodyBytes;
    final img = libImg.decodeImage(rawImg);
    var output = correction2(img);
    inspect(output);
    setState(() {
      currImage = Image.memory(libImg.encodePng(output));
      print("here");
    });

    return img;
  }
  // void runBlurAnim() {
  //   blurController.reset();
  //   blurController.forward();
  // }

  void _runAnimation() {
    _animation = _controller.drive(
      Tween<double>(
        begin: 0,
        end: 1,
      ).chain(CurveTween(curve: Curves.elasticOut)),
    );
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    // blurController.dispose();
    super.dispose();
  }

  double maxYDist() {
    return MediaQuery.of(context).size.height / 2.3;
  }

  double lerp(double begin, double end, double percentage) {
    return begin + (end - begin) * percentage;
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.imgUrl;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return XGestureDetector(
      onMoveUpdate: (event) {
        setState(() {
          double height = MediaQuery.of(context).size.height;
          position.y += event.delta.dy;
          position.x += event.delta.dx;
          scale = Math.max(
              0.4, Math.min((((position.y).abs() / height) - 1).abs(), 1));
          double perc = ((scale - 0.6) / 0.4);
          opacity = lerp(0, 1, perc < 0 ? 0 : perc);
          double currentRadius = Math.min(50, ((1 - scale) / 0.1) * 50);
          borderRadius = BorderRadius.circular(currentRadius);
        });
      },
      onMoveEnd: (details) {
        log("onPanEnd");
        if (scale <= 0.80) {
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        } else {
          this._runAnimation();
        }
      },
      onMoveStart: (details) {
        log("onPanStart");
        log((details).toString());
        _controller.stop();
      },
      child: Transform(
        transform: Matrix4.identity()
          ..scale(scale, scale)
          ..translate(position.x - (1 - scale), position.y - (1 - scale), 0.0),
        alignment: FractionalOffset.center,
        child: ClipRRect(
            borderRadius: borderRadius,
            child: Center(
              child: Container(
                color: Color.fromRGBO(0, 0, 0, opacity),
                height: height,
                width: width,
                child: Hero(
                  tag: "$url-${widget.index}",
                  child: currImage ??
                      FadeInImage(
                        image: NetworkImage(url),
                        placeholder: MemoryImage(kTransparentImage),
                      ),
                ),
              ),
            )),
      ),
    );
  }

  void _load() {
    getImage();
  }
}
