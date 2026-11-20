class Company {
  final int id;
  final String name;
  final String position;
  final String region;
  final String jobUrl;
  final String? deadlineDate;
  final String status;
  final String note;
  final String? firstAppliedAt;
  final String createdAt;
  final String updatedAt;
  const Company({
    required this.id,
    required this.name,
    required this.position,
    required this.region,
    required this.jobUrl,
    this.deadlineDate,
    required this.status,
    required this.note,
    this.firstAppliedAt,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ApplicationEvent {
  final int id;
  final int companyId;
  final String? fromStatus;
  final String toStatus;
  final String changedAt;
  final String note;
  const ApplicationEvent({
    required this.id,
    required this.companyId,
    this.fromStatus,
    required this.toStatus,
    required this.changedAt,
    required this.note,
  });
}
