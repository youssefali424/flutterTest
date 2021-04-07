import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hospitals/models/collection.dart';
import 'package:hospitals/util/colorUtil.dart';
import 'package:hospitals/views/hospitalList/index.dart';
import 'package:hospitals/views/photosGrid/index.dart';
import 'package:peek_and_pop/misc.dart' as PeekAndPopMisc;

import 'package:transparent_image/transparent_image.dart';

import 'PopAndPeek.dart';

class HospitalListScreen extends StatefulWidget {
  const HospitalListScreen({
    Key key,
    @required HospitalListBloc hospitalListBloc,
  })  : _hospitalListBloc = hospitalListBloc,
        super(key: key);

  final HospitalListBloc _hospitalListBloc;

  @override
  HospitalListScreenState createState() {
    return HospitalListScreenState();
  }
}

class HospitalListScreenState extends State<HospitalListScreen> {
  HospitalListScreenState();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showDialogPeek(String id) {
    // GlobalKey  key = GlobalKey ();
    // RenderBox box = key.currentContext.findRenderObject();
    // Offset position = box.localToGlobal(Offset.zero);
    // showDialog(
    //     context: context,
    //     builder: (cx) =>
    //         RepaintBoundary(key: PeekAndPopMisc.background, child: child));
  }

  @override
  Widget build(BuildContext context) {
    // double width=med
    return BlocBuilder<HospitalListBloc, HospitalListState>(
        bloc: widget._hospitalListBloc,
        builder: (
          BuildContext context,
          HospitalListState currentState,
        ) {
          if (currentState is UnHospitalListState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorHospitalListState) {
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
          if (currentState is InHospitalListState) {
            return Center(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: currentState.collections.length,
                itemBuilder: (BuildContext context, int index) {
                  Collection collection = currentState.collections[index];
                  return Stack(children: <Widget>[
                    Card(
                        shape: CircleBorder(),
                        child: Container(
                            height: 75,
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      hexToColor('#005C97'),
                                      hexToColor('#363795')
                                    ])),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.contain,
                                      imageUrl:
                                          collection.user.profileImage.small,
                                      placeholder: (context, url) =>
                                          // Loading(indicator: BallSpinFadeLoaderIndicator(), size: 1,color:hexToColor('#363795'),)
                                          // LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader, color: Colors.white,)
                                          SpinKitThreeBounce(
                                        color: hexToColor('#363795'),
                                        size: 30.0,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(collection.title,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: hexToColor('#FFFFFF'),
                                            )),
                                        Text(
                                          'photos : ${collection.totalPhotos}',
                                          textAlign: TextAlign.start,
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  200, 200, 200, 0.5)),
                                        )
                                      ],
                                    ))
                              ],
                            ))),
                    Positioned.fill(
                        child: Material(
                            type: MaterialType.transparency,
                            child: PopAndPeek(
                              key: ValueKey(collection.id),
                              popUp: PhotosGridPage(id: collection.id),
                              child: InkWell(
                                // radius: 20,
                                borderRadius: BorderRadius.circular(20),
                                // onLongPress: () {
                                //   print("long press");
                                //   showDialogPeek(collection.id);
                                // },
                                onTap: () {
                                  print("press");
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         PhotosGridPage(collection.id),
                                  //   ),
                                  // );
                                  Navigator.pushNamed(
                                    context,
                                    PhotosGridPage.routeName,
                                    arguments: collection.id,
                                  );
                                },
                              ),
                            )))
                  ]);
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._hospitalListBloc.add(LoadHospitalListEvent(isError));
  }
}
