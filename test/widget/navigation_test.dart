import 'package:careerops/app/app.dart';
import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/tasks/task_repository.dart';
import 'package:careerops/core/utils/dates.dart';
import 'package:drift/native.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('five tabs and settings are reachable', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.runAsync(
      () => db.saveTask(
        title: '공유 일정',
        category: 'STUDY',
        date: dateKey(DateTime.now()),
        priority: 2,
      ),
    );
    final rows = await tester.runAsync(() => db.select(db.tasks).get());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          tasksProvider.overrideWith((ref) => Stream.value(rows!)),
        ],
        child: const CareerOpsApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('공유 일정'), findsOneWidget);
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
        expect(find.text('공유 일정'), findsOneWidget);
      }
    }
    await tester.tap(find.byTooltip('설정'));
    await tester.pumpAndSettle();
    expect(find.text('설정'), findsOneWidget);
  });
}
