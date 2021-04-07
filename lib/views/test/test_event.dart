import 'dart:async';
import 'dart:developer' as developer;

import 'package:hospitals/views/test/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TestEvent {
  Stream<TestState> applyAsync({TestState currentState, TestBloc bloc});
}

class UnTestEvent extends TestEvent {
  @override
  Stream<TestState> applyAsync(
      {TestState currentState, TestBloc bloc}) async* {
    yield UnTestState();
  }
}

class LoadTestEvent extends TestEvent {
  @override
  Stream<TestState> applyAsync(
      {TestState currentState, TestBloc bloc}) async* {
    try {
      yield UnTestState();
      await Future.delayed(Duration(seconds: 1));
      yield InTestState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      yield ErrorTestState(_?.toString() ?? '');
    }
  }
}
