import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/common.dart';
import '../tasks/task_repository.dart';
import '../tasks/task_widgets.dart';
import '../study/study_repository.dart';
import '../jobs/job_repository.dart';

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
              ref
                  .watch(companiesProvider)
                  .when(
                    loading: () => const LinearProgressIndicator(),
                    error: (e, s) => Text('마감 조회 실패: $e'),
                    data: (companies) {
                      final deadlines =
                          companies
                              .where(
                                (c) =>
                                    deadlineWithin(c, DateTime.now(), 7) &&
                                    ![
                                      'REJECTED',
                                      'WITHDRAWN',
                                      'CANCELLED',
                                      'OFFER',
                                    ].contains(c.status),
                              )
                              .toList()
                            ..sort(
                              (a, b) =>
                                  a.deadlineDate!.compareTo(b.deadlineDate!),
                            );
                      return SectionCard(
                        title: '7일 이내 채용 마감',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: deadlines.isEmpty
                              ? [const Text('예정된 마감이 없습니다.')]
                              : [
                                  for (final company in deadlines)
                                    ListTile(
                                      title: Text(company.name),
                                      subtitle: Text(
                                        '${company.position} · ${company.deadlineDate}',
                                      ),
                                    ),
                                ],
                        ),
                      );
                    },
                  ),
              const SizedBox(height: 16),
              ref
                  .watch(sessionsProvider)
                  .when(
                    loading: () => const LinearProgressIndicator(),
                    error: (e, s) => Text('학습 시간 조회 실패: $e'),
                    data: (sessions) {
                      final start = weekStart(DateTime.now());
                      final end = start.add(const Duration(days: 7));
                      final seconds = sessions
                          .where((s) {
                            final time = DateTime.parse(s.startedAt).toLocal();
                            return !time.isBefore(start) && time.isBefore(end);
                          })
                          .fold<int>(0, (n, s) => n + s.durationSeconds);
                      return SectionCard(
                        title: '이번 주 학습',
                        child: Text(studyDuration(seconds)),
                      );
                    },
                  ),
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
