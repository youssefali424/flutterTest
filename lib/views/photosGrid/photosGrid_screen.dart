import 'dart:math';
import 'dart:ui';

// import 'package:animated_image_list/AnimatedImageList.dart';
import 'package:animated_image_list/SnappingListView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hospitals/models/collectionPhoto.dart';
import 'package:hospitals/util/colorUtil.dart';
import 'package:hospitals/views/photoViewer/photoViewer_page.dart';
import 'package:hospitals/views/photoViewerArbnb/TransparentRoute.dart';
import 'package:hospitals/views/photoViewerArbnb/photoViewerArbnb_page.dart';
import 'package:hospitals/views/photosGrid/index.dart';
import 'package:hospitals/views/AnimatedImageListSkew/AnimatedImageList.dart';
import 'package:hospitals/views/test/ItemSlash.dart';
import 'package:transparent_image/transparent_image.dart';
// import 'package:animated_image_list/AnimatedImageList.dart';

class PhotosGridScreen extends StatefulWidget {
  final String id;
  const PhotosGridScreen(
      {Key key, @required PhotosGridBloc photosGridBloc, this.id})
      : _photosGridBloc = photosGridBloc,
        super(key: key);

  final PhotosGridBloc _photosGridBloc;

  @override
  PhotosGridScreenState createState() {
    return PhotosGridScreenState();
  }
}

