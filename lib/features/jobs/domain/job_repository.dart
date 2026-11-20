import 'models.dart';
import '../../../core/utils/dates.dart';
export 'models.dart';
export '../../../core/domain/application_status.dart';

abstract interface class JobRepository {
  Stream<List<Company>> watchCompanies();
  Stream<List<ApplicationEvent>> watchEvents();
  Future<void> saveCompany({
    Company? existing,
    required String name,
    required String position,
    required String region,
    required String url,
    required String status,
    required String note,
    String? deadline,
  });
  Future<void> deleteCompany(int id);
}

bool deadlineWithin(Company company, DateTime now, int days) =>
    company.deadlineDate != null &&
    company.deadlineDate!.compareTo(dateKey(now)) >= 0 &&
    company.deadlineDate!.compareTo(
          dateKey(DateTime(now.year, now.month, now.day + days)),
        ) <=
        0;
