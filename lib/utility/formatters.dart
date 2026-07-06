import 'dart:math';

import 'package:flutter/services.dart';

/// povides a couple of functions for specific text input formats aswell as converting data from and to different representations
class Formatters {
  const Formatters._();
  static RegExp doubleInputRegExp(int fractionDigits) =>
      RegExp(r'^\d+[.,]?\d{0,#}|^$'.replaceAll('#', fractionDigits.toString()));

  static TextInputFormatter fixedDigitsDoubleFormatter(int fractions) {
    return FilteringTextInputFormatter.allow(doubleInputRegExp(fractions));
  }

  static String displayDouble(
    double d, {
    int fractionDigits = 2,
    String prefix = '',
    String suffix = '',
  }) => '$prefix ${d.toStringAsFixed(2)} $suffix';

  /// converts a double to an integer representation.
  static int doubleToInt(double value, int fractionDigits) {
    return (value * pow(10, fractionDigits)).round();
  }

  /// converts an integer representation back to a double
  static double intToDouble(int value, int fractionDigits) {
    return value.toDouble() / pow(10, fractionDigits);
  }
}
