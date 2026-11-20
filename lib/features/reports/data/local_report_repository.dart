import '../../../core/database/database.dart';
import '../domain/report_repository.dart';
import 'report_store.dart';

class LocalReportRepository implements ReportRepository {
  LocalReportRepository(this.db);
  final AppDatabase db;
  @override
  Stream<List<ReportMetric>> watchWeek(DateTime start) =>
      reportQuery(db, start).watch().map(
        (rows) => [
          for (final row in rows)
            ReportMetric(
              kind: row.read<String>('kind'),
              label: row.read<String>('label'),
              value: row.read<int>('value'),
            ),
        ],
      );
}
