class ReportMetric {
  const ReportMetric({
    required this.kind,
    required this.label,
    required this.value,
  });
  final String kind, label;
  final int value;
}

abstract interface class ReportRepository {
  Stream<List<ReportMetric>> watchWeek(DateTime start);
}
