import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/router.dart';
import 'core/notifications/notification_service.dart';
import 'app/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final backend = AndroidNotificationBackend();
  String? initialPayload;
  var started = false;
  String? startupError;
  void open(String payload) {
    if (!RegExp(r'^/(task|company)/[1-9][0-9]*$').hasMatch(payload)) return;
    if (started) {
      appRouter.go(payload);
    } else {
      initialPayload = payload;
    }
  }

  try {
    await backend.initialize(open);
  } catch (error) {
    startupError = '$error';
  }
  final container = ProviderContainer(
    overrides: [notificationBackendProvider.overrideWithValue(backend)],
  );
  final service = container.read(notificationServiceProvider);
  if (service is NotificationService) service.lastError.value = startupError;
  service.watch();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const CareerOpsApp(),
    ),
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    started = true;
    if (initialPayload != null) appRouter.go(initialPayload!);
  });
}
