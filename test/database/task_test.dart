import 'dart:io';

import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/tasks/data/task_store.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'tasks survive reopening, sort correctly, and move only explicitly',
    () async {
      final directory = await Directory.systemTemp.createTemp('careerops-test');
      final file = File('${directory.path}/test.sqlite');
      var db = AppDatabase(NativeDatabase(file));
      try {
        for (final priority in [0, 2, 1]) {
          await db.saveTask(
            title: '할 일 $priority',
            category: 'STUDY',
            date: '2026-11-19',
            priority: priority,
          );
        }
        var rows = await db.select(db.tasks).get();
        rows.sort(compareTasks);
        expect(rows.map((t) => t.priority), [2, 1, 0]);
        await db.completeTask(rows.first, true);
        await db.close();
        db = AppDatabase(NativeDatabase(file));
        rows = await db.select(db.tasks).get();
        rows.sort(compareTasks);
        expect(rows.last.isCompleted, isTrue);
        expect(rows.every((t) => t.scheduledDate == '2026-11-19'), isTrue);
        await db.moveTask(rows.first, '2026-11-20');
        expect(
          (await db.select(db.tasks).get())
              .where((t) => t.scheduledDate == '2026-11-20')
              .length,
          1,
        );
        await expectLater(
          db.moveTask(rows.last, '2026-11-20'),
          throwsStateError,
        );
      } finally {
        await db.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
