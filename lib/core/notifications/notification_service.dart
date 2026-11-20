import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../database/database.dart' hide Notification;
import 'reminder_repository.dart';

abstract class NotificationBackend {
  Future<bool> permission({bool request = false});
  Future<void> schedule(int id, String title, DateTime at, String payload);
  Future<void> cancel(int id);
  Future<List<int>> pending();
}

class AndroidNotificationBackend implements NotificationBackend {
  final plugin = FlutterLocalNotificationsPlugin();
  bool ready = false;
  Future<void> initialize(void Function(String) onTap) async {
    if (!Platform.isAndroid) return;
    tzdata.initializeTimeZones();
    await plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
      ),
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) onTap(response.payload!);
      },
    );
    ready = true;
    final launch = await plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      final payload = launch!.notificationResponse?.payload;
      if (payload != null) onTap(payload);
    }
  }

  @override
  Future<bool> permission({bool request = false}) async {
    if (!ready) return false;
    final android = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()!;
    return (request
            ? await android.requestNotificationsPermission()
            : await android.areNotificationsEnabled()) ??
        false;
  }

  @override
  Future<void> schedule(
    int id,
    String title,
    DateTime at,
    String payload,
  ) async {
    if (!ready) throw StateError('Android 알림 초기화가 필요합니다.');
    await plugin.zonedSchedule(
      id: id,
      title: title,
      body: 'CareerOps에 등록한 일정을 확인하세요.',
      scheduledDate: tz.TZDateTime.from(at.toUtc(), tz.UTC),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'careerops_reminders',
          '일정 및 채용 알림',
          channelDescription: '사용자가 설정한 일정 알림',
          importance: Importance.high,
          priority: Priority.high,
          icon: 'ic_notification',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
    );
  }

  @override
  Future<void> cancel(int id) async {
    if (ready) await plugin.cancel(id: id);
  }

  @override
  Future<List<int>> pending() async => ready
      ? (await plugin.pendingNotificationRequests()).map((r) => r.id).toList()
      : [];
}

class NotificationService implements ReminderRepository {
  NotificationService(this.db, this.backend);
  @override
  Stream<List<Reminder>> watchReminders() => db
      .select(db.notifications)
      .watch()
      .map(
        (rows) => [
          for (final r in rows)
            Reminder(
              id: r.id,
              taskId: r.taskId,
              companyId: r.companyId,
              scheduledAt: r.scheduledAt,
              isEnabled: r.isEnabled,
              platformNotificationId: r.platformNotificationId,
            ),
        ],
      );
  @override
  Future<bool> permission({bool request = false}) =>
      backend.permission(request: request);
  final AppDatabase db;
  final NotificationBackend backend;
  @override
  final ValueNotifier<String?> lastError = ValueNotifier<String?>(null);
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  Future<void> _queue = Future.value();
  bool _disposed = false;
  Future<void> _serialized(Future<void> Function() action) {
    final next = _queue.then((_) => action());
    _queue = next.catchError((Object _) {});
    return next;
  }

