import 'package:careerops/core/database/database.dart';
import 'package:careerops/features/jobs/data/job_store.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'status history is atomic and first application timestamp is retained',
    () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      Future<void> save(String status, {Company? company}) => db.saveCompany(
        existing: company,
        name: '테스트 기업',
        position: '개발',
        region: '서울',
        url: 'https://example.com',
        status: status,
        note: '',
        deadline: '2026-11-27',
      );
      await save('INTERESTED');
      var company = (await db.select(db.companies).get()).single;
      expect(deadlineWithin(company, DateTime(2026, 11, 20), 7), isTrue);
      expect(deadlineWithin(company, DateTime(2026, 11, 28), 7), isFalse);
      await save('APPLIED', company: company);
      company = (await db.select(db.companies).get()).single;
      final first = company.firstAppliedAt;
      await save('INTERVIEW', company: company);
      company = (await db.select(db.companies).get()).single;
      expect(company.firstAppliedAt, first);
      expect(first, isNotNull);
      expect((await db.select(db.applicationEvents).get()).length, 3);
      await db.customStatement(
        "CREATE TRIGGER fail_event BEFORE INSERT ON application_events BEGIN SELECT RAISE(ABORT, 'test rollback'); END",
      );
      await expectLater(
        save('OFFER', company: company),
        throwsA(isA<Exception>()),
      );
      expect((await db.select(db.companies).get()).single.status, 'INTERVIEW');
      expect((await db.select(db.applicationEvents).get()).length, 3);
    },
  );
}
