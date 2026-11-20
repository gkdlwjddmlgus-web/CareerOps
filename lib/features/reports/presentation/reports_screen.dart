import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/dates.dart';
import '../../../core/widgets/common.dart';
import '../../../core/domain/application_status.dart';
import '../report_repository.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});
  @override
  ConsumerState<ReportsScreen> createState() => _ReportsState();
}

class _ReportsState extends ConsumerState<ReportsScreen> {
  DateTime start = weekStart(DateTime.now());
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Row(
        children: [
          IconButton(
            tooltip: '이전 주',
            onPressed: () => setState(
              () => start = DateTime(start.year, start.month, start.day - 7),
            ),
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Text(
              '${dateKey(start)} ~ ${dateKey(DateTime(start.year, start.month, start.day + 6))}',
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            tooltip: '다음 주',
            onPressed: () => setState(
              () => start = DateTime(start.year, start.month, start.day + 7),
            ),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
      ref
          .watch(reportProvider(start))
          .when(
            loading: () => const LinearProgressIndicator(),
            error: (e, s) => Text('리포트를 불러오지 못했습니다. 다시 열어 주세요.'),
            data: (rows) {
              int value(String kind) => rows
                  .where((r) => r.kind == kind)
                  .fold<int>(0, (n, r) => n + r.value);
              final total = value('tasks_total'),
                  done = value('tasks_done'),
                  units = value('units_total'),
                  completed = value('units_done');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionCard(
                    title: '주간 학습 시간',
                    child: Text(
                      studyDuration(value('daily')),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SectionCard(
                    title: '일별 학습 시간 · 학습 시작일 기준',
                    child: Column(
                      children: [
                        for (var i = 0; i < 7; i++)
                          Builder(
                            builder: (context) {
                              final date = dateKey(
                                DateTime(
                                  start.year,
                                  start.month,
                                  start.day + i,
                                ),
                              );
                              final seconds = rows
                                  .where(
                                    (r) => r.kind == 'daily' && r.label == date,
                                  )
                                  .fold<int>(0, (n, r) => n + r.value);
                              return ListTile(
                                title: Text(date),
                                trailing: Text(studyDuration(seconds)),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  SectionCard(
                    title: '과목별 주간 학습',
                    child: Column(
                      children: [
                        for (final row in rows.where(
                          (r) => r.kind == 'subject',
                        ))
                          ListTile(
                            title: Text(row.label),
                            trailing: Text(studyDuration(row.value)),
                          ),
                      ],
                    ),
                  ),
                  SectionCard(
                    title: '주간 계획 완료율',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '$done / $total · ${total == 0 ? 0 : (done * 100 / total).round()}%',
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: total == 0 ? 0 : done / total,
                        ),
                      ],
                    ),
                  ),
                  SectionCard(
                    title: '주간 최초 지원',
                    child: Text('${value('applications')}건'),
                  ),
                  SectionCard(
                    title: '현재 지원 단계 · 전체 기업',
                    child: Column(
                      children: [
                        for (final entry in statusLabels.entries)
                          ListTile(
                            title: Text(entry.value),
                            trailing: Text(
                              '${rows.where((r) => r.kind == 'stage' && r.label == entry.key).fold<int>(0, (n, r) => n + r.value)}개',
                            ),
                          ),
                      ],
                    ),
                  ),
                  SectionCard(
                    title: '전체 학습 단원 완료율',
                    child: Text(
                      '$completed / $units · ${units == 0 ? 0 : (completed * 100 / units).round()}%',
                    ),
                  ),
                ],
              );
            },
          ),
    ],
  );
}
