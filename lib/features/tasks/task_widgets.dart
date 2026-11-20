import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/common.dart';
import 'task_repository.dart';
import '../../core/notifications/reminder_dialog.dart';

const categoryLabels = {'GENERAL': '일반', 'STUDY': '학습', 'JOB': '취업'};
const priorities = ['낮음', '보통', '높음'];

class TaskList extends ConsumerWidget {
  const TaskList({super.key, required this.tasks});
  final List<Task> tasks;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sorted = [...tasks]..sort(compareTasks);
    if (sorted.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('등록된 할 일이 없습니다.'),
      );
    }
    final db = ref.watch(databaseProvider);
    return Column(
      children: [
        for (final task in sorted)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) =>
                  perform(context, () => db.completeTask(task, value!)),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Text(
              '${categoryLabels[task.category]} · ${priorities[task.priority]} · ${task.scheduledDate}${task.dueAt == null ? '' : ' · 마감 ${DateTime.parse(task.dueAt!).toLocal()}'}${!task.isCompleted && (task.dueAt != null ? DateTime.parse(task.dueAt!).isBefore(DateTime.now()) : task.scheduledDate.compareTo(dateKey(DateTime.now())) < 0) ? ' · 기한 경과' : ''}',
            ),
            onTap: () => editTask(context, db, task: task),
            trailing: PopupMenuButton<String>(
              tooltip: '할 일 메뉴',
              onSelected: (value) async {
                if (value == 'reminder') {
                  await configureReminder(context, ref, taskId: task.id);
                  return;
                }
                if (value == 'delete') {
                  if (await confirm(context, '이 할 일을 삭제할까요?') &&
                      context.mounted) {
                    await perform(context, () => db.deleteTask(task.id));
                  }
                }
                if (value == 'move' && context.mounted) {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null && context.mounted) {
                    await perform(
                      context,
                      () => db.moveTask(task, dateKey(date)),
                    );
                  }
                }
              },
              itemBuilder: (_) => [
                if (!task.isCompleted)
                  const PopupMenuItem(
                    value: 'reminder',
                    child: Text('알림 설정/재예약'),
                  ),
                if (!task.isCompleted)
                  const PopupMenuItem(value: 'move', child: Text('다른 날짜로 이월')),
                const PopupMenuItem(value: 'delete', child: Text('삭제')),
              ],
            ),
          ),
      ],
    );
  }
}

Future<void> editTask(
  BuildContext context,
  AppDatabase db, {
  Task? task,
  DateTime? initialDate,
}) async {
  final title = TextEditingController(text: task?.title);
  var category = task?.category ?? 'GENERAL';
  var priority = task?.priority ?? 1;
  var date = task == null
      ? (initialDate ?? DateTime.now())
      : DateTime.parse(task.scheduledDate);
  DateTime? due = task?.dueAt == null
      ? null
      : DateTime.parse(task!.dueAt!).toLocal();
  final form = GlobalKey<FormState>();
  var saving = false;
  await showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(task == null ? '할 일 추가' : '할 일 수정'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Form(
              key: form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: title,
                    maxLength: 200,
                    decoration: const InputDecoration(labelText: '제목'),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? '제목을 입력하세요.'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: category,
                    decoration: const InputDecoration(labelText: '유형'),
                    items: [
                      for (final entry in categoryLabels.entries)
                        DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                    ],
                    onChanged: (v) => setState(() => category = v!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    initialValue: priority,
                    decoration: const InputDecoration(labelText: '우선순위'),
                    items: [
                      for (var i = 0; i < 3; i++)
                        DropdownMenuItem(value: i, child: Text(priorities[i])),
                    ],
                    onChanged: (v) => setState(() => priority = v!),
                  ),
                  TextButton(
                    onPressed: () async {
                      final selected = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selected != null) setState(() => date = selected);
                    },
                    child: Text('예정일 ${dateKey(date)}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final day = await showDatePicker(
                        context: context,
                        initialDate: due ?? date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (day == null || !context.mounted) return;
                      final time = await showTimePicker(
                        context: context,
                        initialTime: due == null
                            ? const TimeOfDay(hour: 18, minute: 0)
                            : TimeOfDay.fromDateTime(due!),
                      );
                      if (time != null) {
                        setState(
                          () => due = DateTime(
                            day.year,
                            day.month,
                            day.day,
                            time.hour,
                            time.minute,
                          ),
                        );
                      }
                    },
                    child: Text(
                      due == null
                          ? '마감 시각 설정'
                          : '마감 ${dateKey(due!)} ${due!.hour}:${due!.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                  if (due != null)
                    TextButton(
                      onPressed: () => setState(() => due = null),
                      child: const Text('마감 시각 해제'),
                    ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: saving ? null : () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: saving
                ? null
                : () async {
                    if (!form.currentState!.validate()) return;
                    setState(() => saving = true);
                    await perform(context, () async {
                      await db.saveTask(
                        existing: task,
                        title: title.text,
                        category: category,
                        date: dateKey(date),
                        due: due?.toUtc().toIso8601String(),
                        priority: priority,
                        subjectId: task?.subjectId,
                        companyId: task?.companyId,
                      );
                      if (context.mounted) Navigator.pop(context);
                    });
                    if (context.mounted) setState(() => saving = false);
                  },
            child: const Text('저장'),
          ),
        ],
      ),
    ),
  );
  title.dispose();
}
