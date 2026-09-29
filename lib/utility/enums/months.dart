enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  Month get next => values[(this.index + 1) % values.length];
  static Month fromDateTime(DateTime dateTime) => values[dateTime.month - 1];
}
