import 'package:drift/drift.dart';

import '../../../core/database/database.dart' as sql;
import '../../../core/database/entity_mappers.dart';
import '../domain/study_repository.dart';
import 'study_store.dart';

class LocalStudyRepository implements StudyRepository {
  LocalStudyRepository(this.db, {DateTime Function()? clock})
    : service = StudyService(db, clock: clock);
  final sql.AppDatabase db;
  final StudyService service;
  @override
  Stream<List<Subject>> watchSubjects() => db
      .select(db.subjects)
      .watch()
      .map((rows) => rows.map(toSubject).toList());
  @override
  Stream<List<StudyUnit>> watchUnits() =>
      (db.select(db.studyUnits)..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.id),
          ]))
          .watch()
          .map((rows) => rows.map(toStudyUnit).toList());
  @override
  Stream<List<StudySession>> watchSessions() =>
      (db.select(db.studySessions)
            ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
          .watch()
          .map((rows) => rows.map(toStudySession).toList());
  @override
  Stream<ActiveTimer?> watchTimer() => db
      .select(db.activeTimers)
      .watchSingleOrNull()
      .map((r) => r == null ? null : toActiveTimer(r));
  @override
  int elapsed(ActiveTimer timer) => service.elapsed(toSqlActiveTimer(timer));
  @override
  Future<void> saveSubject({
    Subject? existing,
    required String name,
    required String description,
    required int targetMinutes,
  }) => service.saveSubject(
    existing: existing == null ? null : toSqlSubject(existing),
    name: name,
    description: description,
    targetMinutes: targetMinutes,
  );
  @override
  Future<void> deleteSubject(int id) => service.deleteSubject(id);
  @override
  Future<void> saveUnit(int subjectId, String title, {StudyUnit? existing}) =>
      service.saveUnit(
        subjectId,
        title,
        existing: existing == null ? null : toSqlStudyUnit(existing),
      );
  @override
  Future<void> completeUnit(StudyUnit unit, bool done) =>
      service.completeUnit(toSqlStudyUnit(unit), done);
  @override
  Future<void> deleteUnit(int id) => service.deleteUnit(id);
  @override
  Future<void> start(int subjectId, {int? unitId}) =>
      service.start(subjectId, unitId: unitId);
  @override
  Future<void> transition(String next) => service.transition(next);
  @override
  Future<void> saveTimer() => service.saveTimer();
  @override
  Future<void> manual({
    required int subjectId,
    required DateTime startedAt,
    required int seconds,
    required String note,
  }) => service.manual(
    subjectId: subjectId,
    startedAt: startedAt,
    seconds: seconds,
    note: note,
  );
}
