import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/common.dart';
import '../tasks/task_repository.dart';
import '../tasks/task_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(tasksProvider)
      .when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('불러오기 실패: $e')),
        data: (tasks) {
          final today = dateKey(DateTime.now());
          final current = tasks.where((t) => t.scheduledDate == today).toList();
          final overdue = tasks
              .where(
                (t) => !t.isCompleted && t.scheduledDate.compareTo(today) < 0,
              )
              .toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(today, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => editTask(context, ref.read(databaseProvider)),
                icon: const Icon(Icons.add),
                label: const Text('할 일 추가'),
              ),
              const SizedBox(height: 16),
              SectionCard(
                title:
                    '오늘 할 일 · ${current.where((t) => t.isCompleted).length}/${current.length} 완료',
                child: TaskList(tasks: current),
              ),
              if (overdue.isNotEmpty)
                SectionCard(
                  title: '이전 날짜 미완료 · ${overdue.length}건',
                  child: TaskList(tasks: overdue),
                ),
            ],
          );
        },
      );
}
