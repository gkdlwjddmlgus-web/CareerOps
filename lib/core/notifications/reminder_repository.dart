import 'package:flutter/foundation.dart';

class Reminder {
  const Reminder({
    required this.id,
    this.taskId,
    this.companyId,
    required this.scheduledAt,
    required this.isEnabled,
    required this.platformNotificationId,
  });
  final int id, platformNotificationId;
  final int? taskId, companyId;
  final String scheduledAt;
  final bool isEnabled;
}

abstract interface class ReminderRepository {
  ValueListenable<String?> get lastError;
  Stream<List<Reminder>> watchReminders();
  Future<bool> permission({bool request = false});
  Future<void> configure({int? taskId, int? companyId, required DateTime at});
  Future<void> cancel(int id);
  Future<void> reconcile();
  void watch();
  void dispose();
}
