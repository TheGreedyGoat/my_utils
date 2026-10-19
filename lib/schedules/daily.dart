import 'package:my_utils/schedules/fixed_duration_schedule.dart';
import 'package:my_utils/schedules/schedule.dart';

class Daily extends FixedDurationSchedule {
  @override
  int get stepsPerRecurrence => recurrenceStep.inDays;
  @override
  ScheduleType get type => ScheduleType.daily;

  @override
  get specifics => null;

  Daily({
    required super.recurrenceZero,
    required int daysPerRecurrence,
    super.validTo,
  }) : super(recurrenceStep: Duration(days: daysPerRecurrence));

  @override
  List<DateTime> getAppointmentsFromRecurrence(DateTime recurrenceDate) => [
    recurrenceDate,
  ];

  @override
  String toString() {
    return '${super.toString()}\nevery $stepsPerRecurrence. day';
  }
}