  @override
  void watch() {
    if (_subscriptions.isNotEmpty) return;
    for (final stream in [
      db.select(db.tasks).watch(),
      db.select(db.companies).watch(),
      db.select(db.notifications).watch(),
    ]) {
      _subscriptions.add(
        stream.listen(
          (_) {
            if (!_disposed) {
              unawaited(
                reconcile().catchError((Object error) {
                  if (!_disposed) lastError.value = '$error';
                }),
              );
            }
          },
          onError: (Object error) {
            lastError.value = '$error';
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _disposed = true;
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    lastError.dispose();
  }

  @override
  Future<void> configure({
    int? taskId,
    int? companyId,
    required DateTime at,
  }) => _serialized(() async {
    if ((taskId == null) == (companyId == null)) {
      throw ArgumentError('알림 대상을 하나 선택하세요.');
    }
    if (!at.isAfter(DateTime.now())) throw ArgumentError('미래 시각을 선택하세요.');
    final rows = await db.select(db.notifications).get();
    final previous = rows
        .where(
          (r) => taskId != null ? r.taskId == taskId : r.companyId == companyId,
        )
        .firstOrNull;
    final int id;
    if (previous != null) {
      id = previous.id;
      await backend.cancel(previous.platformNotificationId);
    } else {
      id = await db
          .into(db.notifications)
          .insert(
            NotificationsCompanion.insert(
              taskId: Value(taskId),
              companyId: Value(companyId),
              scheduledAt: at.toUtc().toIso8601String(),
              isEnabled: const Value(false),
              platformNotificationId:
                  DateTime.now().millisecondsSinceEpoch % 2000000000,
            ),
          );
    }
    await (db.update(db.notifications)..where((t) => t.id.equals(id))).write(
      NotificationsCompanion(
        scheduledAt: Value(at.toUtc().toIso8601String()),
        isEnabled: const Value(false),
      ),
    );
    if (!await backend.permission(request: true)) {
      throw StateError('알림 권한이 없습니다. 원본 일정은 보존되었습니다.');
    }
    final row = await (db.select(
      db.notifications,
    )..where((t) => t.id.equals(id))).getSingle();
    final title = await _title(row.taskId, row.companyId);
    if (title == null) throw StateError('완료되었거나 삭제된 일정입니다.');
    try {
      await backend.schedule(
        row.platformNotificationId,
        title,
        at,
        taskId == null ? '/company/$companyId' : '/task/$taskId',
      );
      await (db.update(db.notifications)..where((t) => t.id.equals(id))).write(
        const NotificationsCompanion(isEnabled: Value(true)),
      );
      lastError.value = null;
    } catch (error) {
      lastError.value = '$error';
      rethrow;
    }
  });
  Future<String?> _title(int? taskId, int? companyId) async {
    if (taskId != null) {
      final task = await (db.select(
        db.tasks,
      )..where((t) => t.id.equals(taskId))).getSingleOrNull();
      return task == null || task.isCompleted ? null : task.title;
    }
    final company = await (db.select(
      db.companies,
    )..where((t) => t.id.equals(companyId!))).getSingleOrNull();
    return company == null ||
            [
              'REJECTED',
              'WITHDRAWN',
              'CANCELLED',
              'OFFER',
            ].contains(company.status)
        ? null
        : company.name;
  }

  @override
  Future<void> cancel(int id) => _serialized(() async {
    final row = await (db.select(
      db.notifications,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    await backend.cancel(row.platformNotificationId);
    await (db.update(db.notifications)..where((t) => t.id.equals(id))).write(
      const NotificationsCompanion(isEnabled: Value(false)),
    );
  });
  @override
  Future<void> reconcile() => _serialized(() async {
    final rows = await db.select(db.notifications).get();
    final desired = <int>{};
    final allowed = await backend.permission();
    for (final row in rows.where((r) => r.isEnabled)) {
      final title = await _title(row.taskId, row.companyId);
      final at = DateTime.parse(row.scheduledAt);
      if (title == null || !at.isAfter(DateTime.now()) || !allowed) {
        if (!allowed) {
          lastError.value = '알림 권한이 없어 예약을 해제했습니다. 원본 일정은 유지됩니다.';
        }
        await backend.cancel(row.platformNotificationId);
        await (db.update(db.notifications)..where((t) => t.id.equals(row.id)))
            .write(const NotificationsCompanion(isEnabled: Value(false)));
        continue;
      }
      desired.add(row.platformNotificationId);
      if (allowed) {
        await backend.schedule(
          row.platformNotificationId,
          title,
          at,
          row.taskId == null
              ? '/company/${row.companyId}'
              : '/task/${row.taskId}',
        );
      }
    }
    for (final id in await backend.pending()) {
      if (!desired.contains(id)) await backend.cancel(id);
    }
  });
}
