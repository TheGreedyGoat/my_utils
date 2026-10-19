import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_utils/utility/percent.dart';
import 'package:my_utils/utility/units/unit.dart';

/// an amount of Euros (stored in centicents)
class Euro extends Unit {
  /// the monetary value. 1/100 of a cent
  final int centicents;
  @override
  int get value => centicents;

  /// conversion to cents
  double get cents => centicents / 100.0;

  /// an amount of Euros (stored in centicents)
  const Euro(this.centicents);

  @override
  int get defaultPrecision => 2;

  @override
  int get factor => 10000;

  @override
  String get symbol => '€';

  Euro operator +(Euro other) => Euro(centicents + other.centicents);
  Euro operator -(Euro other) => Euro(centicents + other.centicents);

  Euro operator *(num factor) => Euro((centicents * factor).ceil());
  Euro operator /(num factor) => Euro((centicents / factor).ceil());

  Euro addPercent(Percent percent) => this * (1.0 + percent.permille / 1000);
}

/// JSPN Converter for [KiloWattHour]
class EuroJsonConverter extends JsonConverter<Euro, int> {
  /// JSPN Converter for [KiloWattHour]
  const EuroJsonConverter();
  @override
  Euro fromJson(int value) => Euro(value);

  @override
  int toJson(Euro u) => u.value;
}
