import 'package:my_utils/schedules/schedule.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:my_utils/utility/interval.dart';
import 'package:my_utils/utility/logger/logger.dart';

class Monthly extends Schedule {
  final Set<int> days;
  final int monthsPerRecurrence;

  @override
  get specifics => days.toList();

  @override
  ScheduleType get type => .monthly;
  const Monthly({
    required super.recurrenceZero,
    required this.monthsPerRecurrence,
    super.validTo,
    required this.days,
  });

  @override
  int getCurrentRecurrenceIndex(DateTime date) {
    if (validTo != null && date.isAfter(validTo!)) {
      return getCurrentRecurrenceIndex(validTo!);
    }
    final deltaMonth = (date.year - recurrenceZero.year) * 12 + date.month;
    return ((deltaMonth - recurrenceZero.month) / monthsPerRecurrence).floor();
  }

  @override
  /// returns all recurrence dates starting at the last one before the interval's start (since that recurrence may have appointments within the interval)
  /// and efor it's end
  List<DateTime> getReccurrenceDates(TimeInterval interval) {
    final logger = Logger(Monthly, 'getReccurrenceDates', false);

    final result = List<DateTime>.empty(growable: true);
    final startRecurrence = getCurrentRecurrence(interval.from); //
    logger.call('interval.from: ${interval.from}', 0, false);
    logger.call('interval.to: ${interval.toExclusive}');
    logger.call('firstRecurrence: ${recurrenceZero}');
    logger.call('startRecurrence: ${startRecurrence}');
    // the earlier of both
    final stopDate =
        this.validTo == null || this.validTo!.isAfter(interval.toExclusive)
        ? interval.toExclusive
        : this.validTo!; // the earlier of both
    for (
      //jump to the next 1st of month
      DateTime date = startRecurrence;
      date.isBefore(stopDate);
      date = DateTime(date.year, date.month + monthsPerRecurrence, 1)
    ) {
      result.add(date);
    }
    logger.call(result);
    return result;
  }

  @override
  List<DateTime> getAppointmentsFromRecurrence(DateTime recurrenceDate) => days
      .map(
        (day) {
          return recurrenceDate.daysOfMonth >= day
              ? DateTime(recurrenceDate.year, recurrenceDate.month, day)
              : DateTime(
                  recurrenceDate.year,
                  recurrenceDate.month + 1, // leave +1
                  0,
                ); // clamp to the end of month
        },
      )
      .where(
        (date) => date.isAfterOrSame(recurrenceDate),
      )
      .toList();

  @override
  DateTime getNthRecurrenceDate(int n) {
    return DateTime(
      recurrenceZero.year,
      recurrenceZero.month + n * monthsPerRecurrence,
      1,
    );
  }

  @override
  String toString() {
    return '${super.toString()}\n every $monthsPerRecurrence. month \ndays: $days';
  }

  @override
  int get stepsPerRecurrence => monthsPerRecurrence;
}
