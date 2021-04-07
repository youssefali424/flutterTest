import 'package:flutter/material.dart';
// import 'package:fullscreen/fullscreen.dart';
import 'package:hospitals/util/colorUtil.dart';
import 'package:hospitals/views/photoViewer/PhotoViewer_screen.dart';
import 'package:hospitals/views/photoViewerArbnb/PhotoViewerArbnb_screen.dart';

class PhotoViewerArbnbPage extends StatefulWidget {
  static const String routeName = '/PhotoViewerArbnb';
  final String url;
  final int index;
  PhotoViewerArbnbPage(
    this.url,
    this.index,
  );
  @override
  _PhotoViewerArbnbState createState() => _PhotoViewerArbnbState(this.url);
}

class _PhotoViewerArbnbState extends State<PhotoViewerArbnbPage> {
  String url;

  _PhotoViewerArbnbState(
    this.url,
  );
  // FullScreen fullscreen = new FullScreen();

  @override
  initState() {
    super.initState();
    // fullscreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('PhotoViewer'),
        // ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
          child: PhotoViewerArbnbScreen(this.url, widget.index),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // fullscreen.exitFullScreen();
    super.dispose();
  }
}
