import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/calendar/calendar_screen.dart';
import '../features/study/study_screen.dart';

const tabNames = ['홈', '학습', '취업', '일정', '리포트'];
const tabPaths = ['/', '/study', '/jobs', '/calendar', '/reports'];
const tabIcons = [
  Icons.home_outlined,
  Icons.menu_book,
  Icons.work_outline,
  Icons.calendar_month,
  Icons.bar_chart,
];

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(path: state.uri.path, child: child),
      routes: [
        for (var i = 0; i < tabPaths.length; i++)
          GoRoute(
            path: tabPaths[i],
            builder: (context, state) => switch (i) {
              0 => const HomeScreen(),
              1 => const StudyScreen(),
              3 => const CalendarScreen(),
              _ => Center(child: Text('${tabNames[i]} · 준비 중')),
            },
          ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('설정')),
        body: const Center(child: Text('기기 설정에 따라 밝은 테마와 어두운 테마가 적용됩니다.')),
      ),
    ),
  ],
);

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.path, required this.child});
  final String path;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final index = tabPaths.indexOf(path);
    return Scaffold(
      appBar: AppBar(
        title: Text(index == 0 ? 'CareerOps' : tabNames[index < 0 ? 0 : index]),
        actions: [
          if (index == 0)
            IconButton(
              tooltip: '설정',
              onPressed: () => context.push('/settings'),
              icon: const Icon(Icons.settings_outlined),
            ),
        ],
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index < 0 ? 0 : index,
        onDestinationSelected: (value) => context.go(tabPaths[value]),
        destinations: [
          for (var i = 0; i < tabNames.length; i++)
            NavigationDestination(icon: Icon(tabIcons[i]), label: tabNames[i]),
        ],
      ),
    );
  }
}
