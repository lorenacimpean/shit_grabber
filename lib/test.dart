import 'dart:math';

void main() {
  /// Mini exercise;
  /// Now print the value of 1 over the square root of 2 in Dart. Confirm that it equals the sine of 45°.

  double radians = 45.0 * pi / 180;
  double sin45 = sin(radians);
  double testValue = 1 / sqrt(2);

  print(sin45);
  print(testValue);
  print(sin45 == testValue);
}
