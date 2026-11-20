import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_screen.dart';
import '../features/calendar/presentation/calendar_screen.dart';
import '../features/study/presentation/study_screen.dart';
import '../features/jobs/presentation/jobs_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/tasks/presentation/task_widgets.dart';
import 'providers.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              2 => const JobsScreen(),
              3 => const CalendarScreen(),
              4 => const ReportsScreen(),
              _ => Center(child: Text('${tabNames[i]} · 준비 중')),
            },
          ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) =>
          TaskDetailScreen(id: int.parse(state.pathParameters['id']!)),
    ),
    GoRoute(
      path: '/company/:id',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('기업 상세')),
        body: JobsScreen(companyId: int.parse(state.pathParameters['id']!)),
      ),
    ),
  ],
);

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('할 일 상세')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ref
            .watch(taskProvider(id))
            .when(
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => Text('$e'),
              data: (task) => task == null
                  ? const Text('삭제된 할 일입니다.')
                  : TaskList(tasks: [task]),
            ),
      ),
    );
  }
}

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
