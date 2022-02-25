String twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}

String formatDate(int y, int m, int d, {String sep = "-"}) {
  return "$y$sep${twoDigits(m)}$sep${twoDigits(d)}";
}

String formatMonthDay(int m, int d) {
  return "${twoDigits(m)}月${twoDigits(d)}日";
}

int fallInLoveDays() {
  var startDate = DateTime(2020, 4, 21);
  var endDate = DateTime.now();
  var days = endDate.difference(startDate).inDays + 1;
  return days;
}

String fallInLoveYears() {
  var days = fallInLoveDays();
  return (days / 365).toStringAsFixed(3);
}

String fallInLoveMonths() {
  var days = fallInLoveDays();
  return (days / 30).toStringAsFixed(3);
}
