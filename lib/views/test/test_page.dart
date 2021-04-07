import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hospitals/views/Tabbar/Tabbar.dart' as CustomTabbar;
import 'package:hospitals/views/test/index.dart';

class TestPage extends StatefulWidget {
  static const String routeName = '/test';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin<TestPage> {
  final _testBloc = TestBloc();
  // TabController defaultTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // defaultTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _testBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedFontSize = 20;
    // final double additionalBottomPadding = max(
    //     MediaQuery.of(context).padding.bottom - selectedFontSize / 2.0, 0.0);
    // print(MediaQuery.of(context).padding.bottom);
    return TestScreen(testBloc: _testBloc,);
    // return SafeArea(
    //   maintainBottomViewPadding: true,
    //   bottom: true,
    //   top: true,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Test'),
    //     ),
    //     // body: TestScreen(testBloc: _testBloc),
    //     body: SafeArea(
    //       bottom: true,
    //       top: true,
    //       child: TestScreen(testBloc: _testBloc,)
    //     ),
    //     // BottomNavigationBar
    //     bottomNavigationBar: Semantics(
    //       explicitChildNodes: true,
    //       child: Container(
    //         color: Color(0xFF3F5AA6),
    //         child: CustomTabbar.TabBar(
    //           controller: defaultTabController,
    //           isIndicatorAtBottom: false,
    //           tabs: [
    //             Tab(icon: Icon(Icons.directions_car)),
    //             Tab(icon: Icon(Icons.directions_transit)),
    //             Tab(icon: Icon(Icons.directions_bike)),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
