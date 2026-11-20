import 'package:careerops/core/database/database.dart';
import 'package:careerops/core/notifications/notification_service.dart';
import 'package:careerops/features/tasks/task_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBackend implements NotificationBackend {
  bool allowed = false, fail = false;
  final Set<int> ids = {};
  @override
  Future<bool> permission({bool request = false}) async => allowed;
  @override
  Future<void> schedule(
    int id,
    String title,
    DateTime at,
    String payload,
  ) async {
    if (fail) throw StateError('예약 실패');
    ids.add(id);
  }

  @override
  Future<void> cancel(int id) async {
    ids.remove(id);
  }

  @override
  Future<List<int>> pending() async => ids.toList();
}

void main() {
  test(
    'denial and scheduling failures preserve data; delete cancels pending',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final backend = FakeBackend();
      final service = NotificationService(db, backend);
      addTearDown(service.dispose);
      await db.saveTask(
        title: '원본 일정',
        category: 'GENERAL',
        date: '2026-11-20',
        priority: 1,
      );
      final task = (await db.select(db.tasks).get()).single;
      final at = DateTime.now().add(const Duration(days: 1));
      await expectLater(
        service.configure(taskId: task.id, at: at),
        throwsStateError,
      );
      expect((await db.select(db.tasks).get()).single.title, '원본 일정');
      expect(
        (await db.select(db.notifications).get()).single.isEnabled,
        isFalse,
      );
      backend.allowed = true;
      backend.fail = true;
      await expectLater(
        service.configure(taskId: task.id, at: at),
        throwsStateError,
      );
      expect(
        (await db.select(db.notifications).get()).single.isEnabled,
        isFalse,
      );
      backend.fail = false;
      await service.configure(taskId: task.id, at: at);
      expect(backend.ids.length, 1);
      await db.deleteTask(task.id);
      await service.reconcile();
      expect(backend.ids, isEmpty);
    },
  );
}
