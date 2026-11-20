import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:careerops/features/tasks/domain/task_repository.dart';
import 'package:careerops/features/study/domain/study_repository.dart';
import 'package:careerops/features/jobs/domain/job_repository.dart';
import 'package:careerops/features/reports/domain/report_repository.dart';
import 'package:careerops/core/backup/backup_repository.dart';
import 'package:careerops/core/notifications/reminder_repository.dart';

class MemoryTaskRepository implements TaskRepository {
  MemoryTaskRepository([List<Task> initial = const []]) : rows = [...initial];
  final List<Task> rows;
  final changes = StreamController<List<Task>>.broadcast();
  void emit() => changes.add(List.unmodifiable(rows));
  Future<void> close() => changes.close();
  @override
  Stream<List<Task>> watchTasks() async* {
    yield List.unmodifiable(rows);
    yield* changes.stream;
  }

  @override
  Stream<Task?> watchTask(int id) =>
      watchTasks().map((rows) => rows.where((r) => r.id == id).firstOrNull);
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
  }) async {
    final stamp = DateTime.now().toUtc().toIso8601String();
    final task = Task(
      id: existing?.id ?? rows.length + 1,
      title: title,
      category: category,
      scheduledDate: date,
      dueAt: due,
      priority: priority,
      subjectId: subjectId,
      companyId: companyId,
      isCompleted: existing?.isCompleted ?? false,
      completedAt: existing?.completedAt,
      createdAt: existing?.createdAt ?? stamp,
      updatedAt: stamp,
    );
    rows.removeWhere((r) => r.id == task.id);
    rows.add(task);
    emit();
  }

  @override
  Future<void> completeTask(Task task, bool done) async {
    rows.removeWhere((r) => r.id == task.id);
    rows.add(
      Task(
        id: task.id,
        title: task.title,
        category: task.category,
        scheduledDate: task.scheduledDate,
        dueAt: task.dueAt,
        priority: task.priority,
        subjectId: task.subjectId,
        companyId: task.companyId,
        isCompleted: done,
        completedAt: done ? DateTime.now().toUtc().toIso8601String() : null,
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
      ),
    );
    emit();
  }

  @override
  Future<void> deleteTask(int id) async {
    rows.removeWhere((r) => r.id == id);
    emit();
  }

  @override
  Future<void> moveTask(Task task, String date) => saveTask(
    existing: task,
    title: task.title,
    category: task.category,
    date: date,
    due: task.dueAt,
    priority: task.priority,
    subjectId: task.subjectId,
    companyId: task.companyId,
  );
}

class FakeStudyRepository implements StudyRepository {
  @override
  Stream<List<Subject>> watchSubjects() => Stream.value([]);
  @override
  Stream<List<StudyUnit>> watchUnits() => Stream.value([]);
  @override
  Stream<List<StudySession>> watchSessions() => Stream.value([]);
  @override
  Stream<ActiveTimer?> watchTimer() => Stream.value(null);
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('${invocation.memberName}');
}

class FakeJobRepository implements JobRepository {
  @override
  Stream<List<Company>> watchCompanies() => Stream.value([]);
  @override
  Stream<List<ApplicationEvent>> watchEvents() => Stream.value([]);
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('${invocation.memberName}');
}

class FakeReportRepository implements ReportRepository {
  @override
  Stream<List<ReportMetric>> watchWeek(DateTime start) => Stream.value([]);
}

class FakeBackupRepository implements BackupRepository {
  @override
  Future<String> export() async => '{}';
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('${invocation.memberName}');
}

class FakeReminderRepository implements ReminderRepository {
  @override
  final ValueNotifier<String?> lastError = ValueNotifier<String?>(null);
  @override
  Stream<List<Reminder>> watchReminders() => Stream.value([]);
  @override
  Future<bool> permission({bool request = false}) async => false;
  @override
  void dispose() => lastError.dispose();
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('${invocation.memberName}');
}
