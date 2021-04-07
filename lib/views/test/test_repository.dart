import 'package:hospitals/views/test/index.dart';

class TestRepository {
  final TestProvider _testProvider = TestProvider();

  TestRepository();

  void test(bool isError) {
    _testProvider.test(isError);
  }
}