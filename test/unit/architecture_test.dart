import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('presentation and domain have no SQLite, HTTP or data implementation imports', () {
    final files = Directory('lib/features')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) {
          final path = f.path.replaceAll('\\', '/');
          return path.endsWith('.dart') &&
              (path.contains('/presentation/') || path.contains('/domain/'));
        });
    for (final file in files) {
      final source = file.readAsStringSync();
      for (final forbidden in [
        'package:drift/',
        'package:sqlite3/',
        'package:http/',
        'core/database/',
        '/data/',
        'databaseProvider',
        'AppDatabase',
        'QueryRow',
      ]) {
        expect(
          source.contains(forbidden),
          isFalse,
          reason: '${file.path} must not depend on $forbidden',
        );
      }
    }
    expect(files, isNotEmpty);
  });
}
