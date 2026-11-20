import 'models.dart';
export 'models.dart';

abstract interface class TaskRepository {
  Stream<List<Task>> watchTasks();
  Stream<Task?> watchTask(int id);
  Future<void> saveTask({
    Task? existing,
    required String title,
    required String category,
    required String date,
    String? due,
    required int priority,
    int? subjectId,
    int? companyId,
  });
  Future<void> completeTask(Task task, bool done);
  Future<void> moveTask(Task task, String date);
  Future<void> deleteTask(int id);
}

int compareTasks(Task a, Task b) {
  final complete = (a.isCompleted ? 1 : 0).compareTo(b.isCompleted ? 1 : 0);
  if (complete != 0) return complete;
  final priority = b.priority.compareTo(a.priority);
  if (priority != 0) return priority;
  final due = (a.dueAt ?? '9999').compareTo(b.dueAt ?? '9999');
  return due != 0 ? due : a.id.compareTo(b.id);
}
