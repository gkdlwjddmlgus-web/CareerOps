import 'database.dart' as sql;
import '../domain/models.dart' as model;

model.Subject toSubject(sql.Subject row) => model.Subject(
  id: row.id,
  name: row.name,
  description: row.description,
  targetMinutes: row.targetMinutes,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
sql.Subject toSqlSubject(model.Subject row) => sql.Subject(
  id: row.id,
  name: row.name,
  description: row.description,
  targetMinutes: row.targetMinutes,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
model.StudyUnit toStudyUnit(sql.StudyUnit row) => model.StudyUnit(
  id: row.id,
  subjectId: row.subjectId,
  title: row.title,
  sortOrder: row.sortOrder,
  isCompleted: row.isCompleted,
  completedAt: row.completedAt,
);
sql.StudyUnit toSqlStudyUnit(model.StudyUnit row) => sql.StudyUnit(
  id: row.id,
  subjectId: row.subjectId,
  title: row.title,
  sortOrder: row.sortOrder,
  isCompleted: row.isCompleted,
  completedAt: row.completedAt,
);
model.StudySession toStudySession(sql.StudySession row) => model.StudySession(
  id: row.id,
  subjectId: row.subjectId,
  unitId: row.unitId,
  startedAt: row.startedAt,
  endedAt: row.endedAt,
  durationSeconds: row.durationSeconds,
  source: row.source,
  note: row.note,
);
sql.StudySession toSqlStudySession(model.StudySession row) => sql.StudySession(
  id: row.id,
  subjectId: row.subjectId,
  unitId: row.unitId,
  startedAt: row.startedAt,
  endedAt: row.endedAt,
  durationSeconds: row.durationSeconds,
  source: row.source,
  note: row.note,
);
model.ActiveTimer toActiveTimer(sql.ActiveTimer row) => model.ActiveTimer(
  id: row.id,
  subjectId: row.subjectId,
  unitId: row.unitId,
  startedAt: row.startedAt,
  runningSince: row.runningSince,
  elapsedSeconds: row.elapsedSeconds,
  state: row.state,
);
sql.ActiveTimer toSqlActiveTimer(model.ActiveTimer row) => sql.ActiveTimer(
  id: row.id,
  subjectId: row.subjectId,
  unitId: row.unitId,
  startedAt: row.startedAt,
  runningSince: row.runningSince,
  elapsedSeconds: row.elapsedSeconds,
  state: row.state,
);
model.Task toTask(sql.Task row) => model.Task(
  id: row.id,
  title: row.title,
  category: row.category,
  subjectId: row.subjectId,
  companyId: row.companyId,
  scheduledDate: row.scheduledDate,
  dueAt: row.dueAt,
  priority: row.priority,
  isCompleted: row.isCompleted,
  completedAt: row.completedAt,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
sql.Task toSqlTask(model.Task row) => sql.Task(
  id: row.id,
  title: row.title,
  category: row.category,
  subjectId: row.subjectId,
  companyId: row.companyId,
  scheduledDate: row.scheduledDate,
  dueAt: row.dueAt,
  priority: row.priority,
  isCompleted: row.isCompleted,
  completedAt: row.completedAt,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
model.Company toCompany(sql.Company row) => model.Company(
  id: row.id,
  name: row.name,
  position: row.position,
  region: row.region,
  jobUrl: row.jobUrl,
  deadlineDate: row.deadlineDate,
  status: row.status,
  note: row.note,
  firstAppliedAt: row.firstAppliedAt,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
sql.Company toSqlCompany(model.Company row) => sql.Company(
  id: row.id,
  name: row.name,
  position: row.position,
  region: row.region,
  jobUrl: row.jobUrl,
  deadlineDate: row.deadlineDate,
  status: row.status,
  note: row.note,
  firstAppliedAt: row.firstAppliedAt,
  createdAt: row.createdAt,
  updatedAt: row.updatedAt,
);
model.ApplicationEvent toApplicationEvent(sql.ApplicationEvent row) =>
    model.ApplicationEvent(
      id: row.id,
      companyId: row.companyId,
      fromStatus: row.fromStatus,
      toStatus: row.toStatus,
      changedAt: row.changedAt,
      note: row.note,
    );
sql.ApplicationEvent toSqlApplicationEvent(model.ApplicationEvent row) =>
    sql.ApplicationEvent(
      id: row.id,
      companyId: row.companyId,
      fromStatus: row.fromStatus,
      toStatus: row.toStatus,
      changedAt: row.changedAt,
      note: row.note,
    );
