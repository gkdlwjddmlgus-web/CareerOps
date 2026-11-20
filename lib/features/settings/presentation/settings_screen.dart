import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/common.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<SettingsScreen> {
  bool busy = false;
  String? message;
  Future<void> _run(Future<void> Function() action) async {
    setState(() => busy = true);
    await perform(context, action);
    if (mounted) setState(() => busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final backup = ref.watch(backupRepositoryProvider);
    final service = ref.watch(notificationServiceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionCard(
            title: 'CareerOps 0.1.0',
            child: Text(
              '기기 설정에 따라 라이트·다크 모드가 적용됩니다.\n데이터는 이 기기의 앱 전용 저장소에 보관됩니다. 앱 삭제 전 백업하세요.',
            ),
          ),
          SectionCard(
            title: '데이터 백업 및 복원',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  onPressed: busy
                      ? null
                      : () => _run(() async {
                          final text = await backup.export();
                          final path = await FilePicker.saveFile(
                            dialogTitle: 'CareerOps JSON 백업',
                            fileName:
                                'careerops-${DateTime.now().millisecondsSinceEpoch}.json',
                            bytes: Uint8List.fromList(utf8.encode(text)),
                          );
                          if (path != null && mounted) {
                            setState(() => message = '백업을 저장했습니다: $path');
                          }
                        }),
                  child: const Text('JSON 백업 저장'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: busy
                      ? null
                      : () => _run(() async {
                          final file = await FilePicker.pickFile(
                            type: FileType.custom,
                            allowedExtensions: ['json'],
                          );
                          if (file == null) return;
                          final size = await file.length();
                          if (size == null || size > 20 * 1024 * 1024) {
                            throw const FormatException(
                              '20MB 이하 백업 파일을 선택하세요.',
                            );
                          }
                          final text = utf8.decode(await file.readAsBytes());
                          backup.validate(text);
                          if (!context.mounted) return;
                          if (!await confirm(
                            context,
                            '현재 데이터를 선택한 백업으로 교체합니다. 복원 직전 데이터는 앱 내부에 안전 백업됩니다. 계속할까요?',
                          )) {
                            return;
                          }
                          final safety = await backup.restore(text);
                          String? notificationError;
                          try {
                            await service.reconcile();
                          } catch (error) {
                            notificationError = '알림을 재예약하지 못했습니다. 권한을 확인해 주세요.';
                          }
                          if (mounted) {
                            setState(
                              () => message =
                                  '데이터 복원을 완료했습니다. 이전 데이터 안전 백업: $safety${notificationError == null ? '' : '\n$notificationError'}',
                            );
                          }
                        }),
                  child: const Text('파일에서 복원'),
                ),
                TextButton(
                  onPressed: busy
                      ? null
                      : () => _run(() async {
                          final text = await backup.previousRestoreBackup();
                          if (text == null) {
                            if (mounted) {
                              setState(() => message = '직전 복원 안전 백업이 없습니다.');
                            }
                            return;
                          }
                          if (!context.mounted ||
                              !await confirm(
                                context,
                                '직전 복원 전의 데이터로 되돌릴까요? 현재 데이터도 안전 백업됩니다.',
                              )) {
                            return;
                          }
                          await backup.restore(text);
                          await service.reconcile();
                          if (mounted) {
                            setState(() => message = '직전 복원 전 데이터로 되돌렸습니다.');
                          }
                        }),
                  child: const Text('직전 복원 되돌리기'),
                ),
                const SizedBox(height: 16),
                const Text(
                  '복원은 전체 데이터 교체 방식입니다. 잘못된 파일이나 참조 오류가 있으면 기존 데이터를 유지합니다. 백업에는 개인 메모가 포함됩니다.',
                ),
                if (message != null) SelectableText(message!),
              ],
            ),
          ),
          SectionCard(
            title: '알림',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '할 일 메뉴와 기업 상세에서 알림 시각을 설정하세요. 기기의 절전 정책에 따라 알림이 지연될 수 있습니다.',
                ),
                TextButton(
                  onPressed: busy
                      ? null
                      : () => _run(() async {
                          final allowed = await ref
                              .read(notificationServiceProvider)
                              .permission(request: true);
                          if (mounted) {
                            setState(
                              () => message = allowed
                                  ? '알림 권한을 허용했습니다.'
                                  : '알림 권한이 없습니다. 기기 설정을 확인하세요.',
                            );
                          }
                        }),
                  child: const Text('Android 알림 권한 확인'),
                ),
                ValueListenableBuilder(
                  valueListenable: service.lastError,
                  builder: (context, error, child) => error == null
                      ? const SizedBox.shrink()
                      : Text('알림을 처리하지 못했습니다. 권한과 기기 설정을 확인해 주세요.'),
                ),
                ref
                    .watch(notificationsProvider)
                    .when(
                      loading: () => const LinearProgressIndicator(),
                      error: (e, s) => Text('데이터를 불러오지 못했습니다. 다시 열어 주세요.'),
                      data: (rows) => Column(
                        children: [
                          for (final row in rows)
                            ListTile(
                              title: Text(
                                '${row.taskId == null ? '기업' : '할 일'} #${row.taskId ?? row.companyId}',
                              ),
                              subtitle: Text(
                                '${DateTime.parse(row.scheduledAt).toLocal()} · ${row.isEnabled ? '예약됨' : '해제/미예약'}',
                              ),
                              trailing: row.isEnabled
                                  ? IconButton(
                                      tooltip: '알림 취소',
                                      onPressed: busy
                                          ? null
                                          : () => _run(
                                              () => service.cancel(row.id),
                                            ),
                                      icon: const Icon(
                                        Icons.notifications_off_outlined,
                                      ),
                                    )
                                  : null,
                            ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          if (busy) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
