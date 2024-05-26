DateTime parseTime(String timeString) {
  final parts = timeString.split(':');
  return DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, int.parse(parts[0]), int.parse(parts[1]));
}