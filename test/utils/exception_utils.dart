import 'package:flutter_test/flutter_test.dart';

expectException<T>(Function function) {
  expect(function, throwsA(isA<T>()));
}
