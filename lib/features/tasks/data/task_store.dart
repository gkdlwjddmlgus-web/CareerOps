import 'package:drift/drift.dart';

import '../../../core/database/database.dart';
import '../../../core/utils/dates.dart';

int compareTasks(Task a, Task b) {
  final complete = (a.isCompleted ? 1 : 0).compareTo(b.isCompleted ? 1 : 0);
  if (complete != 0) return complete;
  final priority = b.priority.compareTo(a.priority);
  if (priority != 0) return priority;
  final due = (a.dueAt ?? '9999').compareTo(b.dueAt ?? '9999');
  return due != 0 ? due : a.id.compareTo(b.id);
}

extension TaskStore on AppDatabase {
  Future<void> saveTask({
    Task? existing,
    required String title,
    required String category,
    required String date,
    String? due,
    required int priority,
    int? subjectId,
    int? companyId,
  }) async {
    if (title.trim().isEmpty) throw ArgumentError('제목을 입력하세요.');
    final row = TasksCompanion(
      title: Value(title.trim()),
      category: Value(category),
      scheduledDate: Value(date),
      dueAt: Value(due),
      priority: Value(priority),
      subjectId: Value(subjectId),
      companyId: Value(companyId),
      updatedAt: Value(utcNow()),
    );
    if (existing == null) {
      await into(tasks).insert(row.copyWith(createdAt: Value(utcNow())));
    } else {
      await (update(tasks)..where((t) => t.id.equals(existing.id))).write(row);
    }
  }

  Future<void> completeTask(Task task, bool done) async {
    await (update(tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(
        isCompleted: Value(done),
        completedAt: Value(done ? utcNow() : null),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  Future<void> moveTask(Task task, String date) async {
    if (task.isCompleted) throw StateError('완료 항목은 이월할 수 없습니다.');
    await (update(tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(scheduledDate: Value(date), updatedAt: Value(utcNow())),
    );
  }

  Future<void> deleteTask(int id) async {
    await (delete(tasks)..where((t) => t.id.equals(id))).go();
  }
}
