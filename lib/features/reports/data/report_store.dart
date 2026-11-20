import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../../../core/utils/dates.dart';

Selectable<QueryRow> reportQuery(AppDatabase db, DateTime start) {
  final end = DateTime(start.year, start.month, start.day + 7);
  return db.customSelect(
    '''
SELECT 'subject' kind, s.name label, COALESCE(SUM(r.duration_seconds),0) value
FROM subjects s LEFT JOIN study_sessions r ON s.id=r.subject_id AND r.started_at>=?1 AND r.started_at<?2 GROUP BY s.id
UNION ALL SELECT 'daily', strftime('%Y-%m-%d',started_at,'localtime'), SUM(duration_seconds) FROM study_sessions WHERE started_at>=?1 AND started_at<?2 GROUP BY strftime('%Y-%m-%d',started_at,'localtime')
UNION ALL SELECT 'tasks_total','',COUNT(*) FROM tasks WHERE scheduled_date>=?3 AND scheduled_date<?4
UNION ALL SELECT 'tasks_done','',COUNT(*) FROM tasks WHERE scheduled_date>=?3 AND scheduled_date<?4 AND is_completed=1
UNION ALL SELECT 'applications','',COUNT(*) FROM companies WHERE first_applied_at>=?1 AND first_applied_at<?2
UNION ALL SELECT 'stage',status,COUNT(*) FROM companies GROUP BY status
UNION ALL SELECT 'units_total','',COUNT(*) FROM study_units
UNION ALL SELECT 'units_done','',COUNT(*) FROM study_units WHERE is_completed=1
''',
    variables: [
      Variable.withString(start.toUtc().toIso8601String()),
      Variable.withString(end.toUtc().toIso8601String()),
      Variable.withString(dateKey(start)),
      Variable.withString(dateKey(end)),
    ],
    readsFrom: {
      db.subjects,
      db.studySessions,
      db.tasks,
      db.companies,
      db.studyUnits,
    },
  );
}
