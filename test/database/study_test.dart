import 'dart:io';

import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/study/study_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'timer restores after restart, excludes pauses, and saves once',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'careerops-timer',
      );
      final file = File('${directory.path}/timer.sqlite');
      var db = AppDatabase(NativeDatabase(file));
      var time = DateTime.utc(2026, 11, 20);
      var service = StudyService(db, clock: () => time);
      try {
        await service.saveSubject(
          name: 'Dart',
          description: '학습',
          targetMinutes: 60,
        );
        final subject = (await db.select(db.subjects).get()).single;
        await service.saveUnit(subject.id, '비동기');
        await service.start(subject.id);
        time = time.add(const Duration(seconds: 65));
        await service.transition('Paused');
        time = time.add(const Duration(minutes: 10));
        await db.close();
        db = AppDatabase(NativeDatabase(file));
        service = StudyService(db, clock: () => time);
        var timer = (await db.select(db.activeTimers).get()).single;
        expect(service.elapsed(timer), 65);
        await service.transition('Running');
        time = time.add(const Duration(seconds: 35));
        await db.close();
        db = AppDatabase(NativeDatabase(file));
        service = StudyService(db, clock: () => time);
        timer = (await db.select(db.activeTimers).get()).single;
        expect(service.elapsed(timer), 100);
        await service.transition('Completed');
        final stoppedAt = time;
        time = time.add(const Duration(seconds: 20));
        await service.saveTimer();
        await service.saveTimer();
        final sessions = await db.select(db.studySessions).get();
        expect(sessions.single.durationSeconds, 100);
        expect(DateTime.parse(sessions.single.endedAt), stoppedAt);
        expect(await db.select(db.activeTimers).get(), isEmpty);
        await expectLater(
          service.deleteSubject(subject.id),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          service.manual(
            subjectId: subject.id,
            startedAt: time,
            seconds: 60,
            note: '',
          ),
          throwsArgumentError,
        );
      } finally {
        await db.close();
        await directory.delete(recursive: true);
      }
    },
  );
}
