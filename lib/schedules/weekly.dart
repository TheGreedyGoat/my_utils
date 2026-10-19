import 'package:my_utils/schedules/fixed_duration_schedule.dart';
import 'package:my_utils/schedules/schedule.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';

class Weekly extends FixedDurationSchedule {
  final Set<int> weekdays;
  int get weeksPerRecurrence => (recurrenceStep.inDays / 7).round();

  @override
  get specifics => weekdays.toList();

  @override
  ScheduleType get type => ScheduleType.weekly;
  @override
  // TODO: implement stepsPerRecurrence
  int get stepsPerRecurrence => weeksPerRecurrence;
  Weekly({
    required super.recurrenceZero,
    required int weeksPerRecurrence,
    super.validTo,
    required this.weekdays,
  }) : super(recurrenceStep: Duration(days: 7 * weeksPerRecurrence));

  @override
  List<DateTime> getAppointmentsFromRecurrence(DateTime recurrenceDate) {
    final start = recurrenceDate.lastWeekDay(1);
    return weekdays
        .map(
          (weekday) => start.nextWeekday(weekday),
        )
        .toList();
  }

  @override
  String toString() {
    return '${super.toString()}\nevery $weeksPerRecurrence. week';
  }
}
