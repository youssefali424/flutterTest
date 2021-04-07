import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:hospitals/views/test/index.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
static final TestBloc _testBlocSingleton = TestBloc._internal();
  // final int collectionId;

  factory TestBloc() {
    return _testBlocSingleton;
  }
  TestBloc._internal():super(UnTestState());
  // TestBloc(TestState initialState) : super();

  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'TestBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }

  @override
  // TODO: implement initialState
  TestState get initialState => UnTestState();
}
