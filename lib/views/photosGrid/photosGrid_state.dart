import 'package:equatable/equatable.dart';
import 'package:hospitals/models/collectionPhoto.dart';

abstract class PhotosGridState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  PhotosGridState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  PhotosGridState getStateCopy();

  PhotosGridState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnPhotosGridState extends PhotosGridState {

  UnPhotosGridState(int version) : super(version);

  @override
  String toString() => 'UnPhotosGridState';

  @override
  UnPhotosGridState getStateCopy() {
    return UnPhotosGridState(0);
  }

  @override
  UnPhotosGridState getNewVersion() {
    return UnPhotosGridState(version+1);
  }
}

/// Initialized
class InPhotosGridState extends PhotosGridState {
  final List<CollectionPhoto> photos;

  InPhotosGridState(int version, this.photos) : super(version, [photos]);

  @override
  String toString() => 'InPhotosGridState ${photos.length}';

  @override
  InPhotosGridState getStateCopy() {
    return InPhotosGridState(this.version, this.photos);
  }

  @override
  InPhotosGridState getNewVersion() {
    return InPhotosGridState(version+1, this.photos);
  }
}

class ErrorPhotosGridState extends PhotosGridState {
  final String errorMessage;

  ErrorPhotosGridState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorPhotosGridState';

  @override
  ErrorPhotosGridState getStateCopy() {
    return ErrorPhotosGridState(this.version, this.errorMessage);
  }

  @override
  ErrorPhotosGridState getNewVersion() {
    return ErrorPhotosGridState(version+1, this.errorMessage);
  }
}
