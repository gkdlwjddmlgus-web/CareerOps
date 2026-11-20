String dateKey(DateTime value) =>
    '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
String utcNow() => DateTime.now().toUtc().toIso8601String();
String studyDuration(int seconds) =>
    '${seconds ~/ 3600}시간 ${(seconds % 3600) ~/ 60}분';
DateTime weekStart(DateTime now) => DateTime(
  now.year,
  now.month,
  now.day,
).subtract(Duration(days: now.weekday - 1));
