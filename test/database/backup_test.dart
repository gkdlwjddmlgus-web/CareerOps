import 'dart:convert';

import 'package:careerops/core/backup/backup_service.dart';
import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/tasks/task_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('backup roundtrip and invalid restore preserve original data', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final service = BackupService(db);
    await db.saveTask(
      title: '보존할 계획',
      category: 'GENERAL',
      date: '2026-11-20',
      priority: 2,
    );
    final original = await service.export();
    await db.delete(db.tasks).go();
    await service.restore(original);
    expect((await db.select(db.tasks).get()).single.title, '보존할 계획');
    await expectLater(service.restore('{broken'), throwsFormatException);
    var bad = jsonDecode(original) as Map<String, dynamic>;
    bad['version'] = 999;
    await expectLater(service.restore(jsonEncode(bad)), throwsFormatException);
    bad = jsonDecode(original);
    bad['tables']['tasks'][0]['subjectId'] = 999;
    await expectLater(
      service.restore(jsonEncode(bad)),
      throwsA(isA<Exception>()),
    );
    expect((await db.select(db.tasks).get()).single.title, '보존할 계획');
    bad = jsonDecode(original);
    bad['tables']['tasks'][0]['scheduledDate'] = '2026-02-30';
    await expectLater(service.restore(jsonEncode(bad)), throwsFormatException);
    expect((await db.select(db.tasks).get()).single.priority, 2);
  });
}
