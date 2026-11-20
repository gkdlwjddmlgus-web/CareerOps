import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../database/database.dart';
import 'backup_service.dart';
import 'backup_repository.dart';

class LocalBackupRepository implements BackupRepository {
  LocalBackupRepository(AppDatabase db) : service = BackupService(db);
  final BackupService service;
  @override
  Future<String> export() => service.export();
  @override
  void validate(String text) {
    service.validate(text);
  }

  @override
  Future<String> restore(String text) async {
    validate(text);
    final directory = await getApplicationSupportDirectory();
    final safety = File(
      '${directory.path}/before-restore-${DateTime.now().millisecondsSinceEpoch}.json',
    );
    await safety.writeAsString(await service.export(), flush: true);
    await service.restore(text);
    return safety.path;
  }

  @override
  Future<String?> previousRestoreBackup() async {
    final directory = await getApplicationSupportDirectory();
    final files = await directory
        .list()
        .where(
          (entry) =>
              entry is File &&
              entry.path.contains('before-restore-') &&
              entry.path.endsWith('.json'),
        )
        .cast<File>()
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    return files.isEmpty ? null : files.first.readAsString();
  }
}
