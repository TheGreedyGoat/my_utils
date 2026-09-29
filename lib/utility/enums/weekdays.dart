enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  Weekday get next => values[(this.index + 1) % values.length];
  static Weekday fromDateTime(DateTime dateTime) =>
      values[dateTime.weekday - 1];
}
