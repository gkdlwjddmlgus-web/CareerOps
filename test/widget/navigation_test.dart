import 'package:careerops/app/app.dart';
import 'package:careerops/app/providers.dart';
import 'package:careerops/core/utils/dates.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_repositories.dart';

void main() {
  testWidgets('five tabs and settings are reachable', (tester) async {
    final tasks = MemoryTaskRepository();
    final reminders = FakeReminderRepository();
    addTearDown(tasks.close);
    addTearDown(reminders.dispose);
    await tasks.saveTask(
      title: '공유 일정',
      category: 'STUDY',
      date: dateKey(DateTime.now()),
      priority: 2,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          taskRepositoryProvider.overrideWithValue(tasks),
          studyServiceProvider.overrideWithValue(FakeStudyRepository()),
          jobRepositoryProvider.overrideWithValue(FakeJobRepository()),
          reportRepositoryProvider.overrideWithValue(FakeReportRepository()),
          backupRepositoryProvider.overrideWithValue(FakeBackupRepository()),
          notificationServiceProvider.overrideWithValue(reminders),
          tickProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const CareerOpsApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('공유 일정'), findsOneWidget);
    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    expect(tasks.rows.single.isCompleted, isTrue);
    for (final name in ['학습', '취업', '일정', '리포트', '홈']) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(name),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(NavigationBar), findsOneWidget);
      if (name == '일정' || name == '홈') {
        await tester.scrollUntilVisible(
          find.text('공유 일정'),
          150,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        expect(find.text('공유 일정'), findsOneWidget);
      }
    }
    await tester.tap(find.byTooltip('설정'));
    await tester.pumpAndSettle();
    expect(find.text('설정'), findsOneWidget);
  });
}
