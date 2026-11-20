import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/utils/dates.dart';
import '../../core/widgets/common.dart';
import 'job_repository.dart';
import '../../core/notifications/reminder_dialog.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key, this.companyId});
  final int? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    final events = ref.watch(eventsProvider).value ?? <ApplicationEvent>[];
    return ref
        .watch(companiesProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('$e')),
          data: (companies) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FilledButton.icon(
                onPressed: () => editCompany(context, db),
                icon: const Icon(Icons.add),
                label: const Text('기업 추가'),
              ),
              if (companies.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('관심 기업과 입사지원 정보를 등록하세요.'),
                ),
              for (final company in companies.where(
                (c) => companyId == null || c.id == companyId,
              ))
                Card(
                  child: ExpansionTile(
                    initiallyExpanded: companyId != null,
                    title: Text(company.name),
                    subtitle: Text(
                      '${company.position} · ${statusLabels[company.status]}\n마감 ${company.deadlineDate ?? '미정'}${company.deadlineDate != null && company.deadlineDate!.compareTo(dateKey(DateTime.now())) < 0 ? ' · 기한 경과' : ''}',
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '지역: ${company.region}\n최초 지원일: ${company.firstAppliedAt == null ? '미지원' : dateKey(DateTime.parse(company.firstAppliedAt!).toLocal())}\n${company.note}',
                            ),
                            if (company.jobUrl.isNotEmpty)
                              SelectableText(company.jobUrl),
                            Text(
                              '생성 ${DateTime.parse(company.createdAt).toLocal()}\n수정 ${DateTime.parse(company.updatedAt).toLocal()}',
                            ),
                            Wrap(
                              spacing: 8,
                              children: [
                                TextButton(
                                  onPressed: () => configureReminder(
                                    context,
                                    ref,
                                    companyId: company.id,
                                  ),
                                  child: const Text('알림 설정/재예약'),
                                ),
                                TextButton(
                                  onPressed: () => editCompany(
                                    context,
                                    db,
                                    company: company,
                                  ),
                                  child: const Text('기업/상태 수정'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (await confirm(
                                          context,
                                          '기업과 상태 이력을 삭제할까요?',
                                        ) &&
                                        context.mounted) {
                                      await perform(
                                        context,
                                        () => db.deleteCompany(company.id),
                                      );
                                    }
                                  },
                                  child: const Text('삭제'),
                                ),
                              ],
                            ),
                            const Divider(),
                            const Text('지원 상태 변경 이력'),
                            for (final event in events.where(
                              (e) => e.companyId == company.id,
                            ))
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Text(
                                  '${event.fromStatus == null ? '등록' : statusLabels[event.fromStatus]} → ${statusLabels[event.toStatus]}\n${DateTime.parse(event.changedAt).toLocal()}',
                                ),
                              ),
                          ],
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

Future<void> editCompany(
  BuildContext context,
  AppDatabase db, {
  Company? company,
}) async {
  final name = TextEditingController(text: company?.name),
      position = TextEditingController(text: company?.position),
      region = TextEditingController(text: company?.region),
      url = TextEditingController(text: company?.jobUrl),
      note = TextEditingController(text: company?.note);
  var status = company?.status ?? 'INTERESTED';
  String? deadline = company?.deadlineDate;
  var saving = false;
  final form = GlobalKey<FormState>();
  await showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(company == null ? '기업 추가' : '기업/상태 수정'),
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
                    controller: name,
                    maxLength: 200,
                    decoration: const InputDecoration(labelText: '기업명'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? '기업명을 입력하세요.' : null,
                  ),
                  TextFormField(
                    controller: position,
                    decoration: const InputDecoration(labelText: '지원 직무'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: region,
                    decoration: const InputDecoration(labelText: '지역'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: url,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(labelText: '채용공고 URL'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return null;
                      final uri = Uri.tryParse(v);
                      return uri == null ||
                              !['http', 'https'].contains(uri.scheme) ||
                              uri.host.isEmpty
                          ? 'http 또는 https 주소를 입력하세요.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: '지원 상태'),
                    items: [
                      for (final entry in statusLabels.entries)
                        DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                    ],
                    onChanged: (v) => setState(() => status = v!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: note,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: '메모'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final day = await showDatePicker(
                        context: context,
                        initialDate: deadline == null
                            ? DateTime.now()
                            : DateTime.parse(deadline!),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (day != null) setState(() => deadline = dateKey(day));
                    },
                    child: Text('지원 마감일 ${deadline ?? '설정'}'),
                  ),
                  if (deadline != null)
                    TextButton(
                      onPressed: () => setState(() => deadline = null),
                      child: const Text('마감일 해제'),
                    ),
                  const Text('최초 지원일은 처음 “지원 완료”로 변경할 때 기록됩니다.'),
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
                      await db.saveCompany(
                        existing: company,
                        name: name.text,
                        position: position.text,
                        region: region.text,
                        url: url.text,
                        status: status,
                        note: note.text,
                        deadline: deadline,
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
  for (final c in [name, position, region, url, note]) {
    c.dispose();
  }
}
