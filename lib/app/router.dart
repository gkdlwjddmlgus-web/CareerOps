import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/calendar/calendar_screen.dart';
import '../features/study/study_screen.dart';
import '../features/jobs/jobs_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/tasks/task_widgets.dart';
import '../core/database/database.dart';

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
    final db = ref.watch(databaseProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('할 일 상세')),
      body: StreamBuilder(
        stream: (db.select(
          db.tasks,
        )..where((t) => t.id.equals(id))).watchSingleOrNull(),
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.all(16),
          child: snapshot.hasError
              ? Text('${snapshot.error}')
              : snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snapshot.data == null
              ? const Text('삭제된 할 일입니다.')
              : TaskList(tasks: [snapshot.data!]),
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
