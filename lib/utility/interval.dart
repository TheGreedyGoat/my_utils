import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';

/// Describes a time interval in between two DateTimes
class TimeInterval {
  /// The start timestamp
  final DateTime from;

  /// the end timestamp
  final DateTime toExclusive;

  /// Describes a time interval in between two DateTimes
  const TimeInterval({required this.from, required this.toExclusive});

  ///creates an Interval of a given [Duration] ending at [to]
  ///
  factory TimeInterval.durationTo({
    required DateTime to,
    required Duration durationBefore,
  }) => TimeInterval(from: to.subtract(durationBefore), toExclusive: to);

  /// creates an Interval of a given [Duration] starting at [from]
  factory TimeInterval.durationFrom({
    required DateTime from,
    required Duration durationAfter,
  }) => TimeInterval(from: from, toExclusive: from.add(durationAfter));

  factory TimeInterval.month(int month, int year) {
    return TimeInterval(
      from: DateTime(year, month),
      toExclusive: DateTime(year, month + 1),
    );
  }

  /// returns the duration of the interval
  ///
  /// (similar to the norm as the length of a vector)
  Duration get duration => toExclusive.difference(from);

  List<DateTime> get days => [
    for (
      var date = from;
      date.isBefore(toExclusive);
      date = date.add(Duration(days: 1))
    )
      date.dateOnly(),
  ];

  /// returns true, if [date] is within the interval (inclusive bounds)
  bool containsDate(DateTime date) =>
      date.isAfterOrSame(from) && date.isBeforeOrSame(toExclusive);

  /// returns true, if the two Interval overlap each other (<=> they share at least one point in time)
  bool intersects(TimeInterval other) =>
      containsDate(other.from) || other.containsDate(from);

  /// returns true, if [other] is a subinterval of this
  bool contains(TimeInterval other) =>
      containsDate(other.from) && containsDate(other.toExclusive);

  /// returns true, if this is a subInterval of [other] (so i'ts the reverse of [contains])
  bool isSubInterval(TimeInterval other) => other.contains(this);

  TimeInterval? intersection(TimeInterval other) {
    if (!intersects(other)) return null;
    // take the latest from/ earliest to from each
    final from = this.from.isAfter(other.from) ? this.from : other.from;
    final to = this.from.isBefore(other.toExclusive)
        ? this.toExclusive
        : other.toExclusive;
    return TimeInterval(from: from, toExclusive: to);
  }

  @override
  String toString() {
    return '${from.toDynamicString('~DD.~MM.~YY')}- ${toExclusive.toDynamicString('~DD.~MM.~YY')}';
  }

  String toDynamicString({
    required String stringPattern,
    required String datePattern,
  }) {
    '~F ~T';

    return (stringPattern
        .replaceAll('~F', from.toDynamicString(datePattern))
        .replaceAll('~T', toExclusive.toDynamicString(datePattern)));
    // return '${from.toDynamicString(datePattern)} - ${toExclusive.toDynamicString(datePattern)}';
  }

  @override
  bool operator ==(Object other) =>
      other is TimeInterval &&
      other.from == from &&
      other.toExclusive == toExclusive;

  @override
  int get hashCode => from.hashCode ^ toExclusive.hashCode;
}
