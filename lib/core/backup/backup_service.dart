import 'dart:convert';

import 'package:drift/drift.dart';

import '../database/database.dart';

const backupFields = {
  'subjects':
      'id:i name:s description:s targetMinutes:i createdAt:s updatedAt:s',
  'study_units':
      'id:i subjectId:i title:s sortOrder:i isCompleted:b completedAt:s?',
  'companies': 'id:i name:s position:s region:s jobUrl:s deadlineDate:s? status:s note:s firstAppliedAt:s? createdAt:s updatedAt:s',
  'study_sessions': 'id:i subjectId:i unitId:i? startedAt:s endedAt:s durationSeconds:i source:s note:s',
  'application_events':
      'id:i companyId:i fromStatus:s? toStatus:s changedAt:s note:s',
  'tasks': 'id:i title:s category:s subjectId:i? companyId:i? scheduledDate:s dueAt:s? priority:i isCompleted:b completedAt:s? createdAt:s updatedAt:s',
  'notifications': 'id:i taskId:i? companyId:i? scheduledAt:s isEnabled:b platformNotificationId:i',
  'active_timers': 'id:i subjectId:i unitId:i? startedAt:s runningSince:s? elapsedSeconds:i state:s',
};
const backupStatuses = [
  'INTERESTED',
  'PREPARING',
  'APPLIED',
  'SCREENING',
  'INTERVIEW',
  'OFFER',
  'REJECTED',
  'WITHDRAWN',
  'CANCELLED',
];

class BackupService {
  BackupService(this.db);
  final AppDatabase db;
  Future<List<Map<String, dynamic>>> _rows(
    Future<List<DataClass>> query,
  ) async => (await query).map((r) => r.toJson()).toList();
  Future<String> export() => db.transaction(
    () async => const JsonEncoder.withIndent('  ').convert({
      'format': 'careerops',
      'version': 1,
      'schemaVersion': db.schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'tables': {
        'subjects': await _rows(db.select(db.subjects).get()),
        'study_units': await _rows(db.select(db.studyUnits).get()),
        'companies': await _rows(db.select(db.companies).get()),
        'study_sessions': await _rows(db.select(db.studySessions).get()),
        'application_events': await _rows(
          db.select(db.applicationEvents).get(),
        ),
        'tasks': await _rows(db.select(db.tasks).get()),
        'notifications': await _rows(db.select(db.notifications).get()),
        'active_timers': await _rows(db.select(db.activeTimers).get()),
      },
    }),
  );

