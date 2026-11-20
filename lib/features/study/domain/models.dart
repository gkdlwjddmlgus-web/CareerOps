class Subject {
  final int id;
  final String name;
  final String description;
  final int targetMinutes;
  final String createdAt;
  final String updatedAt;
  const Subject({
    required this.id,
    required this.name,
    required this.description,
    required this.targetMinutes,
    required this.createdAt,
    required this.updatedAt,
  });
}

class StudyUnit {
  final int id;
  final int subjectId;
  final String title;
  final int sortOrder;
  final bool isCompleted;
  final String? completedAt;
  const StudyUnit({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.sortOrder,
    required this.isCompleted,
    this.completedAt,
  });
}

class StudySession {
  final int id;
  final int subjectId;
  final int? unitId;
  final String startedAt;
  final String endedAt;
  final int durationSeconds;
  final String source;
  final String note;
  const StudySession({
    required this.id,
    required this.subjectId,
    this.unitId,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    required this.source,
    required this.note,
  });
}

class ActiveTimer {
  final int id;
  final int subjectId;
  final int? unitId;
  final String startedAt;
  final String? runningSince;
  final int elapsedSeconds;
  final String state;
  const ActiveTimer({
    required this.id,
    required this.subjectId,
    this.unitId,
    required this.startedAt,
    this.runningSince,
    required this.elapsedSeconds,
    required this.state,
  });
}
