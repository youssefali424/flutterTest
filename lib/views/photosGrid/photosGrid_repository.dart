import 'package:hospitals/models/collectionPhoto.dart';
import 'package:hospitals/views/photosGrid/index.dart';

class PhotosGridRepository {
  final PhotosGridProvider _photosGridProvider = PhotosGridProvider();

  PhotosGridRepository();

  void test(bool isError) {
    this._photosGridProvider.test(isError);
  }
  Future<List<CollectionPhoto>> loadAsync(String id) async {
    /// write from keystore/keychain
    return await _photosGridProvider.loadAsync(id);
  }
}