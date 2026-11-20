import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/reports/report_repository.dart';
import 'package:careerops/features/tasks/data/task_store.dart';
import 'package:careerops/features/study/data/study_store.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reports aggregate persisted data and exclude next week', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final start = DateTime(2026, 11, 16);
    final service = StudyService(db, clock: () => DateTime(2026, 11, 30));
    await service.saveSubject(name: 'Dart', description: '', targetMinutes: 60);
    final id = (await db.select(db.subjects).get()).single.id;
    await service.manual(
      subjectId: id,
      startedAt: DateTime(2026, 11, 16, 9),
      seconds: 3600,
      note: '',
    );
    await service.manual(
      subjectId: id,
      startedAt: DateTime(2026, 11, 23, 9),
      seconds: 7200,
      note: '',
    );
    await db.saveTask(
      title: '완료',
      category: 'STUDY',
      date: '2026-11-16',
      priority: 1,
    );
    await db.completeTask((await db.select(db.tasks).get()).single, true);
    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      reportProvider(start),
      (previous, next) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    final rows = await container.read(reportProvider(start).future);
    int value(String kind) =>
        rows.where((r) => r.kind == kind).fold<int>(0, (n, r) => n + r.value);
    expect(value('daily'), 3600);
    expect(value('subject'), 3600);
    expect(value('tasks_total'), 1);
    expect(value('tasks_done'), 1);
    expect(value('applications'), 0);
  });
}
