import 'package:my_utils/utility/formatters.dart';

/// provides functions to convert between cents- and euro representations and for display
class MoneyConverter {
  MoneyConverter._();

  static int euroToCents(double euros) => Formatters.doubleToInt(euros, 2);
  static double centsToEuros(int cents) => Formatters.intToDouble(cents, 2);

  static String centsToEutoDisplay(int cents) =>
      Formatters.displayDouble(centsToEuros(cents), prefix: '€');
}
