// import 'dart:html';

import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:background_locator/location_dto.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stage/flutter_stage.dart';
import 'package:hospitals/util/colorUtil.dart';
import 'package:hospitals/views/test/AnimatedRail/AnimatedRail.dart';
import 'package:hospitals/views/test/BeamerAnimatedRail/BeamerAnimatedRail.dart';
import 'package:hospitals/views/test/BottomRefreshIndicator.dart';
import 'package:hospitals/views/test/F3dObject.dart';
import 'package:hospitals/views/test/Painter.dart';
import 'package:hospitals/views/test/Render3dObject.dart';
import 'package:hospitals/views/test/SnappingListView.dart' as custom;
import 'package:hospitals/views/test/accordion.dart';
import 'package:hospitals/views/test/index.dart';

import 'AnimatedRail/RailItem.dart';
import 'BeamerAnimatedRail/BeamerRailItem.dart';
import 'faceDraw/facePainter.dart';
import 'gpsLocator/GpsLocator.dart';
import 'mandlebulb/mandlePainter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({
    Key key,
    @required TestBloc testBloc,
  })  : _testBloc = testBloc,
        super(key: key);

  final TestBloc _testBloc;

  @override
  TestScreenState createState() {
    return TestScreenState();
  }
}

class TestLocation extends BeamLocation {
  TestLocation({
    String pathBlueprint,
  }) : super(pathBlueprint: pathBlueprint);

  @override
  List<String> get pathBlueprints => ['$pathBlueprint/:page'];

  @override
  List<BeamPage> get pages => [
        BeamPage(
          key: ValueKey('$pathBlueprint'),
          child: FirstPage(
            title: '$pathBlueprint',
            pathBlueprint: '$pathBlueprint/:page',
          ),
        ),
        if (pathParameters.containsKey('page'))
          BeamPage(
            key: ValueKey('$pathBlueprint 2'),
            child: _buildTest('$pathBlueprint 2'),
          ),
      ];
}

