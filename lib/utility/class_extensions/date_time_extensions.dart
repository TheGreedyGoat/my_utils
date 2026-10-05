import 'dart:math' as math;

import 'package:my_utils/utility/enums/weekdays.dart';

/// A few extra toStrings for [DateTime]s
extension DateTimeExtensions on DateTime {
  /// Returns the earlier date
  static DateTime min(DateTime a, DateTime b) {
    return a.isBefore(b) ? a : b;
  }

  /// returns the later date
  static DateTime max(DateTime a, DateTime b) {
    return a.isAfter(b) ? a : b;
  }

  /// Pass a pattern to get any numeric date format.
  ///
  /// A pattern could for example look like this:
  ///
  ///  \~DD.\~MM.\~YYYY \~hh:\~mm:\~ss
  ///
  /// Use a ~ and the corresponding char to mark, where and how you want to display wich part of the date.
  ///
  /// The type of char dictates wich data to fill in:
  /// - D => day
  /// - M => month
  /// - Y => year
  /// - h => hours
  /// - m => minutes
  /// - s => seconds
  ///
  /// The number of chars shows the number of digits to display. If the corresponding value has less digits, it gets padded with 0 accordingly.
  ///
  /// eg if the day is 2 and the pattern contains \~DDD, this will  replaced with 002
  ///
  /// numbers with more digits that the pattern will be cut off, eg with \~YY and the year 2026 we get 26
  ///
  /// To display weekdays, use ~WD or ~wd. Upper case inserts the full name, lower case unly th first three chars in Caps eg
  ///
  /// ~WD => Monday
  /// ~wd => MON
  ///
  /// TODO: add support for milli- and microseconds, weekdays and month names
  String toDynamicString(String pattern) {
    pattern = pattern.replaceAll('~WD', weekdayNameEnglish);
    pattern = pattern.replaceAll(
      '~wd',
      weekdayNameEnglish.substring(0, 3).toUpperCase(),
    );
    pattern = _replacePattern(pattern, char: 'D', replace: day.toString());
    pattern = _replacePattern(pattern, char: 'M', replace: month.toString());
    pattern = _replacePattern(pattern, char: 'Y', replace: year.toString());
    pattern = _replacePattern(pattern, char: 'h', replace: hour.toString());
    pattern = _replacePattern(pattern, char: 'm', replace: minute.toString());
    pattern = _replacePattern(pattern, char: 's', replace: second.toString());
    return pattern;
  }

  String _replacePattern(
    String pattern, {
    required String char,
    required String replace,
  }) {
    final RegExp regexp = RegExp('~$char+');
    final matches = regexp
        .allMatches(pattern)
        .where((element) => element.group(0) != null)
        .toList();
    matches.sort((a, b) {
      return -(a.group(0)!.length.compareTo(b.group(0)!.length));
    });

    for (final match in matches) {
      final m = match.group(0)!;
      final lastIndex = replace.length;
      final firstIndex = math.max(0, lastIndex - m.length);
      pattern = pattern.replaceAll(
        m,
        replace
            .substring(firstIndex, lastIndex)
            .padLeft(m.length - 1, '0'), // -1 to account for tht tilde
      );
    }

    return pattern;
  }

  String get weekdayNameEnglish {
    var result = Weekday.values[weekday - 1].toString().split('.')[1];
    return result.replaceFirst(result[0], result[0].toUpperCase());
  }

  bool isBeforeOrSame(DateTime other) =>
      isBefore(other) || isAtSameMomentAs(other);
  bool isAfterOrSame(DateTime other) =>
      isAfter(other) || isAtSameMomentAs(other);

  DateTime dateOnly() => DateTime(this.year, this.month, this.day);

  DateTime nextWeekday(int weekday) {
    return this.add(Duration(days: (weekday - this.weekday + 7) % 7));
  }

  DateTime lastWeekDay(int weekday) {
    return this.subtract(Duration(days: (this.weekday - weekday + 7) % 7));
  }
}
