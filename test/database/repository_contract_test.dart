import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/tasks/domain/task_repository.dart' as task;
import 'package:careerops/features/tasks/data/local_task_repository.dart';
import 'package:careerops/features/study/domain/study_repository.dart' as study;
import 'package:careerops/features/study/data/local_study_repository.dart';
import 'package:careerops/features/jobs/domain/job_repository.dart' as job;
import 'package:careerops/features/jobs/data/local_job_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('local repositories satisfy storage-independent contracts', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final task.TaskRepository tasks = LocalTaskRepository(db);
    await tasks.saveTask(
      title: '계약 검증',
      category: 'GENERAL',
      date: '2026-11-20',
      priority: 2,
    );
    final saved = (await tasks.watchTasks().first).single;
    expect(saved, isA<task.Task>());
    await tasks.completeTask(saved, true);
    expect((await tasks.watchTask(saved.id).first)!.isCompleted, isTrue);
    final study.StudyRepository subjects = LocalStudyRepository(db);
    await subjects.saveSubject(
      name: '학습',
      description: '독립 모델',
      targetMinutes: 60,
    );
    final subject = (await subjects.watchSubjects().first).single;
    expect(subject, isA<study.Subject>());
    await subjects.saveUnit(subject.id, '단원');
    expect((await subjects.watchUnits().first).single.subjectId, subject.id);
    final job.JobRepository jobs = LocalJobRepository(db);
    await jobs.saveCompany(
      name: '기업',
      position: '직무',
      region: '서울',
      url: '',
      status: 'APPLIED',
      note: '',
    );
    final company = (await jobs.watchCompanies().first).single;
    expect(company, isA<job.Company>());
    expect(company.firstAppliedAt, isNotNull);
    expect((await jobs.watchEvents().first).single.toStatus, 'APPLIED');
  });
}
