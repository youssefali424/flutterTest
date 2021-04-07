import 'dart:async';
import 'dart:developer' as developer;

import 'package:hospitals/models/collection.dart';
import 'package:hospitals/models/user.dart';
import 'package:hospitals/views/hospitalList/index.dart';
import 'package:meta/meta.dart';
import 'package:built_collection/built_collection.dart';

@immutable
abstract class HospitalListEvent {
  Stream<HospitalListState> applyAsync(
      {HospitalListState currentState, HospitalListBloc bloc});
  final HospitalListRepository _hospitalListRepository =
      HospitalListRepository();
}

class UnHospitalListEvent extends HospitalListEvent {
  @override
  Stream<HospitalListState> applyAsync(
      {HospitalListState currentState, HospitalListBloc bloc}) async* {
    yield UnHospitalListState(0);
  }
}

class LoadHospitalListEvent extends HospitalListEvent {
  final bool isError;
  @override
  String toString() => 'LoadHospitalListEvent';

  LoadHospitalListEvent(this.isError);

  @override
  Stream<HospitalListState> applyAsync(
      {HospitalListState currentState, HospitalListBloc bloc}) async* {
    try {
      yield UnHospitalListState(0);
      // await Future.delayed(Duration(seconds: 1));
      List<Collection> collections =
          (await this._hospitalListRepository.loadAsync()).toList();
      developer.log('Collections', name: collections.toString());
      yield InHospitalListState(0, collections);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadHospitalListEvent', error: _, stackTrace: stackTrace);
      yield ErrorHospitalListState(0, _?.toString());
    }
  }
}
