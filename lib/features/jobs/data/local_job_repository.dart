import 'package:drift/drift.dart';

import '../../../core/database/database.dart' as sql;
import '../../../core/database/entity_mappers.dart';
import '../domain/job_repository.dart';
import 'job_store.dart';

class LocalJobRepository implements JobRepository {
  LocalJobRepository(this.db);
  final sql.AppDatabase db;
  @override
  Stream<List<Company>> watchCompanies() =>
      (db.select(db.companies)
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .watch()
          .map((rows) => rows.map(toCompany).toList());
  @override
  Stream<List<ApplicationEvent>> watchEvents() =>
      (db.select(db.applicationEvents)..orderBy([
            (t) => OrderingTerm.desc(t.changedAt),
            (t) => OrderingTerm.desc(t.id),
          ]))
          .watch()
          .map((rows) => rows.map(toApplicationEvent).toList());
  @override
  Future<void> saveCompany({
    Company? existing,
    required String name,
    required String position,
    required String region,
    required String url,
    required String status,
    required String note,
    String? deadline,
  }) => db.saveCompany(
    existing: existing == null ? null : toSqlCompany(existing),
    name: name,
    position: position,
    region: region,
    url: url,
    status: status,
    note: note,
    deadline: deadline,
  );
  @override
  Future<void> deleteCompany(int id) => db.deleteCompany(id);
}
