import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';

void main() {
  for (int i = 0; i < 7; i++) {
    final date = DateTime(2026, 10, 12).subtract(Duration(days: i));
    print(date.lastWeekDay(1));
  }
}
