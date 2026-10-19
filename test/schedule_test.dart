import 'package:flutter_test/flutter_test.dart';
import 'package:my_utils/schedules/daily.dart';
import 'package:my_utils/schedules/monthly.dart';
import 'package:my_utils/schedules/schedule.dart';
import 'package:my_utils/schedules/weekly.dart';

void main() {
  generalScheduleTests();
  testNextAppointment();
}

void generalScheduleTests() {
  final groupName = 'GENERAL SCHEDULE TESTS';
  group(
    groupName,
    () {
      final recurrenceZero = DateTime(2026, 1, 1);
      for (int i = 0; i < 7; i++) {
        scheduleTestGeneralSchema(
          Daily(
            recurrenceZero: recurrenceZero,
            daysPerRecurrence: i + 1,
          ),
          '$groupName (Daily, $i)',
        );
      }

      for (int weeks = 1; weeks < 6; weeks++) {
        scheduleTestGeneralSchema(
          Weekly(
            recurrenceZero: recurrenceZero,
            weeksPerRecurrence: weeks,
            weekdays: {1},
          ),
          '$groupName (Weekly, $weeks)',
        );
      }

      for (int months = 1; months < 6; months++) {
        scheduleTestGeneralSchema(
          Monthly(
            recurrenceZero: recurrenceZero,
            monthsPerRecurrence: months,
            days: {2},
          ),
          '$groupName (Monthly, $months)',
        );
      }
    },
  );
}

void scheduleTestGeneralSchema(Schedule schedule, String groupName) {
  test(
    '$groupName: n resolves to correct recurrence dates',
    () {
      expect(
        schedule.getNthRecurrenceDate(0),
        equals(schedule.recurrenceZero),
        reason: 'recurrence index n should resolve to value of recurrenceZero',
      );

      for (int n = -2; n <= 2; n++) {
        final recDate = schedule.getNthRecurrenceDate(n);
        expect(
          schedule.getCurrentRecurrenceIndex(recDate),
          equals(n),
          reason:
              'index => recurrenceDate should be the inverse to recurrenceDate => index',
        );
      }
    },
  );
}

void testNextAppointment() {
  final groupDescr =
      'Schedules return the correct next appointments to a given date';
  group(
    groupDescr,
    () {
      final recurrenceZero = DateTime(2026, 1, 1);

      _testNextAppointmentSchema(
        Daily(
          recurrenceZero: recurrenceZero,
          daysPerRecurrence: 1,
        ),
        DateTime(2026, 1, 8),
        Duration(days: 1),
        [
          DateTime(2026, 1, 1),
          DateTime(2026, 1, 2),
          DateTime(2026, 1, 3),
          DateTime(2026, 1, 4),
          DateTime(2026, 1, 5),
          DateTime(2026, 1, 6),
          DateTime(2026, 1, 7),
        ],
        'Every day',
      );
      _testNextAppointmentSchema(
        Daily(
          recurrenceZero: recurrenceZero,
          daysPerRecurrence: 3,
        ),
        DateTime(2026, 1, 8),
        Duration(days: 1),
        [
          DateTime(2026, 1, 1),
          DateTime(2026, 1, 4),
          DateTime(2026, 1, 4),
          DateTime(2026, 1, 4),
          DateTime(2026, 1, 7),
          DateTime(2026, 1, 7),
          DateTime(2026, 1, 7),
        ],
        'Every 3rd day',
      );
      _testNextAppointmentSchema(
        Monthly(
          recurrenceZero: recurrenceZero,
          monthsPerRecurrence: 1,
          days: {1, 15, 31},
        ),
        DateTime(2026, 3, 1),
        Duration(days: 7),
        [
          DateTime(2026, 1, 1),
          DateTime(2026, 1, 15),
          DateTime(2026, 1, 15),
          DateTime(2026, 1, 31),
          DateTime(2026, 1, 31),
          DateTime(2026, 2, 15),
          DateTime(2026, 2, 15),
          DateTime(2026, 2, 28),
          DateTime(2026, 2, 28),
        ],
        'Every Month',
      );
    },
  );
}

void _testNextAppointmentSchema(
  Schedule schedule,
  DateTime endDate,
  Duration timeStep,
  List<DateTime> expectedAppointments,
  String description,
) {
  test(
    description,
    () {
      final result = [
        for (
          DateTime date = DateTime(2026, 1, 1);
          date.isBefore(endDate);
          date = date.add(timeStep)
        )
          schedule.getNextAppointment(date),
      ];

      expect(result, equals(expectedAppointments));
    },
  );
}
