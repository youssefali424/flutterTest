import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:hospitals/views/hospitalList/index.dart';

class HospitalListBloc extends Bloc<HospitalListEvent, HospitalListState> {
  // todo: check singleton for logic in project
  static final HospitalListBloc _hospitalListBlocSingleton = HospitalListBloc._internal();
  factory HospitalListBloc() {
    return _hospitalListBlocSingleton;
  }
  HospitalListBloc._internal():super(UnHospitalListState(0));
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  HospitalListState get initialState => UnHospitalListState(0);

  @override
  Stream<HospitalListState> mapEventToState(
    HospitalListEvent event,
  ) async* {
    try {
      yield* await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HospitalListBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
