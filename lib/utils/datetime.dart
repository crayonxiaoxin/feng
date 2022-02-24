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
