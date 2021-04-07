import 'dart:async';

import 'package:hospitals/models/collection.dart';
import 'package:hospitals/views/hospitalList/index.dart';
import 'package:built_collection/built_collection.dart';

class HospitalListRepository {
  final HospitalListProvider _hospitalListProvider = HospitalListProvider();

  HospitalListRepository();

  void test(bool isError) {
    this._hospitalListProvider.test(isError);
  }

  Future<BuiltList<Collection>> loadAsync() async {
    /// write from keystore/keychains
    return await _hospitalListProvider.loadAsync();
  }
}
