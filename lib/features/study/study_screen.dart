import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/common.dart';
import 'study_repository.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(studyServiceProvider);
    final units = ref.watch(unitsProvider).value ?? <StudyUnit>[];
    final sessions = ref.watch(sessionsProvider).value ?? <StudySession>[];
    final timer = ref.watch(timerProvider).value;
    ref.watch(tickProvider);
    return ref
        .watch(subjectsProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('$e')),
          data: (subjects) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FilledButton.icon(
                onPressed: () => editSubject(context, service),
                icon: const Icon(Icons.add),
                label: const Text('과목 추가'),
              ),
              if (timer != null)
                SectionCard(
                  title:
                      '학습 타이머 · ${subjects.where((s) => s.id == timer.subjectId).firstOrNull?.name ?? ''}',
                  child: Column(
                    children: [
                      Text(
                        '${studyDuration(service.elapsed(timer))} ${service.elapsed(timer) % 60}초',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(switch (timer.state) {
                        'Running' => '학습 중',
                        'Paused' => '일시정지',
                        _ => '종료 · 저장 대기',
                      }),
                      Wrap(
                        spacing: 8,
                        children: [
                          if (timer.state == 'Running')
                            TextButton(
                              onPressed: () => perform(
                                context,
                                () => service.transition('Paused'),
                              ),
                              child: const Text('일시정지'),
                            ),
                          if (timer.state == 'Paused')
                            TextButton(
                              onPressed: () => perform(
                                context,
                                () => service.transition('Running'),
                              ),
                              child: const Text('재개'),
                            ),
                          if (timer.state != 'Completed')
                            TextButton(
                              onPressed: () => perform(
                                context,
                                () => service.transition('Completed'),
                              ),
                              child: const Text('종료'),
                            ),
                          if (timer.state == 'Completed')
                            FilledButton(
                              onPressed: () =>
                                  perform(context, service.saveTimer),
                              child: const Text('기록 저장'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (subjects.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('과목을 추가하고 학습을 시작하세요.'),
                ),
              for (final subject in subjects)
                Card(
                  child: ExpansionTile(
                    title: Text(subject.name),
                    subtitle: Text(
                      '${subject.description}\n목표 ${subject.targetMinutes}분 · 누적 ${studyDuration(sessions.where((s) => s.subjectId == subject.id).fold(0, (n, s) => n + s.durationSeconds))}\n단원 ${units.where((u) => u.subjectId == subject.id && u.isCompleted).length}/${units.where((u) => u.subjectId == subject.id).length} 완료',
                    ),
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          TextButton(
                            onPressed: timer == null
                                ? () => perform(
                                    context,
                                    () => service.start(subject.id),
                                  )
                                : null,
                            child: const Text('타이머 시작'),
                          ),
                          TextButton(
                            onPressed: () =>
                                manualSession(context, service, subject),
                            child: const Text('수동 기록'),
                          ),
                          TextButton(
                            onPressed: () =>
                                editSubject(context, service, subject: subject),
                            child: const Text('과목 수정'),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (await confirm(
                                    context,
                                    '과목을 삭제할까요? 학습 기록이나 타이머가 있으면 삭제할 수 없습니다.',
                                  ) &&
                                  context.mounted) {
                                await perform(
                                  context,
                                  () => service.deleteSubject(subject.id),
                                );
                              }
                            },
                            child: const Text('과목 삭제'),
                          ),
                        ],
                      ),
                      for (final unit in units.where(
                        (u) => u.subjectId == subject.id,
                      ))
                        ListTile(
                          leading: Checkbox(
                            value: unit.isCompleted,
                            onChanged: (v) => perform(
                              context,
                              () => service.completeUnit(unit, v!),
                            ),
                          ),
                          title: Text(unit.title),
                          onTap: () => editUnit(
                            context,
                            service,
                            subject.id,
                            unit: unit,
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (v) async {
                              if (v == 'start') {
                                await perform(
                                  context,
                                  () => service.start(
                                    subject.id,
                                    unitId: unit.id,
                                  ),
                                );
                              }
                              if (context.mounted &&
                                  v == 'delete' &&
                                  await confirm(context, '이 단원을 삭제할까요?') &&
                                  context.mounted) {
                                await perform(
                                  context,
                                  () => service.deleteUnit(unit.id),
                                );
                              }
                            },
                            itemBuilder: (_) => [
                              if (timer == null)
                                const PopupMenuItem(
                                  value: 'start',
                                  child: Text('이 단원 학습 시작'),
                                ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('단원 삭제'),
                              ),
                            ],
                          ),
                        ),
                      TextButton.icon(
                        onPressed: () => editUnit(context, service, subject.id),
                        icon: const Icon(Icons.add),
                        label: const Text('단원 추가'),
                      ),
                      for (final session
                          in sessions
                              .where((s) => s.subjectId == subject.id)
                              .take(30))
                        ListTile(
                          title: Text(
                            '${studyDuration(session.durationSeconds)} · ${session.source == 'TIMER' ? '타이머' : '수동'}',
                          ),
                          subtitle: Text(
                            '${DateTime.parse(session.startedAt).toLocal()}\n${session.note}',
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
  }
}

Future<void> editSubject(
  BuildContext context,
  StudyService service, {
  Subject? subject,
}) async {
  final name = TextEditingController(text: subject?.name),
      description = TextEditingController(text: subject?.description),
      target = TextEditingController(text: '${subject?.targetMinutes ?? 0}');
  final form = GlobalKey<FormState>();
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(subject == null ? '과목 추가' : '과목 수정'),
      content: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
                maxLength: 200,
                decoration: const InputDecoration(labelText: '과목명'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? '과목명을 입력하세요.' : null,
              ),
              TextFormField(
                controller: description,
                decoration: const InputDecoration(labelText: '학습 목표'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: target,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '목표 시간(분)'),
                validator: (v) => (int.tryParse(v ?? '') ?? -1) < 0
                    ? '0 이상의 분을 입력하세요.'
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: () async {
            if (!form.currentState!.validate()) return;
            await perform(context, () async {
              await service.saveSubject(
                existing: subject,
                name: name.text,
                description: description.text,
                targetMinutes: int.parse(target.text),
              );
              if (context.mounted) Navigator.pop(context);
            });
          },
          child: const Text('저장'),
        ),
      ],
    ),
  );
  name.dispose();
  description.dispose();
  target.dispose();
}

Future<void> editUnit(
  BuildContext context,
  StudyService service,
  int subjectId, {
  StudyUnit? unit,
}) async {
  final title = TextEditingController(text: unit?.title);
  final form = GlobalKey<FormState>();
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(unit == null ? '단원 추가' : '단원 수정'),
      content: Form(
        key: form,
        child: TextFormField(
          controller: title,
          maxLength: 200,
          decoration: const InputDecoration(labelText: '단원명'),
          validator: (v) =>
              v == null || v.trim().isEmpty ? '단원명을 입력하세요.' : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: () async {
            if (!form.currentState!.validate()) return;
            await perform(context, () async {
              await service.saveUnit(subjectId, title.text, existing: unit);
              if (context.mounted) Navigator.pop(context);
            });
          },
          child: const Text('저장'),
        ),
      ],
    ),
  );
  title.dispose();
}

Future<void> manualSession(
  BuildContext context,
  StudyService service,
  Subject subject,
) async {
  final minutes = TextEditingController(), note = TextEditingController();
  var date = DateTime.now().subtract(const Duration(hours: 1));
  final form = GlobalKey<FormState>();
  await showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text('${subject.name} 수동 기록'),
        content: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: minutes,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '학습 시간(분)'),
                  validator: (v) =>
                      (int.tryParse(v ?? '') ?? 0) <= 0 ||
                          (int.tryParse(v ?? '') ?? 0) > 1440
                      ? '1~1440분을 입력하세요.'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: note,
                  decoration: const InputDecoration(labelText: '메모'),
                ),
                TextButton(
                  onPressed: () async {
                    final day = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (day == null || !context.mounted) return;
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(date),
                    );
                    if (time != null) {
                      setState(
                        () => date = DateTime(
                          day.year,
                          day.month,
                          day.day,
                          time.hour,
                          time.minute,
                        ),
                      );
                    }
                  },
                  child: Text('시작 $date'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () async {
              if (!form.currentState!.validate()) return;
              await perform(context, () async {
                await service.manual(
                  subjectId: subject.id,
                  startedAt: date,
                  seconds: int.parse(minutes.text) * 60,
                  note: note.text,
                );
                if (context.mounted) Navigator.pop(context);
              });
            },
            child: const Text('저장'),
          ),
        ],
      ),
    ),
  );
  minutes.dispose();
  note.dispose();
}
