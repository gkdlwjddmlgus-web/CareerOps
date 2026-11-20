class Task {
  final int id;
  final String title;
  final String category;
  final int? subjectId;
  final int? companyId;
  final String scheduledDate;
  final String? dueAt;
  final int priority;
  final bool isCompleted;
  final String? completedAt;
  final String createdAt;
  final String updatedAt;
  const Task({
    required this.id,
    required this.title,
    required this.category,
    this.subjectId,
    this.companyId,
    required this.scheduledDate,
    this.dueAt,
    required this.priority,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
}