class PhotosGridScreenState extends State<PhotosGridScreen> {
  PhotosGridScreenState();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosGridBloc, PhotosGridState>(
        bloc: widget._photosGridBloc,
        builder: (
          BuildContext context,
          PhotosGridState currentState,
        ) {
          if (currentState is UnPhotosGridState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorPhotosGridState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InPhotosGridState) {
            var arr = [...currentState.photos];
            final scrollDirection = Axis.vertical;
            return Center(
              // child: SnappingListView.builder(
              //   itemBuilder: (context, index, progress, maxSize) {
              //     // print(maxHeight);
              //     String photo = arr[index].urls.small;
              //     var isVertical = scrollDirection == Axis.vertical;
              //     // double translate = interpolate(progress,
              //     //     InterpolateConfig([0, 1, 2], [-maxSize * 0.5, 0, maxSize * 0.5]));
              //     // double rotate = interpolate(
              //     //     progress,
              //     //     InterpolateConfig([0, 1, 2], [0.2, 0, -0.2],
              //     //         extrapolate: Extrapolate.CLAMP));
              //     return Padding(
              //         padding: const EdgeInsets.all(5),
              //         child: Hero(
              //             tag: "$photo-$index",
              //             child: Material(
              //                 color: Colors.transparent,
              //                 elevation: 10,
              //                 clipBehavior: Clip.antiAlias,
              //                 borderRadius:
              //                     BorderRadius.circular(itemExtent / 2),
              //                 child: InkWell(
              //                   onTap: () {
              //                     Navigator.of(context).push(TransparentRoute(
              //                       builder: (BuildContext context) =>
              //                           PhotoViewerArbnbPage(
              //                         photo,
              //                         index,
              //                       ),
              //                     ));
              //                   },
              //                   child: Stack(
              //                     fit: StackFit.expand,
              //                     alignment: AlignmentDirectional.topStart,
              //                     children: [
              //                       Container(
              //                           height: isVertical ? maxSize : null,
              //                           width: isVertical ? null : maxSize,
              //                           child: Transform(
              //                               transform: Matrix4.identity(),
              //                               // ..rotateY(pi * rotate)
              //                               // ..translate(translate, 0.0),
              //                               child: provider != null
              //                                   ? provider(photo)
              //                                   : Image.network(
              //                                       photo,
              //                                       fit: BoxFit.fill,
              //                                       // height: maxHeight,
              //                                       // width: 200,
              //                                       loadingBuilder: (context,
              //                                           image, progress) {
              //                                         if (progress != null)
              //                                           return Center(
              //                                             child: SizedBox(
              //                                               height:
              //                                                   itemExtent / 2,
              //                                               width:
              //                                                   itemExtent / 2,
              //                                               child:
              //                                                   CircularProgressIndicator(
              //                                                 value: progress ==
              //                                                         null
              //                                                     ? 0
              //                                                     : (progress.cumulativeBytesLoaded ??
              //                                                             0) /
              //                                                         (progress
              //                                                                 .expectedTotalBytes ??
              //                                                             1.0),
              //                                               ),
              //                                             ),
              //                                           );
              //                                         return image;
              //                                       },
              //                                     ))),
              //                       // builder?.call(context, index, progress) ??
              //                       //     Container()
              //                     ],
              //                   ),
              //                 ))));
              //   },
              //   itemCount: images.length,
              //   scrollDirection: scrollDirection,
              //   itemExtent: itemExtent,
              //   maxExtent: maxExtent,
              // ),
              child: Container(
                height: 205,
                child: AnimatedImageList(
                  images: arr.map((e) => e.urls.small).toList(),
                  builder: (context, index, progress) {
                    
                    return Positioned.directional(
                        textDirection: TextDirection.ltr,
                        bottom: 15,
                        start: 25,
                        child: Opacity(
                          opacity: progress > 1 ? (2 - progress) : progress,
                          child: Text(
                            arr[index].user.username ?? 'Anonymous',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ));
                  },
                  // builder: (context, index, progress) {
                  //   // TabBarView()
                  //   return Positioned.directional(
                  //       textDirection: TextDirection.ltr,
                  //       top: 0,
                  //       // width: 100,
                  //       start: 0,

                  //       child: Opacity(
                  //         opacity: progress > 1 ? (2 - progress) : progress,
                  //         child: ItemSlash(
                  //           // text: arr[index].user.username ?? "anonymous",
                  //           text: 'Featured',
                  //           width: 100,
                  //         ),
                  //       ));
                  // },
                  scrollDirection: Axis.horizontal,
                  itemExtent: 150,
                  maxExtent: 150,
                ),
              ),
              // child: SnappingListView.builder(
              //   itemBuilder: (context, index, progress, maxHeight) {
              //     print(maxHeight);
              //     CollectionPhoto photo = arr[index];
              //     return Padding(
              //         padding: const EdgeInsets.all(5),
              //         child: Hero(
              //             tag: photo.urls.small,
              //             child: Material(
              //                 color: Colors.transparent,
              //                 elevation: 10,
              //                 clipBehavior: Clip.antiAlias,
              //                 borderRadius:
              //                     const BorderRadius.all(Radius.circular(10)),
              //                 child: InkWell(
              //                   onTap: () {
              //                     // Navigator.pushNamed(
              //                     //   context,
              //                     //   PhotoViewerArbnbPage.routeName,
              //                     //   arguments: photo.urls.small,
              //                     // );
              //                     Navigator.of(context).push(TransparentRoute(
              //                       builder: (BuildContext context) =>
              //                           PhotoViewerArbnbPage(photo.urls.small),
              //                     ));
              //                   },
              //                   child: Stack(
              //                     fit: StackFit.expand,
              //                     children: [
              //                       OverflowBox(
              //                         maxHeight: maxHeight,
              //                         minHeight: 150,
              //                         child: Container(
              //                             height: maxHeight,
              //                             child: Transform(
              //                               transform: Matrix4.identity()
              //                                 ..translate(
              //                                     0.0,
              //                                     progress > 1
              //                                         ? max(
              //                                             maxHeight *
              //                                                 (progress - 1),
              //                                             0.0)
              //                                         : 0)
              //                               // ..scale(
              //                               //     // 1.0,
              //                               //     progress < 1
              //                               //         ? max(
              //                               //             1.4 * (1 - progress),
              //                               //             1.0)
              //                               //         : 1.0)

              //                               //     max(5.0 * (1 - progress), 1))
              //                               ,
              //                               child: CachedNetworkImage(
              //                                 fit: BoxFit.fill,
              //                                 imageUrl: photo.urls.small,
              //                                 placeholder: (context, url) =>
              //                                     SpinKitCircle(
              //                                   color: hexToColor('#363795'),
              //                                   size: 100.0,
              //                                 ),
              //                                 errorWidget:
              //                                     (context, url, error) =>
              //                                         Icon(Icons.error),
              //                               ),
              //                             )),
              //                       ),
              //                       Positioned.directional(
              //                           textDirection: TextDirection.ltr,
              //                           bottom: 15,
              //                           start: 25,
              //                           child: Opacity(
              //                             opacity: progress > 1
              //                                 ? (2 - progress)
              //                                 : progress,
              //                             child: Text(
              //                               photo.user.username ?? 'Anonymous',
              //                               style: TextStyle(
              //                                   color: Colors.white,
              //                                   fontSize: 25,
              //                                   fontWeight: FontWeight.w500),
              //                             ),
              //                           ))
              //                     ],
              //                   ),
              //                 ))));
              //   },
              //   itemCount: arr.length,
              //   scrollDirection: scrollDirection,
              //   itemExtent: 150,
              //   maxExtent: 400,
              //   //  itemExtent: 100,
              //   // physics: const BouncingScrollPhysics(),
              // ),
              //  GridView.builder(
              //     itemCount: currentState.photos.length,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2),
              //     itemBuilder: (context, index) {
              // CollectionPhoto photo = currentState.photos[index];
              // return Padding(
              //     padding: const EdgeInsets.all(5),
              //     child: Hero(
              //         tag: photo.urls.small,
              //         child: Material(
              //             color: Colors.transparent,
              //             elevation: 10,
              //             clipBehavior: Clip.antiAlias,
              //             borderRadius: const BorderRadius.all(
              //                 Radius.circular(10)),
              //             child: InkWell(
              //               onTap: () {
              //                 // Navigator.pushNamed(
              //                 //   context,
              //                 //   PhotoViewerArbnbPage.routeName,
              //                 //   arguments: photo.urls.small,
              //                 // );
              //                 Navigator.of(context)
              //                     .push(TransparentRoute(
              //                   builder: (BuildContext context) =>
              //                       PhotoViewerArbnbPage(
              //                           photo.urls.small),
              //                 ));
              //               },
              //               child: Container(
              //                   child: CachedNetworkImage(
              //                 fit: BoxFit.fill,
              //                 imageUrl: photo.urls.small,
              //                 placeholder: (context, url) =>
              //                     SpinKitCircle(
              //                   color: hexToColor('#363795'),
              //                   size: 100.0,
              //                 ),
              //                 errorWidget: (context, url, error) =>
              //                     Icon(Icons.error),
              //               )),
              //             ))));
              //     })
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    () async {
      await Future.delayed(Duration.zero);
      final String args = ModalRoute.of(context).settings.arguments;
      widget._photosGridBloc
          .add(LoadPhotosGridEvent(isError, args ?? widget.id));
    }();
  }
}
