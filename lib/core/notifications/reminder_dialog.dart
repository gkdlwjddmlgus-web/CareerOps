import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/common.dart';
import 'notification_service.dart';

Future<void> configureReminder(
  BuildContext context,
  WidgetRef ref, {
  int? taskId,
  int? companyId,
}) async {
  final day = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
  if (day == null || !context.mounted) return;
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(
      DateTime.now().add(const Duration(hours: 1)),
    ),
  );
  if (time == null || !context.mounted) return;
  await perform(context, () async {
    await ref
        .read(notificationServiceProvider)
        .configure(
          taskId: taskId,
          companyId: companyId,
          at: DateTime(day.year, day.month, day.day, time.hour, time.minute),
        );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알림을 예약했습니다. 기기 절전 설정에 따라 지연될 수 있습니다.')),
      );
    }
  });
}