Widget _buildTest(String title) {
  return Container(
    color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    child: Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          // height: ,
          child: Text(
            title,
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

class FirstPage extends StatelessWidget {
  final String title;
  final String pathBlueprint;
  FirstPage({this.title, this.pathBlueprint});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    dev.log('$pathBlueprint');
    return Container(
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            // height: ,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      Beamer.of(context)
                        ..updateCurrentLocation(
                          pathBlueprint: pathBlueprint,
                          pathParameters: {'page': '2'},
                        );
                    },
                    child: Text(
                      'Second page',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget _buildTest(String title) {
//   final String str =
//       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an standard dummy text ever since the 1500s, when an";
//   return Container(
//     color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
//     child: Center(
//       child: FittedBox(
//         fit: BoxFit.scaleDown,
//         child: Container(
//           // height: ,
//           child: Text.rich(
//             TextSpan(text: str, children: [
//               WidgetSpan(
//                   child: SizedBox(
//                 height: 45,
//                 width: 40,
//                 child: Stack(
//                   children: [
//                     Image.asset(
//                       'assets/separator.png',
//                       height: 45,
//                       width: 40,
//                       color: Colors.grey[500],
//                     ),
//                     Center(
//                       child: Text(
//                         "1",
//                         style: TextStyle(fontSize: 25, color: Colors.white),
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//               // TextSpan(
//               //     text: "1",
//               //     )
//             ]),
//             style: TextStyle(fontSize: 40, color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   );
// }
class TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  TestScreenState();
  bool selected = false;
  bool refreshing = false;
  AnimationController _cursorAnimationController;
  // Future<ui.Image> separatorImage;
  @override
  void initState() {
    super.initState();
    // separatorImage = loadImageFromFile("assets/placeholder.png");
    _load();
    _scrollController = ScrollController();
    _cursorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: -1,
    );
    _cursorAnimationController.value = 0.0;
    // _cursorAnimation = _cursorAnimationController.drive(
    //   Tween<double>(
    //     begin: 0.0,
    //     end: 0.0,
    //   ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
    // );
    _cursorAnimationController.addListener(() {
      print("_cursorAnimation: ${_cursorAnimationController.value}");
    });
    initLocator();
  }

  // Future<ui.Image> loadImageFromFile(String path) async {
  //   var fileData = Uint8List.sublistView(await rootBundle.load(path));
  //   return await decodeImageFromList(fileData);
  // }

  @override
  void dispose() {
    _cursorAnimationController.dispose();
    super.dispose();
  }

  Matrix4 matrix4 = Matrix4.identity();

  getLines(String rawText, double maxWidth,
      {TextDirection textDirection = TextDirection.ltr,
      TextAlign textAlign = TextAlign.start,
      double textScaleFactor = 1.0,
      int maxLines,
      String ellipsis,
      Locale locale,
      StrutStyle strutStyle,
      TextWidthBasis textWidthBasis = TextWidthBasis.parent,
      TextHeightBehavior textHeightBehavior,
      TextStyle style = const TextStyle()}) {
    final span = TextSpan(
      text: rawText,
      style: style,
    );
    final _textPainter = TextPainter(
        text: span,
        textDirection: textDirection,
        textAlign: textAlign,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        ellipsis: ellipsis,
        locale: locale,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior);
    _textPainter.layout(
      maxWidth: maxWidth,
    );
// get a list of TextBoxes (Rects)
    List<ui.LineMetrics> boxes = _textPainter.computeLineMetrics();
    print("boxes: $boxes");
// Loop through each text box
    List<String> lineTexts = [];
    int start = 0;
    int end;
    int index = -1;
    double lastWidth = 0;

    for (ui.LineMetrics box in boxes) {
      index += 1;
      // Uncomment this if you want to only get the whole line of text
      // (sometimes a single line may have multiple TextBoxes)
      // if (box.left != 0.0)
      //  continue;
      if (index == 0) continue;
      // Go one logical pixel within the box and get the position
      // of the character in the string.
      end = _textPainter
          .getPositionForOffset(
              Offset(box.left + 1, box.baseline - box.ascent + 1))
          .offset;
      // add the substring to the list of lines
      final line = rawText.substring(start, end);
      lineTexts.add(line);
      lastWidth = box.width;
      start = end;
    }
// get the last substring
    final extra = rawText.substring(start);
    print("extra : $extra");
    print("extra width : ${maxWidth - lastWidth}");
    lineTexts.add(extra);
    return lineTexts;
  }

  ScrollController _scrollController;
  // List<double> _stops;
  double _pixels = 0.0;
  int _timestamp = DateTime.now().millisecondsSinceEpoch;
  ScrollDirection _direction;
  Animation<double> _cursorAnimation;
  double oldVelocity = 0;
  double oldExtent = 0;
  bool _onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      _direction = notification.direction;
    }
    final now = DateTime.now();
    final timeDiff = now.millisecondsSinceEpoch - _timestamp;
    if (notification is ScrollUpdateNotification) {
      double pixels = _scrollController.position.pixels;
      double velocity = oldVelocity = (pixels - _pixels) / (timeDiff);
      var extent = ui.lerpDouble(0, 1, (velocity?.clamp(0, 700) ?? 0) / 700);
      setState(() {
        // _stops = _direction == ScrollDirection.forward
        //     ? [0.0, 1 - extent]
        //     : [0.0 + extent, 1];
        oldExtent = _direction == ScrollDirection.forward ? -extent : extent;
        _cursorAnimationController.animateTo(
          _direction == ScrollDirection.forward ? extent : -extent,
        );
        print(oldExtent);
      });
      _timestamp = DateTime.now().millisecondsSinceEpoch;
    }

    if (notification is ScrollEndNotification) {
      _timestamp = DateTime.now().millisecondsSinceEpoch;
      _cursorAnimationController.animateTo(0.0,
          duration: Duration(milliseconds: 1000));
      // setState(() {
      // _stops = [0.0, 1];

      // });
    }
    return true;
  }

  LocationDto loc;
  BackgroundLocatorStatus status = BackgroundLocatorStatus.Unknown;
  startAnim(double value) {
    _cursorAnimation = _cursorAnimationController.drive(
      Tween<double>(
        begin: value,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
    );
    _cursorAnimationController.forward();
  }

  initLocator() async {
    await GpsLocator.initPlugin((data) {
      print("location in dart data ${data}");
      setState(() {
        loc = data;
      });
    });
    print("location in dart isInitiated ${GpsLocator.isInitiated}");
    if (GpsLocator.isInitiated) {
      var isRunning = await GpsLocator.isRunning;
      print("location in dart $isRunning");
      if (isRunning) {
        setState(() {
          status = BackgroundLocatorStatus.Started;
        });
      }
    }
  }

  start() async {
    var running = await GpsLocator.isRunning;

    if (running) {
      setState(() {
        status = BackgroundLocatorStatus.Started;
      });
      return;
    }
    var stat = await GpsLocator.startLocationService(callback: (data) {
      print("location in dart data ${data}");
      setState(() {
        loc = data;
      });
    });
    setState(() {
      status = stat;
    });
  }

  stop() async {
    await GpsLocator.stop();
    setState(() {
      status = BackgroundLocatorStatus.Stopped;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('build');
    var mediaQuery = MediaQuery.of(context);
    // final span = TextSpan(
    //   text: str,
    //   style: TextStyle(fontSize: 15),
    // );
    // final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    // tp.layout(maxWidth: 100);
    // // tp.getLineBoundary(TextPosition());
    // tp.computeLineMetrics().forEach((e) {
    //   var tmp = tp.getLineBoundary(TextPosition(
    //       offset: e.baseline.floor(), affinity: TextAffinity.upstream));
    //   print("${tmp}");
    //   // inspect(e);e.
    // });

    return BlocBuilder<TestBloc, TestState>(
        bloc: widget._testBloc,
        builder: (
          BuildContext context,
          TestState currentState,
        ) {
          if (currentState is UnTestState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorTestState) {
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
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InTestState) {
            // return Stage(
            //   onSceneCreated: (Scene scene) {
            //     scene.camera.position.setFrom(Vector3(0,-500, 1000));
            //     scene.camera.up.setFrom(Vector3(0.0, -400.0, 0.0));
            //     scene.camera.updateTransform();

            //   },
            //   children: [
            //     Actor(
            //       position: Vector3(0, 0, 0),
            //       rotation: Vector3(0, 30, 0),
            //       children: [
            //         Actor(
            //             position: Vector3(0, 0, 300),
            //             rotation: Vector3(0, 0, 0),
            //             width: 600,
            //             height: 600,
            //             widget: Container(color: Colors.red.withOpacity(0.5))),
            //         Actor(
            //             position: Vector3(300, 0, 0),
            //             rotation: Vector3(0, 90, 0),
            //             width: 600,
            //             height: 600,
            //             widget:
            //                 Container(color: Colors.green.withOpacity(0.5))),
            //         Actor(
            //             position: Vector3(0, 0, -300),
            //             rotation: Vector3(0, 180, 0),
            //             width: 600,
            //             height: 600,
            //             widget: Container(color: Colors.blue.withOpacity(0.5))),
            //         Actor(
            //             position: Vector3(-300, 0, 0),
            //             rotation: Vector3(0, 270, 0),
            //             width: 600,
            //             height: 600,
            //             widget:
            //                 Container(color: Colors.yellow.withOpacity(0.5))),
            //         Actor(
            //             position: Vector3(0, -300, 0),
            //             rotation: Vector3(90, 0, 0),
            //             width: 600,
            //             height: 600,
            //             widget: Container(color: Colors.pink.withOpacity(0.5))),
            //         Actor(
            //             position: Vector3(0, 300, 0),
            //             rotation: Vector3(270, 0, 0),
            //             width: 600,
            //             height: 600,
            //             widget: Container(color: Colors.white.withOpacity(0.5)))
            //       ],
            //     ),
            //   ],
            // );
            // return Center(
            //     child: BeamerAnimatedRail(
            //   activeColor: Colors.purple,
            //   background: hexToColor('#8B77DD'),
            //   maxWidth: 275,
            //   width: 100,
            //   // direction: TextDirection.rtl,
            //   items: [
            //     BeamerRailItem(
            //         icon: Icon(Icons.home),
            //         label: "Home",
            //         location: TestLocation(pathBlueprint: 'Home')),
            //     BeamerRailItem(
            //         icon: Icon(Icons.message_outlined),
            //         label: 'Messages',
            //         location: TestLocation(pathBlueprint:'Messages')),
            //     BeamerRailItem(
            //         icon: Icon(Icons.notifications),
            //         label: "Notification",
            //         location: TestLocation(pathBlueprint:'Notification')),
            //     BeamerRailItem(
            //         icon: Icon(Icons.person),
            //         label: 'Profile',
            //         location: TestLocation(pathBlueprint:'Profile')),
            //   ],
            // ));
            return Center(
                child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(loc != null
                              ? "location:${loc.latitude},${loc.latitude} speed: ${loc.speed}"
                              : "no location")),
                      Row(
                        children: [
                          TextButton(
                            child: Text('start'),
                            onPressed: start,
                          ),
                          TextButton(
                            child: Text('stop'),
                            onPressed: stop,
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                      top: 70,
                      left: 30,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: status == BackgroundLocatorStatus.Started
                                ? Colors.green
                                : Colors.red),
                      ))
                ],
              ),
            )
                // child: NotificationListener<ScrollNotification>(
                //   onNotification: _onScroll,
                //   child: AnimatedBuilder(
                //     animation: _cursorAnimationController,
                //     builder: (_, child) {
                //       var extent = _cursorAnimationController.value;
                //       List<double> stops =
                //           extent < 0 ? [0.0, 1 + extent] : [0.0 + extent, 1];
                //       return ShaderMask(
                //           blendMode: BlendMode.srcOut, // Add this
                //           shaderCallback: (Rect bounds) {
                //             return LinearGradient(
                //                     begin: Alignment.topCenter,
                //                     end: Alignment.bottomCenter,
                //                     colors: <Color>[
                //                       Colors.purple,
                //                       Colors.redAccent
                //                     ],
                //                     stops: stops
                //                     // tileMode: TileMode.mirror,
                //                     )
                //                 .createShader(bounds);
                //           },
                //           child: child);
                //     },
                //     child: ListView.builder(
                //       controller: _scrollController,
                //       itemBuilder: (context, index) {
                //         return Container(
                //           margin: EdgeInsets.symmetric(vertical: 5),
                //           height: 100,
                //           width: double.infinity,
                //           color: Colors.transparent,
                //           // decoration: BoxDecoration(
                //           //     color: Color.lerp(Colors.red[200],
                //           //         Colors.deepPurple[300], index / 15)),
                //           child: Center(child: Text("$index")),
                //         );
                //       },
                //       itemCount: 100,
                //       physics: BouncingScrollPhysics(
                //           parent: FixedExtentScrollPhysics()),
                //       // scrollDirection: Axis.horizontal,
                //       // itemExtent: 100,
                //     ),
                //   ),
                // ),
                );

            // return Container(
            //     color: Colors.blue.withOpacity(.6),
            //     child: NestedScrollView(headerSliverBuilder:
            //         (BuildContext context, bool innerBoxIsScrolled) {
            //       return <Widget>[
            //         SliverOverlapAbsorber(
            //           handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            //               context),
            //           sliver: SliverAppBar(
            //             title: const Text(
            //                 'Books'), // This is the title in the app bar.
            //             pinned: true,
            //             expandedHeight: 150.0,
            //             forceElevated: innerBoxIsScrolled,
            //           ),
            //         ),
            //       ];
            //     }, body: Builder(
            //         // This Builder is needed to provide a BuildContext that is
            //         // "inside" the NestedScrollView, so that
            //         // sliverOverlapAbsorberHandleFor() can find the
            //         // NestedScrollView.
            //         builder: (BuildContext context) {
            //       return CustomScrollView(
            //         slivers: <Widget>[
            //           SliverOverlapInjector(
            //             // This is the flip side of the SliverOverlapAbsorber
            //             // above.
            //             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            //                 context),
            //           ),
            //           SliverPadding(
            //             padding: const EdgeInsets.all(8.0),
            //             // In this example, the inner scroll view has
            //             // fixed-height list items, hence the use of
            //             // SliverFixedExtentList. However, one could use any
            //             // sliver widget here, e.g. SliverList or SliverGrid.
            //             sliver: SliverList(
            //                 delegate: SliverChildListDelegate([
            //               Container(
            //                 height: 200.0,
            //                 width: double.infinity,
            //                 // color: Colors.blue.withOpacity(.6),
            //                 // child: TopCarouselSlider(bgColor: null),
            //               ),
            //               //
            //               // Sliver(),
            //               Sliver(
            //                 height: MediaQuery.of(context).size.width * 1,
            //                 width: MediaQuery.of(context).size.width * 0.90,
            //                 color: Colors.blue,
            //                 //
            //                 child: SliverGrid.count(
            //                   mainAxisSpacing: 8,
            //                   crossAxisSpacing: 8,
            //                   crossAxisCount: 2,
            //                   childAspectRatio: 0.8,
            //                   // physics: ClampingScrollPhysics(),
            //                   children: [
            //                     Container(
            //                       height: 250.0,
            //                       width: 150.0,
            //                       color: Colors.amber.withOpacity(.6),
            //                     ),
            //                     Container(
            //                       height: 250.0,
            //                       width: 150.0,
            //                       color: Colors.yellow,
            //                     ),
            //                     Container(
            //                       height: 250.0,
            //                       width: 150.0,
            //                       color: Colors.red,
            //                     ),
            //                     Container(
            //                       height: 250.0,
            //                       width: 150.0,
            //                       color: Colors.tealAccent[400],
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 height: 500.0,
            //                 width: double.infinity,
            //                 // color: Colors.blue.withOpacity(.6),
            //                 // child: TopCarouselSlider(bgColor: null),
            //               ),
            //             ])),

            //             //   ),
            //           ),
            //         ],
            //       );
            //     })));
            //      SliverList(
            //       delegate: SliverChildBuilderDelegate(
            //           (context, _) => Column(children: [
            //                 Container(
            //                   height: 200.0,
            //                   width: double.infinity,
            //                   // color: Colors.blue.withOpacity(.6),
            //                   // child: TopCarouselSlider(bgColor: null),
            //                 ),
            //                 //
            //                 Container(
            //                   height: MediaQuery.of(context).size.width * 1,
            //                   width: MediaQuery.of(context).size.width * 0.90,
            //                   color: Colors.blue,
            //                   //
            //                   child: GridView.count(
            //                     mainAxisSpacing: 8,
            //                     crossAxisSpacing: 8,
            //                     crossAxisCount: 2,
            //                     childAspectRatio: 0.8,
            //                     physics: ClampingScrollPhysics(),
            //                     children: [
            //                       Container(
            //                         height: 250.0,
            //                         width: 150.0,
            //                         color: Colors.amber.withOpacity(.6),
            //                       ),
            //                       Container(
            //                         height: 250.0,
            //                         width: 150.0,
            //                         color: Colors.yellow,
            //                       ),
            //                       Container(
            //                         height: 250.0,
            //                         width: 150.0,
            //                         color: Colors.red,
            //                       ),
            //                       Container(
            //                         height: 250.0,
            //                         width: 150.0,
            //                         color: Colors.tealAccent[400],
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 Container(
            //                   height: 500.0,
            //                   width: double.infinity,
            //                   // color: Colors.blue.withOpacity(.6),
            //                   // child: TopCarouselSlider(bgColor: null),
            //                 ),
            //               ])),
            //     ),
            //   ),
            // );
            // return Container(
            //   color: Colors.white,
            //   child: Center(
            //     child: LayoutBuilder(
            //       builder: (context, boxConstraints) => Render3dObject(
            //         'assets/file.obj',
            //         asset: true,
            //         size:
            //             Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
            //         // zoom: 10000,
            //       ),
            //     ),
            //   ),
            // );
            // SliverAnimatedList
            // return Container(
            //     width: mediaQuery.size.width,
            //     height: mediaQuery.size.height,
            //     color: Colors.yellow,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Container(
            //           height: 100,
            //           color: Colors.cyan,
            //         ),
            //         Container(
            //             width: mediaQuery.size.width,
            //             height: mediaQuery.size.height - 206,
            //             child: Painter())
            //       ],
            //     ));
            // return Container(
            //     child: RefreshIndicator(
            //   onRefresh: () async {
            //     if (!refreshing) {
            //       print('refresh top');
            //       refreshing = true;
            //       await Future.delayed(Duration(seconds: 4));
            //       refreshing = false;
            //     }
            //   },
            //   child: BottomRefreshIndicator(
            //     onRefresh: () async {
            //       if (!refreshing) {
            //         print('refresh');
            //         refreshing = true;
            //         await Future.delayed(Duration(seconds: 4));
            //         refreshing = false;
            //       }
            //     },
            //     child: custom.SnappingListView.builder(
            //       itemBuilder: (context, index, progress, maxHeight) {
            //         return Container(
            //           margin: EdgeInsets.symmetric(vertical: 5),
            //           // height: 100,
            //           decoration: BoxDecoration(
            //               color: Color.lerp(Colors.red[200],
            //                   Colors.deepPurple[300], index / 15)),
            //         );
            //       },
            //       itemCount: 15,
            //       scrollDirection: Axis.horizontal,
            //       itemExtent: 100,
            //       maxExtent: 400,
            //     ),
            //   ),
            // ));
            // return Container(
            //   child: Accordion(
            //         title: 'expand',
            //         contentChild: Container(
            //           height: 100,
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(color: Colors.grey),
            //         ),
            //       ),
            // );
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(currentState.hello),
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           selected = !selected;
            //         });
            //       },
            //       child: Container(
            //         child: Text(selected ? 'diselect' : 'select'),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(20))),
            //         padding: EdgeInsets.all(10),
            //       ),
            //     ),
            //     AnimatedContainer(
            //       // width: selected ? 200.0 : 100.0,
            //       // height: selected ? 100.0 : 200.0,
            //       color: selected ? Colors.red : Colors.blue,
            //       // alignment: selected
            //       //     ? Alignment.center
            //       //     : AlignmentDirectional.topCenter,
            //       duration: Duration(seconds: 2),
            //       curve: Curves.fastOutSlowIn,
            //       child: selected
            //           ? Container(
            //               height: 100,
            //               width: MediaQuery.of(context).size.width,
            //               decoration: BoxDecoration(color: Colors.grey),
            //             )
            //           : Container(
            //               height: 20,
            //               width: MediaQuery.of(context).size.width,
            //               // decoration: BoxDecoration(color: Colors.white),
            //             ),
            //     ),
            //     Accordion(
            //       title: 'expand',
            //       contentChild: Container(
            //         height: 100,
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(color: Colors.grey),
            //       ),
            //     )
            //   ],
            // ),
            // );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._testBloc?.add(LoadTestEvent());
  }
}
