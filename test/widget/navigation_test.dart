import 'package:careerops/app/app.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('five tabs and settings are reachable', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CareerOpsApp()));
    await tester.pumpAndSettle();
    for (final name in ['학습', '취업', '일정', '리포트', '홈']) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(name),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('$name · 준비 중'), findsOneWidget);
    }
    await tester.tap(find.byTooltip('설정'));
    await tester.pumpAndSettle();
    expect(find.text('설정'), findsOneWidget);
  });
}
