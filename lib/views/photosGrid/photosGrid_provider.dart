import 'dart:async';

import 'package:hospitals/models/collectionPhoto.dart';
import 'package:hospitals/network/networkService.dart';

class PhotosGridProvider {
  Future<List<CollectionPhoto>> loadAsync(String id) async {
    /// write from keystore/keychain
    return (await fetchList<CollectionPhoto>('collections/$id/photos')).toList();
  }

  Future<void> saveAsync(String token) async {
    /// write from keystore/keychain
    await Future.delayed(Duration(seconds: 2));
  }

  void test(bool isError) {
    if (isError == true){
      throw Exception('manual error');
    }
  }
}

