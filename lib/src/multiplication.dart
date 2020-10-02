import 'dart:math';

abstract class IMultiplication {
  String randomCalc();
  int getCurrentResult();
}

class Multiplication implements IMultiplication {
  int _leftNumber;
  int _rightNumber;

  String randomCalc() {
    _leftNumber = Random().nextInt(11);
    _rightNumber = Random().nextInt(11);
    return '$_leftNumber X $_rightNumber =';
  }

  int getCurrentResult() {
    return _leftNumber * _rightNumber;
  }
}
