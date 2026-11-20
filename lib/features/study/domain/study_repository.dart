import 'models.dart';
export 'models.dart';

abstract interface class StudyRepository {
  Stream<List<Subject>> watchSubjects();
  Stream<List<StudyUnit>> watchUnits();
  Stream<List<StudySession>> watchSessions();
  Stream<ActiveTimer?> watchTimer();
  int elapsed(ActiveTimer timer);
  Future<void> saveSubject({
    Subject? existing,
    required String name,
    required String description,
    required int targetMinutes,
  });
  Future<void> deleteSubject(int id);
  Future<void> saveUnit(int subjectId, String title, {StudyUnit? existing});
  Future<void> completeUnit(StudyUnit unit, bool done);
  Future<void> deleteUnit(int id);
  Future<void> start(int subjectId, {int? unitId});
  Future<void> transition(String next);
  Future<void> saveTimer();
  Future<void> manual({
    required int subjectId,
    required DateTime startedAt,
    required int seconds,
    required String note,
  });
}