  Map<String, dynamic> validate(String text) {
    if (utf8.encode(text).length > 20 * 1024 * 1024) {
      throw const FormatException('백업은 20MB 이하여야 합니다.');
    }
    final root = jsonDecode(text);
    if (root is! Map<String, dynamic> ||
        root['format'] != 'careerops' ||
        root['version'] != 1 ||
        root['schemaVersion'] != db.schemaVersion ||
        root['tables'] is! Map<String, dynamic>) {
      throw const FormatException('지원하지 않는 백업 형식/버전입니다.');
    }
    final tables = root['tables'] as Map<String, dynamic>;
    if (tables.length != backupFields.length ||
        !backupFields.keys.every(tables.containsKey)) {
      throw const FormatException('백업 테이블이 누락되었거나 잘못되었습니다.');
    }
    for (final entry in backupFields.entries) {
      final rows = tables[entry.key];
      if (rows is! List || rows.length > 100000) {
        throw const FormatException('잘못된 행 목록입니다.');
      }
      final fields = {
        for (final field in entry.value.split(' '))
          field.split(':')[0]: field.split(':')[1],
      };
      for (final row in rows) {
        if (row is! Map<String, dynamic> ||
            row.length != fields.length ||
            !fields.keys.every(row.containsKey)) {
          throw const FormatException('행 필드가 잘못되었습니다.');
        }
        for (final field in fields.entries) {
          final value = row[field.key];
          final type = field.value;
          if (value == null && type.endsWith('?')) continue;
          if (!(type.startsWith('i') && value is int ||
              type.startsWith('s') && value is String ||
              type.startsWith('b') && value is bool)) {
            throw FormatException('잘못된 데이터 타입: ${field.key}');
          }
          if (value is String && value.length > 100000) {
            throw const FormatException('문자열이 너무 깁니다.');
          }
          if (value is int && (value < 0 || value > 9007199254740991)) {
            throw const FormatException('숫자 범위 오류');
          }
          if (field.key == 'id' && value is int && value == 0) {
            throw const FormatException('ID는 양수여야 합니다.');
          }
          if (value is String &&
              (field.key.endsWith('At') || field.key == 'runningSince')) {
            if (!value.endsWith('Z') || DateTime.tryParse(value) == null) {
              throw const FormatException('시각은 UTC ISO 8601이어야 합니다.');
            }
          }
          if (value is String && field.key.endsWith('Date')) {
            final parsed = DateTime.tryParse(value);
            if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value) ||
                parsed == null ||
                parsed.toIso8601String().substring(0, 10) != value) {
              throw const FormatException('잘못된 날짜입니다.');
            }
          }
        }
        for (final key in ['name', 'title']) {
          if (row.containsKey(key) &&
              ((row[key] as String).trim().isEmpty ||
                  (row[key] as String).length > 200)) {
            throw const FormatException('이름/제목 오류');
          }
        }
        for (final key in ['status', 'fromStatus', 'toStatus']) {
          if (row[key] != null && !backupStatuses.contains(row[key])) {
            throw const FormatException('잘못된 지원 상태');
          }
        }
        if (entry.key == 'tasks' &&
            (!['STUDY', 'JOB', 'GENERAL'].contains(row['category']) ||
                (row['priority'] as int) > 2)) {
          throw const FormatException('할 일 유형/우선순위 오류');
        }
        if (row.containsKey('isCompleted') &&
            row['isCompleted'] != (row['completedAt'] != null)) {
          throw const FormatException('완료 시각 오류');
        }
        if (entry.key == 'study_sessions' &&
            (!['TIMER', 'MANUAL'].contains(row['source']) ||
                DateTime.parse(row['endedAt'])
                    .isBefore(DateTime.parse(row['startedAt'])) ||
                row['durationSeconds'] >
                    DateTime.parse(row['endedAt'])
                        .difference(DateTime.parse(row['startedAt']))
                        .inSeconds)) {
          throw const FormatException('학습 기록 오류');
        }
        if (entry.key == 'active_timers' &&
            (row['id'] != 1 ||
                !['Running', 'Paused', 'Completed'].contains(row['state']) ||
                row['state'] != 'Paused' && row['runningSince'] == null)) {
          throw const FormatException('타이머 상태 오류');
        }
        if (entry.key == 'notifications' &&
            ((row['taskId'] == null) == (row['companyId'] == null))) {
          throw const FormatException('알림 연결 오류');
        }
      }
    }
    return tables;
  }

  Future<void> restore(String text) async {
    final tables = validate(text);
    await db.transaction(() async {
      for (final name in backupFields.keys.toList().reversed) {
        await db.customStatement('DELETE FROM $name');
      }
      for (final name in backupFields.keys) {
        for (final value in tables[name] as List) {
          final row = value as Map<String, dynamic>;
          switch (name) {
            case 'subjects':
              await db.into(db.subjects).insert(Subject.fromJson(row));
            case 'study_units':
              await db.into(db.studyUnits).insert(StudyUnit.fromJson(row));
            case 'companies':
              await db.into(db.companies).insert(Company.fromJson(row));
            case 'study_sessions':
              await db
                  .into(db.studySessions)
                  .insert(StudySession.fromJson(row));
            case 'application_events':
              await db
                  .into(db.applicationEvents)
                  .insert(ApplicationEvent.fromJson(row));
            case 'tasks':
              await db.into(db.tasks).insert(Task.fromJson(row));
            case 'notifications':
              await db
                  .into(db.notifications)
                  .insert(Notification.fromJson(row));
            case 'active_timers':
              await db.into(db.activeTimers).insert(ActiveTimer.fromJson(row));
          }
        }
      }
      final broken = await db.customSelect('PRAGMA foreign_key_check').get();
      if (broken.isNotEmpty) throw const FormatException('데이터 참조가 손상되었습니다.');
      for (final table in ['study_sessions', 'active_timers']) {
        final mismatch = await db
            .customSelect(
              'SELECT t.id FROM $table t JOIN study_units u ON u.id=t.unit_id WHERE u.subject_id<>t.subject_id LIMIT 1',
            )
            .get();
        if (mismatch.isNotEmpty) {
          throw const FormatException('과목과 단원이 일치하지 않습니다.');
        }
      }
    });
  }
}
