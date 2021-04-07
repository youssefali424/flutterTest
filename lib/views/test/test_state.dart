import 'package:equatable/equatable.dart';

abstract class TestState extends Equatable {

  final List propss;
  TestState([this.propss]);

  @override
  List<dynamic> get props => (propss ?? []);
}

/// UnInitialized
class UnTestState extends TestState {

  UnTestState();

  @override
  String toString() => 'UnTestState';
}

/// Initialized
class InTestState extends TestState {
  final String hello;

  InTestState(this.hello) : super([hello]);

  @override
  String toString() => 'InTestState $hello';

}

class ErrorTestState extends TestState {
  final String errorMessage;

  ErrorTestState(this.errorMessage): super([errorMessage]);
  
  @override
  String toString() => 'ErrorTestState';
}
