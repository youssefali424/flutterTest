import 'package:equatable/equatable.dart';
import 'package:hospitals/models/collection.dart';
import 'package:hospitals/models/user.dart';

abstract class HospitalListState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  HospitalListState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  HospitalListState getStateCopy();

  HospitalListState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnHospitalListState extends HospitalListState {
  
  UnHospitalListState(int version) : super(version);

  @override
  String toString() => 'UnHospitalListState';

  @override
  UnHospitalListState getStateCopy() {
    return UnHospitalListState(0);
  }

  @override
  UnHospitalListState getNewVersion() {
    return UnHospitalListState(version+1);
  }
}

/// Initialized
class InHospitalListState extends HospitalListState {
  final List<Collection> collections;

  InHospitalListState(int version, this.collections) : super(version, [collections]);

  @override
  String toString() => 'InHospitalListState ${collections.length}';

  @override
  InHospitalListState getStateCopy() {
    return InHospitalListState(this.version, this.collections);
  }

  @override
  InHospitalListState getNewVersion() {
    return InHospitalListState(version+1, this.collections);
  }
}

class ErrorHospitalListState extends HospitalListState {
  final String errorMessage;

  ErrorHospitalListState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorHospitalListState';

  @override
  ErrorHospitalListState getStateCopy() {
    return ErrorHospitalListState(this.version, this.errorMessage);
  }

  @override
  ErrorHospitalListState getNewVersion() {
    return ErrorHospitalListState(version+1, this.errorMessage);
  }
}
