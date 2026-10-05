import 'package:flutter_test/flutter_test.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';

void main() {
  group('Tests for DateTime Extensions', () {
    test(
      'Finding the next monday for a whole week works properly',
      () {
        final results = List<DateTime>.empty(growable: true);
        for (int i = 0; i < 7; i++) {
          results.add(
            DateTime(2026, 10, 5).add(Duration(days: i)).nextWeekday(1),
          );
        }
        final expected = equals([
          DateTime(2026, 10, 5),
          DateTime(2026, 10, 12),
          DateTime(2026, 10, 12),
          DateTime(2026, 10, 12),
          DateTime(2026, 10, 12),
          DateTime(2026, 10, 12),
          DateTime(2026, 10, 12),
        ]);
        expect(
          results,
          expected,
        );
      },
    );
    test(
      'Finding the last monday for a whole week works properly',
      () {
        final results = List<DateTime>.empty(growable: true);
        for (int i = 0; i < 7; i++) {
          results.add(
            DateTime(2026, 10, 12).subtract(Duration(days: i)).lastWeekDay(1),
          );
        }
        final expected = equals([
          DateTime(2026, 10, 12),
          DateTime(2026, 10, 5),
          DateTime(2026, 10, 5),
          DateTime(2026, 10, 5),
          DateTime(2026, 10, 5),
          DateTime(2026, 10, 5),
          DateTime(2026, 10, 5),
        ]);
        expect(
          results,
          expected,
        );
      },
    );
  });
}
