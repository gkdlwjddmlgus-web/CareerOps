import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/utils/dates.dart';

const statusLabels = {
  'INTERESTED': '관심',
  'PREPARING': '준비 중',
  'APPLIED': '지원 완료',
  'SCREENING': '서류 전형',
  'INTERVIEW': '면접',
  'OFFER': '합격 제안',
  'REJECTED': '불합격',
  'WITHDRAWN': '지원 철회',
  'CANCELLED': '채용 취소',
};
final companiesProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.companies,
  )..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).watch();
});
final eventsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.applicationEvents)..orderBy([
        (t) => OrderingTerm.desc(t.changedAt),
        (t) => OrderingTerm.desc(t.id),
      ]))
      .watch();
});

bool deadlineWithin(Company company, DateTime now, int days) =>
    company.deadlineDate != null &&
    company.deadlineDate!.compareTo(dateKey(now)) >= 0 &&
    company.deadlineDate!.compareTo(dateKey(now.add(Duration(days: days)))) <=
        0;

extension JobRepository on AppDatabase {
  Future<void> saveCompany({
    Company? existing,
    required String name,
    required String position,
    required String region,
    required String url,
    required String status,
    required String note,
    String? deadline,
  }) => transaction(() async {
    if (name.trim().isEmpty || !statusLabels.containsKey(status)) {
      throw ArgumentError('기업명과 지원 상태를 확인하세요.');
    }
    if (url.isNotEmpty) {
      final uri = Uri.tryParse(url);
      if (uri == null ||
          !['http', 'https'].contains(uri.scheme) ||
          uri.host.isEmpty) {
        throw ArgumentError('공고 URL은 http 또는 https 주소여야 합니다.');
      }
    }
    final old = existing == null
        ? null
        : await (select(
            companies,
          )..where((t) => t.id.equals(existing.id))).getSingle();
    final stamp = utcNow();
    final first = old?.firstAppliedAt ?? (status == 'APPLIED' ? stamp : null);
    final row = CompaniesCompanion(
      name: Value(name.trim()),
      position: Value(position),
      region: Value(region),
      jobUrl: Value(url),
      status: Value(status),
      note: Value(note),
      deadlineDate: Value(deadline),
      firstAppliedAt: Value(first),
      updatedAt: Value(stamp),
    );
    final int id;
    if (old == null) {
      id = await into(companies).insert(row.copyWith(createdAt: Value(stamp)));
    } else {
      id = old.id;
      await (update(companies)..where((t) => t.id.equals(id))).write(row);
    }
    if (old?.status != status) {
      await into(applicationEvents).insert(
        ApplicationEventsCompanion.insert(
          companyId: id,
          fromStatus: Value(old?.status),
          toStatus: status,
          changedAt: stamp,
        ),
      );
    }
  });
  Future<void> deleteCompany(int id) async {
    await (delete(companies)..where((t) => t.id.equals(id))).go();
  }
}
