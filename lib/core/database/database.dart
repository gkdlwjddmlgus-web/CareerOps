// Drift interprets these getter references as SQL column expressions.
// ignore_for_file: recursive_getters
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get targetMinutes => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

class StudyUnits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get completedAt => text().nullable()();
}

class StudySessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.restrict)();
  IntColumn get unitId => integer().nullable().references(
    StudyUnits,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get startedAt => text()();
  TextColumn get endedAt => text()();
  IntColumn get durationSeconds =>
      integer().check(durationSeconds.isBiggerOrEqualValue(0))();
  TextColumn get source => text().check(source.isIn(['TIMER', 'MANUAL']))();
  TextColumn get note => text().withDefault(const Constant(''))();
}

class Companies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get position => text().withDefault(const Constant(''))();
  TextColumn get region => text().withDefault(const Constant(''))();
  TextColumn get jobUrl => text().withDefault(const Constant(''))();
  TextColumn get deadlineDate => text().nullable()();
  TextColumn get status => text()
      .withDefault(const Constant('INTERESTED'))
      .check(
        status.isIn([
          'INTERESTED',
          'PREPARING',
          'APPLIED',
          'SCREENING',
          'INTERVIEW',
          'OFFER',
          'REJECTED',
          'WITHDRAWN',
          'CANCELLED',
        ]),
      )();
  TextColumn get note => text().withDefault(const Constant(''))();
  TextColumn get firstAppliedAt => text().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

class ApplicationEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get companyId =>
      integer().references(Companies, #id, onDelete: KeyAction.cascade)();
  TextColumn get fromStatus => text().nullable()();
  TextColumn get toStatus => text()();
  TextColumn get changedAt => text()();
  TextColumn get note => text().withDefault(const Constant(''))();
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get category =>
      text().check(category.isIn(['STUDY', 'JOB', 'GENERAL']))();
  IntColumn get subjectId => integer().nullable().references(
    Subjects,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get companyId => integer().nullable().references(
    Companies,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get scheduledDate => text()();
  TextColumn get dueAt => text().nullable()();
  IntColumn get priority => integer()
      .withDefault(const Constant(1))
      .check(priority.isBetweenValues(0, 2))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get completedAt => text().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

class Notifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskId => integer().nullable().references(
    Tasks,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get companyId => integer().nullable().references(
    Companies,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get scheduledAt => text()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get platformNotificationId => integer().unique()();
}

class ActiveTimers extends Table {
  IntColumn get id => integer().check(id.equals(1))();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.restrict)();
  IntColumn get unitId => integer().nullable().references(
    StudyUnits,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get startedAt => text()();
  TextColumn get runningSince => text().nullable()();
  IntColumn get elapsedSeconds => integer().withDefault(const Constant(0))();
  TextColumn get state =>
      text().check(state.isIn(['Running', 'Paused', 'Completed']))();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Subjects,
    StudyUnits,
    StudySessions,
    Companies,
    ApplicationEvents,
    Tasks,
    Notifications,
    ActiveTimers,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);
  factory AppDatabase.open() => AppDatabase(
    LazyDatabase(() async {
      final directory = await getApplicationSupportDirectory();
      return NativeDatabase.createInBackground(
        File(p.join(directory.path, 'careerops.sqlite')),
      );
    }),
  );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX tasks_schedule ON tasks(scheduled_date, is_completed, priority, due_at)',
      );
      await customStatement(
        'CREATE INDEX sessions_subject_time ON study_sessions(subject_id, started_at)',
      );
      await customStatement(
        'CREATE INDEX companies_deadline ON companies(deadline_date)',
      );
      await customStatement(
        'CREATE INDEX events_company_time ON application_events(company_id, changed_at)',
      );
    },
    beforeOpen: (_) async => customStatement('PRAGMA foreign_keys = ON'),
  );
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});
