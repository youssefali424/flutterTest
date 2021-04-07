library animated_image_list;

import 'dart:ui';
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'package:hospitals/views/AnimatedImageList/interpolate.dart';
// import 'package:hospitals/views/photoViewerArbnb/PhotoViewerArbnb_page.dart';
import "dart:math";
import 'SnappingListView.dart';
import 'photoViewerArbnb/PhotoViewerArbnb_page.dart';
import 'photoViewerArbnb/PhotoViewerArbnb_screen.dart';
import 'photoViewerArbnb/TransparentRoute.dart';

typedef ItemBuilder = Widget Function(
    BuildContext context, int index, double progress);

class AnimatedImageList extends StatelessWidget {
  final List<String> images;
  final ProviderBuilder provider;
  final ProviderBuilder placeHolder;
  final ItemBuilder builder;
  final Axis scrollDirection;
  final double itemExtent;
  final double maxExtent;
  const AnimatedImageList(
      {Key key,
      this.images,
      this.provider,
      this.placeHolder,
      this.builder,
      this.itemExtent = 150,
      this.maxExtent = 400,
      this.scrollDirection = Axis.vertical})
      : assert(images != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(images);
    return Container(
      child: SnappingListView.builder(
        itemBuilder: (context, index, progress, maxSize) {
          // print(maxHeight);
          String photo = images[index];
          var isVertical = scrollDirection == Axis.vertical;
          // double translate = interpolate(progress,
          //     InterpolateConfig([0, 1, 2], [-maxSize * 0.5, 0, maxSize * 0.5]));
          // double rotate = interpolate(
          //     progress,
          //     InterpolateConfig([0, 1, 2], [0.2, 0, -0.2],
          //         extrapolate: Extrapolate.CLAMP));
          return Padding(
              padding: const EdgeInsets.all(5),
              child: Hero(
                  tag: "$photo-$index",
                  child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(itemExtent/2),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(TransparentRoute(
                            builder: (BuildContext context) =>
                                PhotoViewerArbnbPage(
                              photo,
                              index,
                            ),
                          ));
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Container(
                                height: isVertical ? maxSize : null,
                                width: isVertical ? null : maxSize,
                                child: Transform(
                                    transform: Matrix4.identity(),
                                      // ..rotateY(pi * rotate)
                                      // ..translate(translate, 0.0),
                                    child: provider != null
                                        ? provider(photo)
                                        : Image.network(
                                            photo,
                                            fit: BoxFit.fill,
                                            // height: maxHeight,
                                            // width: 200,
                                            loadingBuilder:
                                                (context, image, progress) {
                                              if (progress != null)
                                                return Center(
                                                  child: SizedBox(
                                                    height: itemExtent / 2,
                                                    width: itemExtent / 2,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: progress == null
                                                          ? 0
                                                          : (progress.cumulativeBytesLoaded ??
                                                                  0) /
                                                              (progress
                                                                      .expectedTotalBytes ??
                                                                  1.0),
                                                    ),
                                                  ),
                                                );
                                              return image;
                                            },
                                          ))),
                            // builder?.call(context, index, progress) ??
                            //     Container()
                          ],
                        ),
                      ))));
        },
        itemCount: images.length,
        scrollDirection: scrollDirection,
        itemExtent: itemExtent,
        maxExtent: maxExtent,
      ),
    );
  }
}
