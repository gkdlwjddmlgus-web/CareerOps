import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/dates.dart';
import '../../../core/widgets/common.dart';
import '../../tasks/task_repository.dart';
import '../../tasks/presentation/task_widgets.dart';
import '../../jobs/job_repository.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});
  @override
  ConsumerState<CalendarScreen> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<CalendarScreen> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      ref
          .watch(companiesProvider)
          .when(
            loading: () => const LinearProgressIndicator(),
            error: (e, s) => Text('데이터를 불러오지 못했습니다. 다시 열어 주세요.'),
            data: (companies) => SectionCard(
              title: '선택 날짜 채용 마감',
              child: Column(
                children: [
                  for (final company in companies.where(
                    (c) => c.deadlineDate == dateKey(date),
                  ))
                    ListTile(
                      title: Text(company.name),
                      subtitle: Text(company.position),
                    ),
                ],
              ),
            ),
          ),
      CalendarDatePicker(
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onDateChanged: (value) => setState(() => date = value),
      ),
      FilledButton.icon(
        onPressed: () => editTask(
          context,
          ref.read(taskRepositoryProvider),
          initialDate: date,
        ),
        icon: const Icon(Icons.add),
        label: const Text('선택 날짜에 일정 추가'),
      ),
      ref
          .watch(tasksProvider)
          .when(
            loading: () => const LinearProgressIndicator(),
            error: (e, s) => Text('데이터를 불러오지 못했습니다. 다시 열어 주세요.'),
            data: (tasks) => SectionCard(
              title: dateKey(date),
              child: TaskList(
                tasks: tasks
                    .where((t) => t.scheduledDate == dateKey(date))
                    .toList(),
              ),
            ),
          ),
    ],
  );
}
