import 'package:flutter/material.dart';
import 'package:hospitals/util/colorUtil.dart';
import 'package:hospitals/views/hospitalList/index.dart';

class HospitalListPage extends StatefulWidget {
  static const String routeName = '/hospitalList';
  @override
  _HospitalListPageState createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {
  final _hospitalListBloc = HospitalListBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexToColor('#363795'),
        title: Text('Collections'),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [hexToColor('#005C97'), hexToColor('#363795')])),
          child: HospitalListScreen(hospitalListBloc: _hospitalListBloc)),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _hospitalListBloc.close();
    super.dispose();
  }
}
