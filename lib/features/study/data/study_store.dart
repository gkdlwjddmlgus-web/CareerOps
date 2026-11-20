import 'dart:math';

import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

class StudyService {
  StudyService(this.db, {DateTime Function()? clock})
    : clock = clock ?? DateTime.now;
  final AppDatabase db;
  final DateTime Function() clock;
  String get now => clock().toUtc().toIso8601String();
  int elapsed(ActiveTimer timer) =>
      timer.elapsedSeconds +
      (timer.state == 'Running' && timer.runningSince != null
          ? max(
              0,
              clock()
                  .toUtc()
                  .difference(DateTime.parse(timer.runningSince!))
                  .inSeconds,
            )
          : 0);

  Future<void> saveSubject({
    Subject? existing,
    required String name,
    required String description,
    required int targetMinutes,
  }) async {
    if (name.trim().isEmpty || targetMinutes < 0) {
      throw ArgumentError('과목명과 목표 시간을 확인하세요.');
    }
    final row = SubjectsCompanion(
      name: Value(name.trim()),
      description: Value(description),
      targetMinutes: Value(targetMinutes),
      updatedAt: Value(now),
    );
    if (existing == null) {
      await db.into(db.subjects).insert(row.copyWith(createdAt: Value(now)));
    } else {
      await (db.update(
        db.subjects,
      )..where((t) => t.id.equals(existing.id))).write(row);
    }
  }

  Future<void> deleteSubject(int id) async {
    await (db.delete(db.subjects)..where((t) => t.id.equals(id))).go();
  }

  Future<void> saveUnit(
    int subjectId,
    String title, {
    StudyUnit? existing,
  }) async {
    if (title.trim().isEmpty) throw ArgumentError('단원명을 입력하세요.');
    if (existing == null) {
      final units = await (db.select(
        db.studyUnits,
      )..where((t) => t.subjectId.equals(subjectId))).get();
      await db
          .into(db.studyUnits)
          .insert(
            StudyUnitsCompanion.insert(
              subjectId: subjectId,
              title: title.trim(),
              sortOrder: Value(units.length),
            ),
          );
    } else {
      await (db.update(db.studyUnits)..where((t) => t.id.equals(existing.id)))
          .write(StudyUnitsCompanion(title: Value(title.trim())));
    }
  }

  Future<void> completeUnit(StudyUnit unit, bool done) async {
    await (db.update(db.studyUnits)..where((t) => t.id.equals(unit.id))).write(
      StudyUnitsCompanion(
        isCompleted: Value(done),
        completedAt: Value(done ? now : null),
      ),
    );
  }

  Future<void> deleteUnit(int id) async {
    await (db.delete(db.studyUnits)..where((t) => t.id.equals(id))).go();
  }

  Future<void> start(int subjectId, {int? unitId}) => db.transaction(() async {
    if (await db.select(db.activeTimers).getSingleOrNull() != null) {
      throw StateError('진행 중인 타이머를 먼저 저장하세요.');
    }
    if (unitId != null) {
      final unit = await (db.select(
        db.studyUnits,
      )..where((t) => t.id.equals(unitId))).getSingle();
      if (unit.subjectId != subjectId) {
        throw ArgumentError('과목과 단원이 일치하지 않습니다.');
      }
    }
    await db
        .into(db.activeTimers)
        .insert(
          ActiveTimersCompanion.insert(
            id: const Value(1),
            subjectId: subjectId,
            unitId: Value(unitId),
            startedAt: now,
            runningSince: Value(now),
            state: 'Running',
          ),
        );
  });
  Future<void> transition(String next) => db.transaction(() async {
    final timer = await db.select(db.activeTimers).getSingleOrNull();
    if (timer == null) throw StateError('타이머가 없습니다.');
    final valid =
        (timer.state == 'Running' && ['Paused', 'Completed'].contains(next)) ||
        (timer.state == 'Paused' && ['Running', 'Completed'].contains(next));
    if (!valid) throw StateError('잘못된 타이머 전환입니다.');
    await db
        .update(db.activeTimers)
        .write(
          ActiveTimersCompanion(
            elapsedSeconds: Value(elapsed(timer)),
            state: Value(next),
            // In Completed this stores the frozen stop time, until saved.
            runningSince: Value(next == 'Paused' ? null : now),
          ),
        );
  });
  Future<void> saveTimer() => db.transaction(() async {
    final timer = await db.select(db.activeTimers).getSingleOrNull();
    if (timer == null) return;
    if (timer.state != 'Completed') throw StateError('먼저 종료하세요.');
    await db
        .into(db.studySessions)
        .insert(
          StudySessionsCompanion.insert(
            subjectId: timer.subjectId,
            unitId: Value(timer.unitId),
            startedAt: timer.startedAt,
            endedAt: timer.runningSince ?? now,
            durationSeconds: timer.elapsedSeconds,
            source: 'TIMER',
          ),
        );
    await db.delete(db.activeTimers).go();
  });
  Future<void> manual({
    required int subjectId,
    required DateTime startedAt,
    required int seconds,
    required String note,
  }) async {
    if (seconds <= 0 || seconds > 86400) {
      throw ArgumentError('학습 시간은 1초~24시간이어야 합니다.');
    }
    if (startedAt.add(Duration(seconds: seconds)).isAfter(clock())) {
      throw ArgumentError('미래 학습 기록은 저장할 수 없습니다.');
    }
    await db
        .into(db.studySessions)
        .insert(
          StudySessionsCompanion.insert(
            subjectId: subjectId,
            startedAt: startedAt.toUtc().toIso8601String(),
            endedAt: startedAt
                .add(Duration(seconds: seconds))
                .toUtc()
                .toIso8601String(),
            durationSeconds: seconds,
            source: 'MANUAL',
            note: Value(note),
          ),
        );
  }
}
