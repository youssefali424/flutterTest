import 'dart:async';
import 'dart:developer' as developer;

import 'package:hospitals/models/collectionPhoto.dart';
import 'package:hospitals/views/photosGrid/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhotosGridEvent {
  Stream<PhotosGridState> applyAsync(
      {PhotosGridState currentState, PhotosGridBloc bloc});
  final PhotosGridRepository _photosGridRepository = PhotosGridRepository();
}

class UnPhotosGridEvent extends PhotosGridEvent {
  @override
  Stream<PhotosGridState> applyAsync({PhotosGridState currentState, PhotosGridBloc bloc}) async* {
    yield UnPhotosGridState(0);
  }
}

class LoadPhotosGridEvent extends PhotosGridEvent {
  final String collectionId;
  final bool isError;
  @override
  String toString() => 'LoadPhotosGridEvent';

  LoadPhotosGridEvent(this.isError, this.collectionId);

  @override
  Stream<PhotosGridState> applyAsync(
      {PhotosGridState currentState, PhotosGridBloc bloc}) async* {
    try {
      yield UnPhotosGridState(0);
      List<CollectionPhoto> photos = await this._photosGridRepository.loadAsync(collectionId);
      yield InPhotosGridState(0, photos);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadPhotosGridEvent', error: _, stackTrace: stackTrace);
      yield ErrorPhotosGridState(0, _?.toString());
    }
  }
}
