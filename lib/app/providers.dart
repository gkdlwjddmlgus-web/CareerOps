import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/database.dart';
import '../features/tasks/domain/task_repository.dart' as tasks;
import '../features/tasks/data/local_task_repository.dart';
import '../features/study/domain/study_repository.dart' as study;
import '../features/study/data/local_study_repository.dart';
import '../features/jobs/domain/job_repository.dart' as jobs;
import '../features/jobs/data/local_job_repository.dart';
import '../features/reports/domain/report_repository.dart';
import '../features/reports/data/local_report_repository.dart';
import '../core/backup/backup_repository.dart';
import '../core/backup/local_backup_repository.dart';
import '../core/notifications/notification_service.dart';
import '../core/notifications/reminder_repository.dart';

// Composition root: presentation providers depend on contracts; only this file
// selects local implementations. No network adapter is installed in v0.1.0.
final taskRepositoryProvider = Provider<tasks.TaskRepository>(
  (ref) => LocalTaskRepository(ref.watch(databaseProvider)),
);
final studyServiceProvider = Provider<study.StudyRepository>(
  (ref) => LocalStudyRepository(ref.watch(databaseProvider)),
);
final jobRepositoryProvider = Provider<jobs.JobRepository>(
  (ref) => LocalJobRepository(ref.watch(databaseProvider)),
);
final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) => LocalReportRepository(ref.watch(databaseProvider)),
);
final backupRepositoryProvider = Provider<BackupRepository>(
  (ref) => LocalBackupRepository(ref.watch(databaseProvider)),
);
final tasksProvider = StreamProvider(
  (ref) => ref.watch(taskRepositoryProvider).watchTasks(),
);
final taskProvider = StreamProvider.family<tasks.Task?, int>(
  (ref, id) => ref.watch(taskRepositoryProvider).watchTask(id),
);
final subjectsProvider = StreamProvider(
  (ref) => ref.watch(studyServiceProvider).watchSubjects(),
);
final unitsProvider = StreamProvider(
  (ref) => ref.watch(studyServiceProvider).watchUnits(),
);
final sessionsProvider = StreamProvider(
  (ref) => ref.watch(studyServiceProvider).watchSessions(),
);
final timerProvider = StreamProvider(
  (ref) => ref.watch(studyServiceProvider).watchTimer(),
);
final tickProvider = StreamProvider(
  (ref) => Stream.periodic(const Duration(seconds: 1), (i) => i),
);
final companiesProvider = StreamProvider(
  (ref) => ref.watch(jobRepositoryProvider).watchCompanies(),
);
final eventsProvider = StreamProvider(
  (ref) => ref.watch(jobRepositoryProvider).watchEvents(),
);
final reportProvider = StreamProvider.family<List<ReportMetric>, DateTime>(
  (ref, start) => ref.watch(reportRepositoryProvider).watchWeek(start),
);
final notificationBackendProvider = Provider<NotificationBackend>(
  (ref) => AndroidNotificationBackend(),
);
final notificationServiceProvider = Provider<ReminderRepository>((ref) {
  final repository = NotificationService(
    ref.watch(databaseProvider),
    ref.watch(notificationBackendProvider),
  );
  ref.onDispose(repository.dispose);
  return repository;
});
final notificationsProvider = StreamProvider(
  (ref) => ref.watch(notificationServiceProvider).watchReminders(),
);
