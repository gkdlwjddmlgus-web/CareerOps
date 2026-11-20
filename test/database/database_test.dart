import 'package:careerops/core/database/database.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'foreign keys reject orphan units and invalid task priorities',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await expectLater(
        db
            .into(db.studyUnits)
            .insert(StudyUnitsCompanion.insert(subjectId: 999, title: '고아 단원')),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        db
            .into(db.tasks)
            .insert(
              TasksCompanion.insert(
                title: '잘못된 우선순위',
                category: 'GENERAL',
                scheduledDate: '2026-11-20',
                priority: const Value(9),
                createdAt: '2026-11-20T00:00:00.000Z',
                updatedAt: '2026-11-20T00:00:00.000Z',
              ),
            ),
        throwsA(isA<Exception>()),
      );
    },
  );
  test('schema initializes all tables, indexes and foreign keys', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    expect(await db.select(db.tasks).get(), isEmpty);
    expect(await db.select(db.activeTimers).get(), isEmpty);
    final fk = await db.customSelect('PRAGMA foreign_keys').getSingle();
    expect(fk.read<int>('foreign_keys'), 1);
    final indexes = await db
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'index'")
        .get();
    expect(
      indexes.map((r) => r.read<String>('name')),
      contains('tasks_schedule'),
    );
    expect(db.schemaVersion, 1);
  });
}
