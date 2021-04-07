import 'package:flutter/material.dart';
import 'package:hospitals/util/colorUtil.dart';
import 'package:hospitals/views/photosGrid/index.dart';

class PhotosGridPage extends StatefulWidget {
  static const String routeName = '/photosGrid';
  final String id;
  PhotosGridPage({this.id});
  @override
  _PhotosGridPageState createState() => _PhotosGridPageState();
}

class _PhotosGridPageState extends State<PhotosGridPage> {
  final _photosGridBloc = PhotosGridBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: hexToColor('#363795'),
          title: Text('PhotosGrid'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [hexToColor('#005C97'), hexToColor('#363795')])),
          child:
              PhotosGridScreen(photosGridBloc: _photosGridBloc, id: widget.id),
        ));
  }
}
