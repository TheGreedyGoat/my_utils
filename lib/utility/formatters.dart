import 'package:flutter/services.dart';

class Formatters {
  const Formatters._();
  static RegExp doubleInputRegExp(int fractionDigits) =>
      RegExp(r'^\d+[.,]?\d{0,#}|^$'.replaceAll('#', fractionDigits.toString()));

  static TextInputFormatter doubleFormatter(int fractions) {
    return FilteringTextInputFormatter.allow(doubleInputRegExp(fractions));
  }

  static String displayDouble(
    double d, {
    int fractionDigits = 2,
    String prefix = '',
    String suffix = '',
  }) => '$prefix ${d.toStringAsFixed(2)} $suffix';
}
