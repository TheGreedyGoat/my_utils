import 'package:my_utils/schedules/schedule.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:my_utils/utility/interval.dart';

/// A class to represent reoccuring events/ appointments
///
/// ## Usage:
///
/// define [recurrenceZero] as a first date and [recurrenceStep] to define when this schedule starts and the period of reoccurence.
///
/// [recurrenceZero] itself and any dates that are a positive multiple of [recurrenceStep] after [recurrenceZero] are so called 'reocurrence dates'
/// Those are not nessecarily the dates of the appointments (although they can be), they rather serve as points of reference to find the actual appointments.
/// The logic for the latter is to be provided by child classes implementing [getAppointmentsFromRecurrence]
///
/// ### Example:
/// let
///
///  firstRecurrence = DateTime(2026,1,1) and
///
///  reccurrenceStep = Duration(days: 3)
///
/// =>
///
abstract class FixedDurationSchedule extends Schedule {
  /// The general timestep in between reoccurences.
  ///
  /// This is not nessecarily the reoccurence of the appointments,
  /// that's only if the Schedule is something like 'once every n days/ weeks'
  ///
  /// Primarily this kind of the point of reference from where to look for appointments
  ///
  /// eg if [recurrenceZero] is set on a monday and the Schedule is 'every 2 weeks on wednesday',
  /// The reoccurrence steps will only lead to the week that contains the appointment
  ///
  ///
  final Duration recurrenceStep;

  /// Returns when this Schdeule is valid [until] the passed date.
  ///
  /// if this.[validTo] is null, [until] is used as the interval's to - date
  TimeInterval? getValidIntervalUntil(DateTime until) {
    if (recurrenceZero.isAfter(until)) return null;
    final to = validTo == null || validTo!.isAfter(until) ? until : validTo!;
    return TimeInterval(from: recurrenceZero, toExclusive: to);
  }

  /// A class to represent reoccuring events/ appointments
  ///
  FixedDurationSchedule({
    required super.recurrenceZero,
    required this.recurrenceStep,
    super.validTo,
  });

  @override
  int getCurrentRecurrenceIndex(DateTime date) {
    // Ensure we dont return dates after the end
    if (validTo != null && date.isAfter(validTo!)) {
      return getCurrentRecurrenceIndex(validTo!);
    }
    return (date.difference(recurrenceZero).inDays / recurrenceStep.inDays)
        .floor();

    // n < 0 => result would be before the firstRecurrence
  }

  /// moves [n] [recurrenceStep]s from [recurrenceZero] and returns the resulting DateTime.
  ///
  /// This method goes beyond this Schedules limits
  @override
  DateTime getNthRecurrenceDate(int n) =>
      recurrenceZero.add(recurrenceStep * n);

  ///
  @override
  List<DateTime> getReccurrenceDates(TimeInterval interval) {
    final start = getCurrentRecurrence(interval.from) ?? recurrenceZero;
    final stop = DateTimeExtensions.min(
      validTo ?? interval.toExclusive,
      interval.toExclusive,
    );
    final result = List<DateTime>.empty(growable: true);
    for (
      var date = start;
      date.isBefore(stop);
      date = date.add(recurrenceStep)
    ) {
      result.add(date);
    }
    return result;
  }

  /// Returns all appointments based on the passed [recurrenceDate].
  ///
  /// To make sure to actually pass a [recurrenceDate], pass it through getLastRecurrenceBefore first
  @override
  List<DateTime> getAppointmentsFromRecurrence(DateTime recurrenceDate);
}
