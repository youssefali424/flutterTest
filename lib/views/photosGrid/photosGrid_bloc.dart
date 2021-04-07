import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:hospitals/views/photosGrid/index.dart';

class PhotosGridBloc extends Bloc<PhotosGridEvent, PhotosGridState> {
  // todo: check singleton for logic in project
  static final PhotosGridBloc _photosGridBlocSingleton = PhotosGridBloc._internal();
  // final int collectionId;

  factory PhotosGridBloc() {
    return _photosGridBlocSingleton;
  }
  PhotosGridBloc._internal():super(UnPhotosGridState(0));
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  PhotosGridState get initialState => UnPhotosGridState(0);

  @override
  Stream<PhotosGridState> mapEventToState(
    PhotosGridEvent event,
  ) async* {
    try {
      yield* await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'PhotosGridBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
