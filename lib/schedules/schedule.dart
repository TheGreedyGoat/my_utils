import 'package:my_utils/language/language_model.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:my_utils/utility/interval.dart';

/// base class to create reoccuring events, appointments etc.
abstract class Schedule {
  /// From this date on the [Schedule] is considered valid. [recurrenceZero]
  /// is not nessecarily the first appointment, but it can be
  final DateTime recurrenceZero;

  /// If this date is set, there will be no appointments after that
  ///
  final DateTime? validTo;

  int get stepsPerRecurrence;
  ScheduleType get type;

  /// for specific data like weekdays
  List<int>? get specifics;

  /// base class to create reoccuring events, appointments etc.
  const Schedule({required this.recurrenceZero, this.validTo});

  /// moves [n] [recurrenceStep]s from [recurrenceZero] and returns the resulting DateTime.
  ///
  /// This method goes beyond this Schedules limits
  DateTime getNthRecurrenceDate(int n);

  List<DateTime> getReccurrenceDates(TimeInterval interval);

  /// Returns the last recurrence befor the passed [date].
  ///
  /// If [date] is after [validTo], the last recurrence before that is returned.
  ///
  /// Returns a negative value, if [date] is before [recurrenceZero]
  DateTime getCurrentRecurrence(DateTime date) =>
      getNthRecurrenceDate(getCurrentRecurrenceIndex(date));

  /// returns the index of the most recent recurrence n before [date]
  ///
  /// [recurrenceZero] has the index n = 0
  int getCurrentRecurrenceIndex(DateTime date);

  /// Returns all appointments based on the passed [recurrenceDate].
  ///
  /// To make sure to actually pass a [recurrenceDate], pass it through getLastRecurrenceBefore first
  List<DateTime> getAppointmentsFromRecurrence(DateTime recurrenceDate);

  /// Returns all found appointments within the given [interval].
  ///
  List<DateTime> getAppointments(TimeInterval interval) {
    final recDates = getReccurrenceDates(interval);
    return recDates
        .expand(
          // get All the appointments
          (recurrence) => getAppointmentsFromRecurrence(recurrence),
        )
        // ensure only within interval
        .where(
          (date) =>
              interval.containsDate(date) &&
              //ensure not before first
              date.isAfterOrSame(recurrenceZero),
        )
        .toList();
  }

  DateTime getNextAppointment(DateTime date) {
    final n = getCurrentRecurrenceIndex(date);
    final current = getNthRecurrenceDate(n);
    final nextRecurrence = getNthRecurrenceDate(n + 1);
    final appointments = [
      ...getAppointmentsFromRecurrence(current),
      ...getAppointmentsFromRecurrence(nextRecurrence),
    ];
    return appointments.firstWhere(
      (app) => app.isAfter(date),
    );
  }

  DateTime getPreviousAppointment(DateTime date) {
    final n = getCurrentRecurrenceIndex(date);
    final previousRecurrence = getNthRecurrenceDate(n - 1);
    final current = getNthRecurrenceDate(n);
    final appointments = [
      ...getAppointmentsFromRecurrence(previousRecurrence),
      ...getAppointmentsFromRecurrence(current),
    ];
    return appointments.lastWhere(
      (app) => app.isBeforeOrSame(date),
    );
  }

  TimeInterval currentAppointmentInterval(DateTime date) => TimeInterval(
    from: getPreviousAppointment(date),
    toExclusive: getNextAppointment(date),
  );

  @override
  String toString() =>
      '${runtimeType}\n firstRecurrence: $recurrenceZero\n validTo $validTo';
}

enum ScheduleType {
  daily,
  weekly,
  monthly;

  String unit(Language language) => switch (this) {
    .daily => language.day,
    .weekly => language.week,
    .monthly => language.month,
  };

  String unitPlural(Language language) => switch (this) {
    .daily => language.daysPlural,
    .weekly => language.weeksPlural,
    .monthly => language.monthsPlural,
  };
}
