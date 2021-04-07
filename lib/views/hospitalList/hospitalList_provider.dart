import 'dart:async';

import 'package:hospitals/models/collection.dart';
import 'package:hospitals/network/networkService.dart';
import 'package:built_collection/built_collection.dart';

class HospitalListProvider {
  Future<BuiltList<Collection>> loadAsync() async {
    /// write from keystore/keychain
    return await fetchList('collections');
  }

  Future<void> saveAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  void test(bool isError) {
    if (isError == true) {
      throw Exception('manual error');
    }
  }
}
