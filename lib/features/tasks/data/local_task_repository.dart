import '../../../core/database/database.dart' as sql;
import '../../../core/database/entity_mappers.dart';
import '../domain/task_repository.dart';
import 'task_store.dart';

class LocalTaskRepository implements TaskRepository {
  LocalTaskRepository(this.db);
  final sql.AppDatabase db;
  @override
  Stream<List<Task>> watchTasks() =>
      db.select(db.tasks).watch().map((rows) => rows.map(toTask).toList());
  @override
  Stream<Task?> watchTask(int id) =>
      (db.select(db.tasks)..where((t) => t.id.equals(id)))
          .watchSingleOrNull()
          .map((row) => row == null ? null : toTask(row));
  @override
  Future<void> saveTask({
    Task? existing,
    required String title,
    required String category,
    required String date,
    String? due,
    required int priority,
    int? subjectId,
    int? companyId,
  }) => db.saveTask(
    existing: existing == null ? null : toSqlTask(existing),
    title: title,
    category: category,
    date: date,
    due: due,
    priority: priority,
    subjectId: subjectId,
    companyId: companyId,
  );
  @override
  Future<void> completeTask(Task task, bool done) =>
      db.completeTask(toSqlTask(task), done);
  @override
  Future<void> moveTask(Task task, String date) =>
      db.moveTask(toSqlTask(task), date);
  @override
  Future<void> deleteTask(int id) => db.deleteTask(id);
}
