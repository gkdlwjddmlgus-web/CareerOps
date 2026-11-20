// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _targetMinutesMeta = const VerificationMeta(
    'targetMinutes',
  );
  @override
  late final GeneratedColumn<int> targetMinutes = GeneratedColumn<int>(
    'target_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    targetMinutes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('target_minutes')) {
      context.handle(
        _targetMinutesMeta,
        targetMinutes.isAcceptableOrUnknown(
          data['target_minutes']!,
          _targetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      targetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_minutes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['target_minutes'] = Variable<int>(targetMinutes);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      targetMinutes: Value(targetMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      targetMinutes: serializer.fromJson<int>(json['targetMinutes']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'targetMinutes': serializer.toJson<int>(targetMinutes),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Subject copyWith({
    int? id,
    String? name,
    String? description,
    int? targetMinutes,
    String? createdAt,
    String? updatedAt,
  }) => Subject(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    targetMinutes: targetMinutes ?? this.targetMinutes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      targetMinutes: data.targetMinutes.present
          ? data.targetMinutes.value
          : this.targetMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, targetMinutes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.targetMinutes == this.targetMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<int> targetMinutes;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.targetMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.targetMinutes = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? targetMinutes,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (targetMinutes != null) 'target_minutes': targetMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<int>? targetMinutes,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      targetMinutes: targetMinutes ?? this.targetMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetMinutes.present) {
      map['target_minutes'] = Variable<int>(targetMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudyUnitsTable extends StudyUnits
    with TableInfo<$StudyUnitsTable, StudyUnit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    title,
    sortOrder,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyUnit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyUnit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $StudyUnitsTable createAlias(String alias) {
    return $StudyUnitsTable(attachedDatabase, alias);
  }
}

class StudyUnit extends DataClass implements Insertable<StudyUnit> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    map['title'] = Variable<String>(title);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    return map;
  }

  StudyUnitsCompanion toCompanion(bool nullToAbsent) {
    return StudyUnitsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      title: Value(title),
      sortOrder: Value(sortOrder),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory StudyUnit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyUnit(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'title': serializer.toJson<String>(title),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<String?>(completedAt),
    };
  }

  StudyUnit copyWith({
    int? id,
    int? subjectId,
    String? title,
    int? sortOrder,
    bool? isCompleted,
    Value<String?> completedAt = const Value.absent(),
  }) => StudyUnit(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    title: title ?? this.title,
    sortOrder: sortOrder ?? this.sortOrder,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  StudyUnit copyWithCompanion(StudyUnitsCompanion data) {
    return StudyUnit(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyUnit(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, subjectId, title, sortOrder, isCompleted, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyUnit &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.sortOrder == this.sortOrder &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class StudyUnitsCompanion extends UpdateCompanion<StudyUnit> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<String> title;
  final Value<int> sortOrder;
  final Value<bool> isCompleted;
  final Value<String?> completedAt;
  const StudyUnitsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  StudyUnitsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    required String title,
    this.sortOrder = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
  }) : subjectId = Value(subjectId),
       title = Value(title);
  static Insertable<StudyUnit> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<String>? title,
    Expression<int>? sortOrder,
    Expression<bool>? isCompleted,
    Expression<String>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  StudyUnitsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<String>? title,
    Value<int>? sortOrder,
    Value<bool>? isCompleted,
    Value<String?>? completedAt,
  }) {
    return StudyUnitsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      sortOrder: sortOrder ?? this.sortOrder,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyUnitsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $StudySessionsTable extends StudySessions
    with TableInfo<$StudySessionsTable, StudySession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudySessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_units (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<String> endedAt = GeneratedColumn<String>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    check: () => ComparableExpr(durationSeconds).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    check: () => source.isIn(['TIMER', 'MANUAL']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    unitId,
    startedAt,
    endedAt,
    durationSeconds,
    source,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudySession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudySession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudySession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ended_at'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $StudySessionsTable createAlias(String alias) {
    return $StudySessionsTable(attachedDatabase, alias);
  }
}

class StudySession extends DataClass implements Insertable<StudySession> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<int>(unitId);
    }
    map['started_at'] = Variable<String>(startedAt);
    map['ended_at'] = Variable<String>(endedAt);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['source'] = Variable<String>(source);
    map['note'] = Variable<String>(note);
    return map;
  }

  StudySessionsCompanion toCompanion(bool nullToAbsent) {
    return StudySessionsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      durationSeconds: Value(durationSeconds),
      source: Value(source),
      note: Value(note),
    );
  }

  factory StudySession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudySession(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      unitId: serializer.fromJson<int?>(json['unitId']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      endedAt: serializer.fromJson<String>(json['endedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      source: serializer.fromJson<String>(json['source']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'unitId': serializer.toJson<int?>(unitId),
      'startedAt': serializer.toJson<String>(startedAt),
      'endedAt': serializer.toJson<String>(endedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'source': serializer.toJson<String>(source),
      'note': serializer.toJson<String>(note),
    };
  }

  StudySession copyWith({
    int? id,
    int? subjectId,
    Value<int?> unitId = const Value.absent(),
    String? startedAt,
    String? endedAt,
    int? durationSeconds,
    String? source,
    String? note,
  }) => StudySession(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    unitId: unitId.present ? unitId.value : this.unitId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    source: source ?? this.source,
    note: note ?? this.note,
  );
  StudySession copyWithCompanion(StudySessionsCompanion data) {
    return StudySession(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      source: data.source.present ? data.source.value : this.source,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudySession(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('unitId: $unitId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('source: $source, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    unitId,
    startedAt,
    endedAt,
    durationSeconds,
    source,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudySession &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.unitId == this.unitId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.source == this.source &&
          other.note == this.note);
}

class StudySessionsCompanion extends UpdateCompanion<StudySession> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int?> unitId;
  final Value<String> startedAt;
  final Value<String> endedAt;
  final Value<int> durationSeconds;
  final Value<String> source;
  final Value<String> note;
  const StudySessionsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.source = const Value.absent(),
    this.note = const Value.absent(),
  });
  StudySessionsCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    this.unitId = const Value.absent(),
    required String startedAt,
    required String endedAt,
    required int durationSeconds,
    required String source,
    this.note = const Value.absent(),
  }) : subjectId = Value(subjectId),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       durationSeconds = Value(durationSeconds),
       source = Value(source);
  static Insertable<StudySession> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? unitId,
    Expression<String>? startedAt,
    Expression<String>? endedAt,
    Expression<int>? durationSeconds,
    Expression<String>? source,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (unitId != null) 'unit_id': unitId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (source != null) 'source': source,
      if (note != null) 'note': note,
    });
  }

  StudySessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int?>? unitId,
    Value<String>? startedAt,
    Value<String>? endedAt,
    Value<int>? durationSeconds,
    Value<String>? source,
    Value<String>? note,
  }) {
    return StudySessionsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      unitId: unitId ?? this.unitId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      source: source ?? this.source,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<String>(endedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudySessionsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('unitId: $unitId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('source: $source, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _jobUrlMeta = const VerificationMeta('jobUrl');
  @override
  late final GeneratedColumn<String> jobUrl = GeneratedColumn<String>(
    'job_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _deadlineDateMeta = const VerificationMeta(
    'deadlineDate',
  );
  @override
  late final GeneratedColumn<String> deadlineDate = GeneratedColumn<String>(
    'deadline_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    check: () => status.isIn([
      'INTERESTED',
      'PREPARING',
      'APPLIED',
      'SCREENING',
      'INTERVIEW',
      'OFFER',
      'REJECTED',
      'WITHDRAWN',
      'CANCELLED',
    ]),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INTERESTED'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _firstAppliedAtMeta = const VerificationMeta(
    'firstAppliedAt',
  );
  @override
  late final GeneratedColumn<String> firstAppliedAt = GeneratedColumn<String>(
    'first_applied_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    position,
    region,
    jobUrl,
    deadlineDate,
    status,
    note,
    firstAppliedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Company> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('job_url')) {
      context.handle(
        _jobUrlMeta,
        jobUrl.isAcceptableOrUnknown(data['job_url']!, _jobUrlMeta),
      );
    }
    if (data.containsKey('deadline_date')) {
      context.handle(
        _deadlineDateMeta,
        deadlineDate.isAcceptableOrUnknown(
          data['deadline_date']!,
          _deadlineDateMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('first_applied_at')) {
      context.handle(
        _firstAppliedAtMeta,
        firstAppliedAt.isAcceptableOrUnknown(
          data['first_applied_at']!,
          _firstAppliedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      jobUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_url'],
      )!,
      deadlineDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deadline_date'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      firstAppliedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_applied_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['position'] = Variable<String>(position);
    map['region'] = Variable<String>(region);
    map['job_url'] = Variable<String>(jobUrl);
    if (!nullToAbsent || deadlineDate != null) {
      map['deadline_date'] = Variable<String>(deadlineDate);
    }
    map['status'] = Variable<String>(status);
    map['note'] = Variable<String>(note);
    if (!nullToAbsent || firstAppliedAt != null) {
      map['first_applied_at'] = Variable<String>(firstAppliedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      name: Value(name),
      position: Value(position),
      region: Value(region),
      jobUrl: Value(jobUrl),
      deadlineDate: deadlineDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deadlineDate),
      status: Value(status),
      note: Value(note),
      firstAppliedAt: firstAppliedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(firstAppliedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Company.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      position: serializer.fromJson<String>(json['position']),
      region: serializer.fromJson<String>(json['region']),
      jobUrl: serializer.fromJson<String>(json['jobUrl']),
      deadlineDate: serializer.fromJson<String?>(json['deadlineDate']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String>(json['note']),
      firstAppliedAt: serializer.fromJson<String?>(json['firstAppliedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'position': serializer.toJson<String>(position),
      'region': serializer.toJson<String>(region),
      'jobUrl': serializer.toJson<String>(jobUrl),
      'deadlineDate': serializer.toJson<String?>(deadlineDate),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String>(note),
      'firstAppliedAt': serializer.toJson<String?>(firstAppliedAt),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Company copyWith({
    int? id,
    String? name,
    String? position,
    String? region,
    String? jobUrl,
    Value<String?> deadlineDate = const Value.absent(),
    String? status,
    String? note,
    Value<String?> firstAppliedAt = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => Company(
    id: id ?? this.id,
    name: name ?? this.name,
    position: position ?? this.position,
    region: region ?? this.region,
    jobUrl: jobUrl ?? this.jobUrl,
    deadlineDate: deadlineDate.present ? deadlineDate.value : this.deadlineDate,
    status: status ?? this.status,
    note: note ?? this.note,
    firstAppliedAt: firstAppliedAt.present
        ? firstAppliedAt.value
        : this.firstAppliedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Company copyWithCompanion(CompaniesCompanion data) {
    return Company(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      position: data.position.present ? data.position.value : this.position,
      region: data.region.present ? data.region.value : this.region,
      jobUrl: data.jobUrl.present ? data.jobUrl.value : this.jobUrl,
      deadlineDate: data.deadlineDate.present
          ? data.deadlineDate.value
          : this.deadlineDate,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      firstAppliedAt: data.firstAppliedAt.present
          ? data.firstAppliedAt.value
          : this.firstAppliedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('region: $region, ')
          ..write('jobUrl: $jobUrl, ')
          ..write('deadlineDate: $deadlineDate, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('firstAppliedAt: $firstAppliedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    position,
    region,
    jobUrl,
    deadlineDate,
    status,
    note,
    firstAppliedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.name == this.name &&
          other.position == this.position &&
          other.region == this.region &&
          other.jobUrl == this.jobUrl &&
          other.deadlineDate == this.deadlineDate &&
          other.status == this.status &&
          other.note == this.note &&
          other.firstAppliedAt == this.firstAppliedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> position;
  final Value<String> region;
  final Value<String> jobUrl;
  final Value<String?> deadlineDate;
  final Value<String> status;
  final Value<String> note;
  final Value<String?> firstAppliedAt;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.position = const Value.absent(),
    this.region = const Value.absent(),
    this.jobUrl = const Value.absent(),
    this.deadlineDate = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.firstAppliedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.position = const Value.absent(),
    this.region = const Value.absent(),
    this.jobUrl = const Value.absent(),
    this.deadlineDate = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.firstAppliedAt = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Company> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? position,
    Expression<String>? region,
    Expression<String>? jobUrl,
    Expression<String>? deadlineDate,
    Expression<String>? status,
    Expression<String>? note,
    Expression<String>? firstAppliedAt,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (position != null) 'position': position,
      if (region != null) 'region': region,
      if (jobUrl != null) 'job_url': jobUrl,
      if (deadlineDate != null) 'deadline_date': deadlineDate,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (firstAppliedAt != null) 'first_applied_at': firstAppliedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CompaniesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? position,
    Value<String>? region,
    Value<String>? jobUrl,
    Value<String?>? deadlineDate,
    Value<String>? status,
    Value<String>? note,
    Value<String?>? firstAppliedAt,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return CompaniesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      region: region ?? this.region,
      jobUrl: jobUrl ?? this.jobUrl,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      status: status ?? this.status,
      note: note ?? this.note,
      firstAppliedAt: firstAppliedAt ?? this.firstAppliedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (jobUrl.present) {
      map['job_url'] = Variable<String>(jobUrl.value);
    }
    if (deadlineDate.present) {
      map['deadline_date'] = Variable<String>(deadlineDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (firstAppliedAt.present) {
      map['first_applied_at'] = Variable<String>(firstAppliedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('position: $position, ')
          ..write('region: $region, ')
          ..write('jobUrl: $jobUrl, ')
          ..write('deadlineDate: $deadlineDate, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('firstAppliedAt: $firstAppliedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ApplicationEventsTable extends ApplicationEvents
    with TableInfo<$ApplicationEventsTable, ApplicationEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES companies (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fromStatusMeta = const VerificationMeta(
    'fromStatus',
  );
  @override
  late final GeneratedColumn<String> fromStatus = GeneratedColumn<String>(
    'from_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toStatusMeta = const VerificationMeta(
    'toStatus',
  );
  @override
  late final GeneratedColumn<String> toStatus = GeneratedColumn<String>(
    'to_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<String> changedAt = GeneratedColumn<String>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyId,
    fromStatus,
    toStatus,
    changedAt,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApplicationEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('from_status')) {
      context.handle(
        _fromStatusMeta,
        fromStatus.isAcceptableOrUnknown(data['from_status']!, _fromStatusMeta),
      );
    }
    if (data.containsKey('to_status')) {
      context.handle(
        _toStatusMeta,
        toStatus.isAcceptableOrUnknown(data['to_status']!, _toStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_toStatusMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApplicationEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company_id'],
      )!,
      fromStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_status'],
      ),
      toStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_status'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}changed_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $ApplicationEventsTable createAlias(String alias) {
    return $ApplicationEventsTable(attachedDatabase, alias);
  }
}

class ApplicationEvent extends DataClass
    implements Insertable<ApplicationEvent> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['company_id'] = Variable<int>(companyId);
    if (!nullToAbsent || fromStatus != null) {
      map['from_status'] = Variable<String>(fromStatus);
    }
    map['to_status'] = Variable<String>(toStatus);
    map['changed_at'] = Variable<String>(changedAt);
    map['note'] = Variable<String>(note);
    return map;
  }

  ApplicationEventsCompanion toCompanion(bool nullToAbsent) {
    return ApplicationEventsCompanion(
      id: Value(id),
      companyId: Value(companyId),
      fromStatus: fromStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(fromStatus),
      toStatus: Value(toStatus),
      changedAt: Value(changedAt),
      note: Value(note),
    );
  }

  factory ApplicationEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicationEvent(
      id: serializer.fromJson<int>(json['id']),
      companyId: serializer.fromJson<int>(json['companyId']),
      fromStatus: serializer.fromJson<String?>(json['fromStatus']),
      toStatus: serializer.fromJson<String>(json['toStatus']),
      changedAt: serializer.fromJson<String>(json['changedAt']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'companyId': serializer.toJson<int>(companyId),
      'fromStatus': serializer.toJson<String?>(fromStatus),
      'toStatus': serializer.toJson<String>(toStatus),
      'changedAt': serializer.toJson<String>(changedAt),
      'note': serializer.toJson<String>(note),
    };
  }

  ApplicationEvent copyWith({
    int? id,
    int? companyId,
    Value<String?> fromStatus = const Value.absent(),
    String? toStatus,
    String? changedAt,
    String? note,
  }) => ApplicationEvent(
    id: id ?? this.id,
    companyId: companyId ?? this.companyId,
    fromStatus: fromStatus.present ? fromStatus.value : this.fromStatus,
    toStatus: toStatus ?? this.toStatus,
    changedAt: changedAt ?? this.changedAt,
    note: note ?? this.note,
  );
  ApplicationEvent copyWithCompanion(ApplicationEventsCompanion data) {
    return ApplicationEvent(
      id: data.id.present ? data.id.value : this.id,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      fromStatus: data.fromStatus.present
          ? data.fromStatus.value
          : this.fromStatus,
      toStatus: data.toStatus.present ? data.toStatus.value : this.toStatus,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationEvent(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('fromStatus: $fromStatus, ')
          ..write('toStatus: $toStatus, ')
          ..write('changedAt: $changedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, companyId, fromStatus, toStatus, changedAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicationEvent &&
          other.id == this.id &&
          other.companyId == this.companyId &&
          other.fromStatus == this.fromStatus &&
          other.toStatus == this.toStatus &&
          other.changedAt == this.changedAt &&
          other.note == this.note);
}

class ApplicationEventsCompanion extends UpdateCompanion<ApplicationEvent> {
  final Value<int> id;
  final Value<int> companyId;
  final Value<String?> fromStatus;
  final Value<String> toStatus;
  final Value<String> changedAt;
  final Value<String> note;
  const ApplicationEventsCompanion({
    this.id = const Value.absent(),
    this.companyId = const Value.absent(),
    this.fromStatus = const Value.absent(),
    this.toStatus = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.note = const Value.absent(),
  });
  ApplicationEventsCompanion.insert({
    this.id = const Value.absent(),
    required int companyId,
    this.fromStatus = const Value.absent(),
    required String toStatus,
    required String changedAt,
    this.note = const Value.absent(),
  }) : companyId = Value(companyId),
       toStatus = Value(toStatus),
       changedAt = Value(changedAt);
  static Insertable<ApplicationEvent> custom({
    Expression<int>? id,
    Expression<int>? companyId,
    Expression<String>? fromStatus,
    Expression<String>? toStatus,
    Expression<String>? changedAt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyId != null) 'company_id': companyId,
      if (fromStatus != null) 'from_status': fromStatus,
      if (toStatus != null) 'to_status': toStatus,
      if (changedAt != null) 'changed_at': changedAt,
      if (note != null) 'note': note,
    });
  }

  ApplicationEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? companyId,
    Value<String?>? fromStatus,
    Value<String>? toStatus,
    Value<String>? changedAt,
    Value<String>? note,
  }) {
    return ApplicationEventsCompanion(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      fromStatus: fromStatus ?? this.fromStatus,
      toStatus: toStatus ?? this.toStatus,
      changedAt: changedAt ?? this.changedAt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (fromStatus.present) {
      map['from_status'] = Variable<String>(fromStatus.value);
    }
    if (toStatus.present) {
      map['to_status'] = Variable<String>(toStatus.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<String>(changedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationEventsCompanion(')
          ..write('id: $id, ')
          ..write('companyId: $companyId, ')
          ..write('fromStatus: $fromStatus, ')
          ..write('toStatus: $toStatus, ')
          ..write('changedAt: $changedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    check: () => category.isIn(['STUDY', 'JOB', 'GENERAL']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
    'company_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES companies (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<String> scheduledDate = GeneratedColumn<String>(
    'scheduled_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<String> dueAt = GeneratedColumn<String>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    check: () => ComparableExpr(priority).isBetweenValues(0, 2),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    subjectId,
    companyId,
    scheduledDate,
    dueAt,
    priority,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      ),
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company_id'],
      ),
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_date'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_at'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<int>(subjectId);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    map['scheduled_date'] = Variable<String>(scheduledDate);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<String>(dueAt);
    }
    map['priority'] = Variable<int>(priority);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      scheduledDate: Value(scheduledDate),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      priority: Value(priority),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      subjectId: serializer.fromJson<int?>(json['subjectId']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      scheduledDate: serializer.fromJson<String>(json['scheduledDate']),
      dueAt: serializer.fromJson<String?>(json['dueAt']),
      priority: serializer.fromJson<int>(json['priority']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'subjectId': serializer.toJson<int?>(subjectId),
      'companyId': serializer.toJson<int?>(companyId),
      'scheduledDate': serializer.toJson<String>(scheduledDate),
      'dueAt': serializer.toJson<String?>(dueAt),
      'priority': serializer.toJson<int>(priority),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<String?>(completedAt),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Task copyWith({
    int? id,
    String? title,
    String? category,
    Value<int?> subjectId = const Value.absent(),
    Value<int?> companyId = const Value.absent(),
    String? scheduledDate,
    Value<String?> dueAt = const Value.absent(),
    int? priority,
    bool? isCompleted,
    Value<String?> completedAt = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    subjectId: subjectId.present ? subjectId.value : this.subjectId,
    companyId: companyId.present ? companyId.value : this.companyId,
    scheduledDate: scheduledDate ?? this.scheduledDate,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    priority: priority ?? this.priority,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      priority: data.priority.present ? data.priority.value : this.priority,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('subjectId: $subjectId, ')
          ..write('companyId: $companyId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('dueAt: $dueAt, ')
          ..write('priority: $priority, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    category,
    subjectId,
    companyId,
    scheduledDate,
    dueAt,
    priority,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.subjectId == this.subjectId &&
          other.companyId == this.companyId &&
          other.scheduledDate == this.scheduledDate &&
          other.dueAt == this.dueAt &&
          other.priority == this.priority &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<int?> subjectId;
  final Value<int?> companyId;
  final Value<String> scheduledDate;
  final Value<String?> dueAt;
  final Value<int> priority;
  final Value<bool> isCompleted;
  final Value<String?> completedAt;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.priority = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    this.subjectId = const Value.absent(),
    this.companyId = const Value.absent(),
    required String scheduledDate,
    this.dueAt = const Value.absent(),
    this.priority = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : title = Value(title),
       category = Value(category),
       scheduledDate = Value(scheduledDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<int>? subjectId,
    Expression<int>? companyId,
    Expression<String>? scheduledDate,
    Expression<String>? dueAt,
    Expression<int>? priority,
    Expression<bool>? isCompleted,
    Expression<String>? completedAt,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (subjectId != null) 'subject_id': subjectId,
      if (companyId != null) 'company_id': companyId,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (dueAt != null) 'due_at': dueAt,
      if (priority != null) 'priority': priority,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TasksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? category,
    Value<int?>? subjectId,
    Value<int?>? companyId,
    Value<String>? scheduledDate,
    Value<String?>? dueAt,
    Value<int>? priority,
    Value<bool>? isCompleted,
    Value<String?>? completedAt,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      subjectId: subjectId ?? this.subjectId,
      companyId: companyId ?? this.companyId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      dueAt: dueAt ?? this.dueAt,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<String>(scheduledDate.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<String>(dueAt.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('subjectId: $subjectId, ')
          ..write('companyId: $companyId, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('dueAt: $dueAt, ')
          ..write('priority: $priority, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<int> taskId = GeneratedColumn<int>(
    'task_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tasks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
    'company_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES companies (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<String> scheduledAt = GeneratedColumn<String>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _platformNotificationIdMeta =
      const VerificationMeta('platformNotificationId');
  @override
  late final GeneratedColumn<int> platformNotificationId = GeneratedColumn<int>(
    'platform_notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    companyId,
    scheduledAt,
    isEnabled,
    platformNotificationId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('platform_notification_id')) {
      context.handle(
        _platformNotificationIdMeta,
        platformNotificationId.isAcceptableOrUnknown(
          data['platform_notification_id']!,
          _platformNotificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_platformNotificationIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_id'],
      ),
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company_id'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_at'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      platformNotificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}platform_notification_id'],
      )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final int id;
  final int? taskId;
  final int? companyId;
  final String scheduledAt;
  final bool isEnabled;
  final int platformNotificationId;
  const Notification({
    required this.id,
    this.taskId,
    this.companyId,
    required this.scheduledAt,
    required this.isEnabled,
    required this.platformNotificationId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<int>(taskId);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    map['scheduled_at'] = Variable<String>(scheduledAt);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['platform_notification_id'] = Variable<int>(platformNotificationId);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      taskId: taskId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskId),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      scheduledAt: Value(scheduledAt),
      isEnabled: Value(isEnabled),
      platformNotificationId: Value(platformNotificationId),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<int?>(json['taskId']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      scheduledAt: serializer.fromJson<String>(json['scheduledAt']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      platformNotificationId: serializer.fromJson<int>(
        json['platformNotificationId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskId': serializer.toJson<int?>(taskId),
      'companyId': serializer.toJson<int?>(companyId),
      'scheduledAt': serializer.toJson<String>(scheduledAt),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'platformNotificationId': serializer.toJson<int>(platformNotificationId),
    };
  }

  Notification copyWith({
    int? id,
    Value<int?> taskId = const Value.absent(),
    Value<int?> companyId = const Value.absent(),
    String? scheduledAt,
    bool? isEnabled,
    int? platformNotificationId,
  }) => Notification(
    id: id ?? this.id,
    taskId: taskId.present ? taskId.value : this.taskId,
    companyId: companyId.present ? companyId.value : this.companyId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    isEnabled: isEnabled ?? this.isEnabled,
    platformNotificationId:
        platformNotificationId ?? this.platformNotificationId,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      platformNotificationId: data.platformNotificationId.present
          ? data.platformNotificationId.value
          : this.platformNotificationId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('companyId: $companyId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('platformNotificationId: $platformNotificationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    taskId,
    companyId,
    scheduledAt,
    isEnabled,
    platformNotificationId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.companyId == this.companyId &&
          other.scheduledAt == this.scheduledAt &&
          other.isEnabled == this.isEnabled &&
          other.platformNotificationId == this.platformNotificationId);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<int?> taskId;
  final Value<int?> companyId;
  final Value<String> scheduledAt;
  final Value<bool> isEnabled;
  final Value<int> platformNotificationId;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.companyId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.platformNotificationId = const Value.absent(),
  });
  NotificationsCompanion.insert({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.companyId = const Value.absent(),
    required String scheduledAt,
    this.isEnabled = const Value.absent(),
    required int platformNotificationId,
  }) : scheduledAt = Value(scheduledAt),
       platformNotificationId = Value(platformNotificationId);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<int>? taskId,
    Expression<int>? companyId,
    Expression<String>? scheduledAt,
    Expression<bool>? isEnabled,
    Expression<int>? platformNotificationId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (companyId != null) 'company_id': companyId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (platformNotificationId != null)
        'platform_notification_id': platformNotificationId,
    });
  }

  NotificationsCompanion copyWith({
    Value<int>? id,
    Value<int?>? taskId,
    Value<int?>? companyId,
    Value<String>? scheduledAt,
    Value<bool>? isEnabled,
    Value<int>? platformNotificationId,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      companyId: companyId ?? this.companyId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      isEnabled: isEnabled ?? this.isEnabled,
      platformNotificationId:
          platformNotificationId ?? this.platformNotificationId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<int>(taskId.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<String>(scheduledAt.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (platformNotificationId.present) {
      map['platform_notification_id'] = Variable<int>(
        platformNotificationId.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('companyId: $companyId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('platformNotificationId: $platformNotificationId')
          ..write(')'))
        .toString();
  }
}

class $ActiveTimersTable extends ActiveTimers
    with TableInfo<$ActiveTimersTable, ActiveTimer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveTimersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    check: () => id.equals(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<int> unitId = GeneratedColumn<int>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES study_units (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _runningSinceMeta = const VerificationMeta(
    'runningSince',
  );
  @override
  late final GeneratedColumn<String> runningSince = GeneratedColumn<String>(
    'running_since',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elapsedSecondsMeta = const VerificationMeta(
    'elapsedSeconds',
  );
  @override
  late final GeneratedColumn<int> elapsedSeconds = GeneratedColumn<int>(
    'elapsed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    check: () => state.isIn(['Running', 'Paused', 'Completed']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    unitId,
    startedAt,
    runningSince,
    elapsedSeconds,
    state,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_timers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveTimer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('running_since')) {
      context.handle(
        _runningSinceMeta,
        runningSince.isAcceptableOrUnknown(
          data['running_since']!,
          _runningSinceMeta,
        ),
      );
    }
    if (data.containsKey('elapsed_seconds')) {
      context.handle(
        _elapsedSecondsMeta,
        elapsedSeconds.isAcceptableOrUnknown(
          data['elapsed_seconds']!,
          _elapsedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActiveTimer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveTimer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}started_at'],
      )!,
      runningSince: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}running_since'],
      ),
      elapsedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_seconds'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
    );
  }

  @override
  $ActiveTimersTable createAlias(String alias) {
    return $ActiveTimersTable(attachedDatabase, alias);
  }
}

class ActiveTimer extends DataClass implements Insertable<ActiveTimer> {
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_id'] = Variable<int>(subjectId);
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<int>(unitId);
    }
    map['started_at'] = Variable<String>(startedAt);
    if (!nullToAbsent || runningSince != null) {
      map['running_since'] = Variable<String>(runningSince);
    }
    map['elapsed_seconds'] = Variable<int>(elapsedSeconds);
    map['state'] = Variable<String>(state);
    return map;
  }

  ActiveTimersCompanion toCompanion(bool nullToAbsent) {
    return ActiveTimersCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      startedAt: Value(startedAt),
      runningSince: runningSince == null && nullToAbsent
          ? const Value.absent()
          : Value(runningSince),
      elapsedSeconds: Value(elapsedSeconds),
      state: Value(state),
    );
  }

  factory ActiveTimer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveTimer(
      id: serializer.fromJson<int>(json['id']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      unitId: serializer.fromJson<int?>(json['unitId']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      runningSince: serializer.fromJson<String?>(json['runningSince']),
      elapsedSeconds: serializer.fromJson<int>(json['elapsedSeconds']),
      state: serializer.fromJson<String>(json['state']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectId': serializer.toJson<int>(subjectId),
      'unitId': serializer.toJson<int?>(unitId),
      'startedAt': serializer.toJson<String>(startedAt),
      'runningSince': serializer.toJson<String?>(runningSince),
      'elapsedSeconds': serializer.toJson<int>(elapsedSeconds),
      'state': serializer.toJson<String>(state),
    };
  }

  ActiveTimer copyWith({
    int? id,
    int? subjectId,
    Value<int?> unitId = const Value.absent(),
    String? startedAt,
    Value<String?> runningSince = const Value.absent(),
    int? elapsedSeconds,
    String? state,
  }) => ActiveTimer(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    unitId: unitId.present ? unitId.value : this.unitId,
    startedAt: startedAt ?? this.startedAt,
    runningSince: runningSince.present ? runningSince.value : this.runningSince,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    state: state ?? this.state,
  );
  ActiveTimer copyWithCompanion(ActiveTimersCompanion data) {
    return ActiveTimer(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      runningSince: data.runningSince.present
          ? data.runningSince.value
          : this.runningSince,
      elapsedSeconds: data.elapsedSeconds.present
          ? data.elapsedSeconds.value
          : this.elapsedSeconds,
      state: data.state.present ? data.state.value : this.state,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveTimer(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('unitId: $unitId, ')
          ..write('startedAt: $startedAt, ')
          ..write('runningSince: $runningSince, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    unitId,
    startedAt,
    runningSince,
    elapsedSeconds,
    state,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveTimer &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.unitId == this.unitId &&
          other.startedAt == this.startedAt &&
          other.runningSince == this.runningSince &&
          other.elapsedSeconds == this.elapsedSeconds &&
          other.state == this.state);
}

class ActiveTimersCompanion extends UpdateCompanion<ActiveTimer> {
  final Value<int> id;
  final Value<int> subjectId;
  final Value<int?> unitId;
  final Value<String> startedAt;
  final Value<String?> runningSince;
  final Value<int> elapsedSeconds;
  final Value<String> state;
  const ActiveTimersCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.runningSince = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.state = const Value.absent(),
  });
  ActiveTimersCompanion.insert({
    this.id = const Value.absent(),
    required int subjectId,
    this.unitId = const Value.absent(),
    required String startedAt,
    this.runningSince = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    required String state,
  }) : subjectId = Value(subjectId),
       startedAt = Value(startedAt),
       state = Value(state);
  static Insertable<ActiveTimer> custom({
    Expression<int>? id,
    Expression<int>? subjectId,
    Expression<int>? unitId,
    Expression<String>? startedAt,
    Expression<String>? runningSince,
    Expression<int>? elapsedSeconds,
    Expression<String>? state,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (unitId != null) 'unit_id': unitId,
      if (startedAt != null) 'started_at': startedAt,
      if (runningSince != null) 'running_since': runningSince,
      if (elapsedSeconds != null) 'elapsed_seconds': elapsedSeconds,
      if (state != null) 'state': state,
    });
  }

  ActiveTimersCompanion copyWith({
    Value<int>? id,
    Value<int>? subjectId,
    Value<int?>? unitId,
    Value<String>? startedAt,
    Value<String?>? runningSince,
    Value<int>? elapsedSeconds,
    Value<String>? state,
  }) {
    return ActiveTimersCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      unitId: unitId ?? this.unitId,
      startedAt: startedAt ?? this.startedAt,
      runningSince: runningSince ?? this.runningSince,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      state: state ?? this.state,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<int>(unitId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (runningSince.present) {
      map['running_since'] = Variable<String>(runningSince.value);
    }
    if (elapsedSeconds.present) {
      map['elapsed_seconds'] = Variable<int>(elapsedSeconds.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveTimersCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('unitId: $unitId, ')
          ..write('startedAt: $startedAt, ')
          ..write('runningSince: $runningSince, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $StudyUnitsTable studyUnits = $StudyUnitsTable(this);
  late final $StudySessionsTable studySessions = $StudySessionsTable(this);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $ApplicationEventsTable applicationEvents =
      $ApplicationEventsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $ActiveTimersTable activeTimers = $ActiveTimersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    subjects,
    studyUnits,
    studySessions,
    companies,
    applicationEvents,
    tasks,
    notifications,
    activeTimers,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_units', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_units',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('study_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'companies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('application_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'subjects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'companies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notifications', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'companies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notifications', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'study_units',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('active_timers', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  Value<int> id,
  required String name,
  Value<String> description,
  Value<int> targetMinutes,
  required String createdAt,
  required String updatedAt,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<int> targetMinutes,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StudyUnitsTable, List<StudyUnit>>
  _studyUnitsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studyUnits,
    aliasName: 'subjects__id__study_units__subject_id',
  );

  $$StudyUnitsTableProcessedTableManager get studyUnitsRefs {
    final manager = $$StudyUnitsTableTableManager(
      $_db,
      $_db.studyUnits,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studyUnitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'subjects__id__study_sessions__subject_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'subjects__id__tasks__subject_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActiveTimersTable, List<ActiveTimer>>
  _activeTimersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activeTimers,
    aliasName: 'subjects__id__active_timers__subject_id',
  );

  $$ActiveTimersTableProcessedTableManager get activeTimersRefs {
    final manager = $$ActiveTimersTableTableManager(
      $_db,
      $_db.activeTimers,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activeTimersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studyUnitsRefs(
    Expression<bool> Function($$StudyUnitsTableFilterComposer f) f,
  ) {
    final $$StudyUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableFilterComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activeTimersRefs(
    Expression<bool> Function($$ActiveTimersTableFilterComposer f) f,
  ) {
    final $$ActiveTimersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activeTimers,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActiveTimersTableFilterComposer(
            $db: $db,
            $table: $db.activeTimers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> studyUnitsRefs<T extends Object>(
    Expression<T> Function($$StudyUnitsTableAnnotationComposer a) f,
  ) {
    final $$StudyUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activeTimersRefs<T extends Object>(
    Expression<T> Function($$ActiveTimersTableAnnotationComposer a) f,
  ) {
    final $$ActiveTimersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activeTimers,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActiveTimersTableAnnotationComposer(
            $db: $db,
            $table: $db.activeTimers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({
            bool studyUnitsRefs,
            bool studySessionsRefs,
            bool tasksRefs,
            bool activeTimersRefs,
          })
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> targetMinutes = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                name: name,
                description: description,
                targetMinutes: targetMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                Value<int> targetMinutes = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => SubjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                targetMinutes: targetMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SubjectsTable, Subject>(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                studyUnitsRefs = false,
                studySessionsRefs = false,
                tasksRefs = false,
                activeTimersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studyUnitsRefs) db.studyUnits,
                    if (studySessionsRefs) db.studySessions,
                    if (tasksRefs) db.tasks,
                    if (activeTimersRefs) db.activeTimers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studyUnitsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          StudyUnit,
                          $StudyUnitsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._studyUnitsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studyUnitsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (studySessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          StudySession,
                          $StudySessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          Task,
                          $TasksTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).tasksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                      if (activeTimersRefs)
                        await $_getPrefetchedDataByColumns<
                          Subject,
                          $SubjectsTable,
                          ActiveTimer,
                          $ActiveTimersTable
                        >(
                          currentTable: table,
                          referencedTable: $$SubjectsTableReferences
                              ._activeTimersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SubjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).activeTimersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'subject_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({
        bool studyUnitsRefs,
        bool studySessionsRefs,
        bool tasksRefs,
        bool activeTimersRefs,
      })
    >;
typedef $$StudyUnitsTableCreateCompanionBuilder = StudyUnitsCompanion Function({
  Value<int> id,
  required int subjectId,
  required String title,
  Value<int> sortOrder,
  Value<bool> isCompleted,
  Value<String?> completedAt,
});
typedef $$StudyUnitsTableUpdateCompanionBuilder = StudyUnitsCompanion Function({
  Value<int> id,
  Value<int> subjectId,
  Value<String> title,
  Value<int> sortOrder,
  Value<bool> isCompleted,
  Value<String?> completedAt,
});

final class $$StudyUnitsTableReferences
    extends BaseReferences<_$AppDatabase, $StudyUnitsTable, StudyUnit> {
  $$StudyUnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('study_units__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StudySessionsTable, List<StudySession>>
  _studySessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studySessions,
    aliasName: 'study_units__id__study_sessions__unit_id',
  );

  $$StudySessionsTableProcessedTableManager get studySessionsRefs {
    final manager = $$StudySessionsTableTableManager(
      $_db,
      $_db.studySessions,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studySessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ActiveTimersTable, List<ActiveTimer>>
  _activeTimersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activeTimers,
    aliasName: 'study_units__id__active_timers__unit_id',
  );

  $$ActiveTimersTableProcessedTableManager get activeTimersRefs {
    final manager = $$ActiveTimersTableTableManager(
      $_db,
      $_db.activeTimers,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activeTimersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StudyUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyUnitsTable> {
  $$StudyUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studySessionsRefs(
    Expression<bool> Function($$StudySessionsTableFilterComposer f) f,
  ) {
    final $$StudySessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableFilterComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> activeTimersRefs(
    Expression<bool> Function($$ActiveTimersTableFilterComposer f) f,
  ) {
    final $$ActiveTimersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activeTimers,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActiveTimersTableFilterComposer(
            $db: $db,
            $table: $db.activeTimers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyUnitsTable> {
  $$StudyUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudyUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyUnitsTable> {
  $$StudyUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studySessionsRefs<T extends Object>(
    Expression<T> Function($$StudySessionsTableAnnotationComposer a) f,
  ) {
    final $$StudySessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studySessions,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudySessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.studySessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> activeTimersRefs<T extends Object>(
    Expression<T> Function($$ActiveTimersTableAnnotationComposer a) f,
  ) {
    final $$ActiveTimersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activeTimers,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActiveTimersTableAnnotationComposer(
            $db: $db,
            $table: $db.activeTimers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StudyUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyUnitsTable,
          StudyUnit,
          $$StudyUnitsTableFilterComposer,
          $$StudyUnitsTableOrderingComposer,
          $$StudyUnitsTableAnnotationComposer,
          $$StudyUnitsTableCreateCompanionBuilder,
          $$StudyUnitsTableUpdateCompanionBuilder,
          (StudyUnit, $$StudyUnitsTableReferences),
          StudyUnit,
          PrefetchHooks Function({
            bool subjectId,
            bool studySessionsRefs,
            bool activeTimersRefs,
          })
        > {
  $$StudyUnitsTableTableManager(_$AppDatabase db, $StudyUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
              }) => StudyUnitsCompanion(
                id: id,
                subjectId: subjectId,
                title: title,
                sortOrder: sortOrder,
                isCompleted: isCompleted,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                required String title,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
              }) => StudyUnitsCompanion.insert(
                id: id,
                subjectId: subjectId,
                title: title,
                sortOrder: sortOrder,
                isCompleted: isCompleted,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudyUnitsTable, StudyUnit>(table),
                  $$StudyUnitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                studySessionsRefs = false,
                activeTimersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studySessionsRefs) db.studySessions,
                    if (activeTimersRefs) db.activeTimers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$StudyUnitsTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$StudyUnitsTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studySessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          StudyUnit,
                          $StudyUnitsTable,
                          StudySession,
                          $StudySessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudyUnitsTableReferences
                              ._studySessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyUnitsTableReferences(
                                db,
                                table,
                                p0,
                              ).studySessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'unit_id',
                          typedResults: items,
                        ),
                      if (activeTimersRefs)
                        await $_getPrefetchedDataByColumns<
                          StudyUnit,
                          $StudyUnitsTable,
                          ActiveTimer,
                          $ActiveTimersTable
                        >(
                          currentTable: table,
                          referencedTable: $$StudyUnitsTableReferences
                              ._activeTimersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StudyUnitsTableReferences(
                                db,
                                table,
                                p0,
                              ).activeTimersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'unit_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StudyUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyUnitsTable,
      StudyUnit,
      $$StudyUnitsTableFilterComposer,
      $$StudyUnitsTableOrderingComposer,
      $$StudyUnitsTableAnnotationComposer,
      $$StudyUnitsTableCreateCompanionBuilder,
      $$StudyUnitsTableUpdateCompanionBuilder,
      (StudyUnit, $$StudyUnitsTableReferences),
      StudyUnit,
      PrefetchHooks Function({
        bool subjectId,
        bool studySessionsRefs,
        bool activeTimersRefs,
      })
    >;
typedef $$StudySessionsTableCreateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<int> id,
      required int subjectId,
      Value<int?> unitId,
      required String startedAt,
      required String endedAt,
      required int durationSeconds,
      required String source,
      Value<String> note,
    });
typedef $$StudySessionsTableUpdateCompanionBuilder =
    StudySessionsCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int?> unitId,
      Value<String> startedAt,
      Value<String> endedAt,
      Value<int> durationSeconds,
      Value<String> source,
      Value<String> note,
    });

final class $$StudySessionsTableReferences
    extends BaseReferences<_$AppDatabase, $StudySessionsTable, StudySession> {
  $$StudySessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('study_sessions__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudyUnitsTable _unitIdTable(_$AppDatabase db) =>
      db.studyUnits.createAlias('study_sessions__unit_id__study_units__id');

  $$StudyUnitsTableProcessedTableManager? get unitId {
    final $_column = $_itemColumn<int>('unit_id');
    if ($_column == null) return null;
    final manager = $$StudyUnitsTableTableManager(
      $_db,
      $_db.studyUnits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudySessionsTableFilterComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyUnitsTableFilterComposer get unitId {
    final $$StudyUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableFilterComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyUnitsTableOrderingComposer get unitId {
    final $$StudyUnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableOrderingComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudySessionsTable> {
  $$StudySessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyUnitsTableAnnotationComposer get unitId {
    final $$StudyUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudySessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudySessionsTable,
          StudySession,
          $$StudySessionsTableFilterComposer,
          $$StudySessionsTableOrderingComposer,
          $$StudySessionsTableAnnotationComposer,
          $$StudySessionsTableCreateCompanionBuilder,
          $$StudySessionsTableUpdateCompanionBuilder,
          (StudySession, $$StudySessionsTableReferences),
          StudySession,
          PrefetchHooks Function({bool subjectId, bool unitId})
        > {
  $$StudySessionsTableTableManager(_$AppDatabase db, $StudySessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudySessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudySessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudySessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int?> unitId = const Value.absent(),
                Value<String> startedAt = const Value.absent(),
                Value<String> endedAt = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => StudySessionsCompanion(
                id: id,
                subjectId: subjectId,
                unitId: unitId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                source: source,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                Value<int?> unitId = const Value.absent(),
                required String startedAt,
                required String endedAt,
                required int durationSeconds,
                required String source,
                Value<String> note = const Value.absent(),
              }) => StudySessionsCompanion.insert(
                id: id,
                subjectId: subjectId,
                unitId: unitId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                source: source,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StudySessionsTable, StudySession>(table),
                  $$StudySessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subjectId = false, unitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$StudySessionsTableReferences
                            ._subjectIdTable(db),
                        referencedColumn: $$StudySessionsTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (unitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.unitId,
                        referencedTable: $$StudySessionsTableReferences
                            ._unitIdTable(db),
                        referencedColumn: $$StudySessionsTableReferences
                            ._unitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudySessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudySessionsTable,
      StudySession,
      $$StudySessionsTableFilterComposer,
      $$StudySessionsTableOrderingComposer,
      $$StudySessionsTableAnnotationComposer,
      $$StudySessionsTableCreateCompanionBuilder,
      $$StudySessionsTableUpdateCompanionBuilder,
      (StudySession, $$StudySessionsTableReferences),
      StudySession,
      PrefetchHooks Function({bool subjectId, bool unitId})
    >;
typedef $$CompaniesTableCreateCompanionBuilder = CompaniesCompanion Function({
  Value<int> id,
  required String name,
  Value<String> position,
  Value<String> region,
  Value<String> jobUrl,
  Value<String?> deadlineDate,
  Value<String> status,
  Value<String> note,
  Value<String?> firstAppliedAt,
  required String createdAt,
  required String updatedAt,
});
typedef $$CompaniesTableUpdateCompanionBuilder = CompaniesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> position,
  Value<String> region,
  Value<String> jobUrl,
  Value<String?> deadlineDate,
  Value<String> status,
  Value<String> note,
  Value<String?> firstAppliedAt,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$CompaniesTableReferences
    extends BaseReferences<_$AppDatabase, $CompaniesTable, Company> {
  $$CompaniesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ApplicationEventsTable, List<ApplicationEvent>>
  _applicationEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.applicationEvents,
        aliasName: 'companies__id__application_events__company_id',
      );

  $$ApplicationEventsTableProcessedTableManager get applicationEventsRefs {
    final manager = $$ApplicationEventsTableTableManager(
      $_db,
      $_db.applicationEvents,
    ).filter((f) => f.companyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _applicationEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'companies__id__tasks__company_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.companyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotificationsTable, List<Notification>>
  _notificationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.notifications,
    aliasName: 'companies__id__notifications__company_id',
  );

  $$NotificationsTableProcessedTableManager get notificationsRefs {
    final manager = $$NotificationsTableTableManager(
      $_db,
      $_db.notifications,
    ).filter((f) => f.companyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_notificationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompaniesTableFilterComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobUrl => $composableBuilder(
    column: $table.jobUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deadlineDate => $composableBuilder(
    column: $table.deadlineDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstAppliedAt => $composableBuilder(
    column: $table.firstAppliedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> applicationEventsRefs(
    Expression<bool> Function($$ApplicationEventsTableFilterComposer f) f,
  ) {
    final $$ApplicationEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.applicationEvents,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApplicationEventsTableFilterComposer(
            $db: $db,
            $table: $db.applicationEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notificationsRefs(
    Expression<bool> Function($$NotificationsTableFilterComposer f) f,
  ) {
    final $$NotificationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notifications,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationsTableFilterComposer(
            $db: $db,
            $table: $db.notifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompaniesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobUrl => $composableBuilder(
    column: $table.jobUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deadlineDate => $composableBuilder(
    column: $table.deadlineDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstAppliedAt => $composableBuilder(
    column: $table.firstAppliedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompaniesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get jobUrl =>
      $composableBuilder(column: $table.jobUrl, builder: (column) => column);

  GeneratedColumn<String> get deadlineDate => $composableBuilder(
    column: $table.deadlineDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get firstAppliedAt => $composableBuilder(
    column: $table.firstAppliedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> applicationEventsRefs<T extends Object>(
    Expression<T> Function($$ApplicationEventsTableAnnotationComposer a) f,
  ) {
    final $$ApplicationEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.applicationEvents,
          getReferencedColumn: (t) => t.companyId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ApplicationEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.applicationEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notificationsRefs<T extends Object>(
    Expression<T> Function($$NotificationsTableAnnotationComposer a) f,
  ) {
    final $$NotificationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notifications,
      getReferencedColumn: (t) => t.companyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationsTableAnnotationComposer(
            $db: $db,
            $table: $db.notifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompaniesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompaniesTable,
          Company,
          $$CompaniesTableFilterComposer,
          $$CompaniesTableOrderingComposer,
          $$CompaniesTableAnnotationComposer,
          $$CompaniesTableCreateCompanionBuilder,
          $$CompaniesTableUpdateCompanionBuilder,
          (Company, $$CompaniesTableReferences),
          Company,
          PrefetchHooks Function({
            bool applicationEventsRefs,
            bool tasksRefs,
            bool notificationsRefs,
          })
        > {
  $$CompaniesTableTableManager(_$AppDatabase db, $CompaniesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String> jobUrl = const Value.absent(),
                Value<String?> deadlineDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String?> firstAppliedAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => CompaniesCompanion(
                id: id,
                name: name,
                position: position,
                region: region,
                jobUrl: jobUrl,
                deadlineDate: deadlineDate,
                status: status,
                note: note,
                firstAppliedAt: firstAppliedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> position = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String> jobUrl = const Value.absent(),
                Value<String?> deadlineDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String?> firstAppliedAt = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => CompaniesCompanion.insert(
                id: id,
                name: name,
                position: position,
                region: region,
                jobUrl: jobUrl,
                deadlineDate: deadlineDate,
                status: status,
                note: note,
                firstAppliedAt: firstAppliedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CompaniesTable, Company>(table),
                  $$CompaniesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                applicationEventsRefs = false,
                tasksRefs = false,
                notificationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (applicationEventsRefs) db.applicationEvents,
                    if (tasksRefs) db.tasks,
                    if (notificationsRefs) db.notifications,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (applicationEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          Company,
                          $CompaniesTable,
                          ApplicationEvent,
                          $ApplicationEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CompaniesTableReferences
                              ._applicationEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompaniesTableReferences(
                                db,
                                table,
                                p0,
                              ).applicationEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'company_id',
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedDataByColumns<
                          Company,
                          $CompaniesTable,
                          Task,
                          $TasksTable
                        >(
                          currentTable: table,
                          referencedTable: $$CompaniesTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompaniesTableReferences(
                                db,
                                table,
                                p0,
                              ).tasksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'company_id',
                          typedResults: items,
                        ),
                      if (notificationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Company,
                          $CompaniesTable,
                          Notification,
                          $NotificationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CompaniesTableReferences
                              ._notificationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompaniesTableReferences(
                                db,
                                table,
                                p0,
                              ).notificationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'company_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CompaniesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompaniesTable,
      Company,
      $$CompaniesTableFilterComposer,
      $$CompaniesTableOrderingComposer,
      $$CompaniesTableAnnotationComposer,
      $$CompaniesTableCreateCompanionBuilder,
      $$CompaniesTableUpdateCompanionBuilder,
      (Company, $$CompaniesTableReferences),
      Company,
      PrefetchHooks Function({
        bool applicationEventsRefs,
        bool tasksRefs,
        bool notificationsRefs,
      })
    >;
typedef $$ApplicationEventsTableCreateCompanionBuilder =
    ApplicationEventsCompanion Function({
      Value<int> id,
      required int companyId,
      Value<String?> fromStatus,
      required String toStatus,
      required String changedAt,
      Value<String> note,
    });
typedef $$ApplicationEventsTableUpdateCompanionBuilder =
    ApplicationEventsCompanion Function({
      Value<int> id,
      Value<int> companyId,
      Value<String?> fromStatus,
      Value<String> toStatus,
      Value<String> changedAt,
      Value<String> note,
    });

final class $$ApplicationEventsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ApplicationEventsTable,
          ApplicationEvent
        > {
  $$ApplicationEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CompaniesTable _companyIdTable(_$AppDatabase db) =>
      db.companies.createAlias('application_events__company_id__companies__id');

  $$CompaniesTableProcessedTableManager get companyId {
    final $_column = $_itemColumn<int>('company_id')!;

    final manager = $$CompaniesTableTableManager(
      $_db,
      $_db.companies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ApplicationEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ApplicationEventsTable> {
  $$ApplicationEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromStatus => $composableBuilder(
    column: $table.fromStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toStatus => $composableBuilder(
    column: $table.toStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$CompaniesTableFilterComposer get companyId {
    final $$CompaniesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableFilterComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApplicationEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApplicationEventsTable> {
  $$ApplicationEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromStatus => $composableBuilder(
    column: $table.fromStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toStatus => $composableBuilder(
    column: $table.toStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompaniesTableOrderingComposer get companyId {
    final $$CompaniesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableOrderingComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApplicationEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApplicationEventsTable> {
  $$ApplicationEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromStatus => $composableBuilder(
    column: $table.fromStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toStatus =>
      $composableBuilder(column: $table.toStatus, builder: (column) => column);

  GeneratedColumn<String> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$CompaniesTableAnnotationComposer get companyId {
    final $$CompaniesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableAnnotationComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApplicationEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApplicationEventsTable,
          ApplicationEvent,
          $$ApplicationEventsTableFilterComposer,
          $$ApplicationEventsTableOrderingComposer,
          $$ApplicationEventsTableAnnotationComposer,
          $$ApplicationEventsTableCreateCompanionBuilder,
          $$ApplicationEventsTableUpdateCompanionBuilder,
          (ApplicationEvent, $$ApplicationEventsTableReferences),
          ApplicationEvent,
          PrefetchHooks Function({bool companyId})
        > {
  $$ApplicationEventsTableTableManager(
    _$AppDatabase db,
    $ApplicationEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApplicationEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApplicationEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> companyId = const Value.absent(),
                Value<String?> fromStatus = const Value.absent(),
                Value<String> toStatus = const Value.absent(),
                Value<String> changedAt = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => ApplicationEventsCompanion(
                id: id,
                companyId: companyId,
                fromStatus: fromStatus,
                toStatus: toStatus,
                changedAt: changedAt,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int companyId,
                Value<String?> fromStatus = const Value.absent(),
                required String toStatus,
                required String changedAt,
                Value<String> note = const Value.absent(),
              }) => ApplicationEventsCompanion.insert(
                id: id,
                companyId: companyId,
                fromStatus: fromStatus,
                toStatus: toStatus,
                changedAt: changedAt,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ApplicationEventsTable, ApplicationEvent>(table),
                  $$ApplicationEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({companyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (companyId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.companyId,
                        referencedTable: $$ApplicationEventsTableReferences
                            ._companyIdTable(db),
                        referencedColumn: $$ApplicationEventsTableReferences
                            ._companyIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ApplicationEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApplicationEventsTable,
      ApplicationEvent,
      $$ApplicationEventsTableFilterComposer,
      $$ApplicationEventsTableOrderingComposer,
      $$ApplicationEventsTableAnnotationComposer,
      $$ApplicationEventsTableCreateCompanionBuilder,
      $$ApplicationEventsTableUpdateCompanionBuilder,
      (ApplicationEvent, $$ApplicationEventsTableReferences),
      ApplicationEvent,
      PrefetchHooks Function({bool companyId})
    >;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String title,
  required String category,
  Value<int?> subjectId,
  Value<int?> companyId,
  required String scheduledDate,
  Value<String?> dueAt,
  Value<int> priority,
  Value<bool> isCompleted,
  Value<String?> completedAt,
  required String createdAt,
  required String updatedAt,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> category,
  Value<int?> subjectId,
  Value<int?> companyId,
  Value<String> scheduledDate,
  Value<String?> dueAt,
  Value<int> priority,
  Value<bool> isCompleted,
  Value<String?> completedAt,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('tasks__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<int>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CompaniesTable _companyIdTable(_$AppDatabase db) =>
      db.companies.createAlias('tasks__company_id__companies__id');

  $$CompaniesTableProcessedTableManager? get companyId {
    final $_column = $_itemColumn<int>('company_id');
    if ($_column == null) return null;
    final manager = $$CompaniesTableTableManager(
      $_db,
      $_db.companies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$NotificationsTable, List<Notification>>
  _notificationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.notifications,
    aliasName: 'tasks__id__notifications__task_id',
  );

  $$NotificationsTableProcessedTableManager get notificationsRefs {
    final manager = $$NotificationsTableTableManager(
      $_db,
      $_db.notifications,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_notificationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompaniesTableFilterComposer get companyId {
    final $$CompaniesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableFilterComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> notificationsRefs(
    Expression<bool> Function($$NotificationsTableFilterComposer f) f,
  ) {
    final $$NotificationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notifications,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationsTableFilterComposer(
            $db: $db,
            $table: $db.notifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompaniesTableOrderingComposer get companyId {
    final $$CompaniesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableOrderingComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompaniesTableAnnotationComposer get companyId {
    final $$CompaniesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableAnnotationComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> notificationsRefs<T extends Object>(
    Expression<T> Function($$NotificationsTableAnnotationComposer a) f,
  ) {
    final $$NotificationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.notifications,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotificationsTableAnnotationComposer(
            $db: $db,
            $table: $db.notifications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({
            bool subjectId,
            bool companyId,
            bool notificationsRefs,
          })
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int?> subjectId = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                Value<String> scheduledDate = const Value.absent(),
                Value<String?> dueAt = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                category: category,
                subjectId: subjectId,
                companyId: companyId,
                scheduledDate: scheduledDate,
                dueAt: dueAt,
                priority: priority,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String category,
                Value<int?> subjectId = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                required String scheduledDate,
                Value<String?> dueAt = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                category: category,
                subjectId: subjectId,
                companyId: companyId,
                scheduledDate: scheduledDate,
                dueAt: dueAt,
                priority: priority,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TasksTable, Task>(table),
                  $$TasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                subjectId = false,
                companyId = false,
                notificationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (notificationsRefs) db.notifications,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (subjectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$TasksTableReferences
                                ._subjectIdTable(db),
                            referencedColumn: $$TasksTableReferences
                                ._subjectIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (companyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.companyId,
                            referencedTable: $$TasksTableReferences
                                ._companyIdTable(db),
                            referencedColumn: $$TasksTableReferences
                                ._companyIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (notificationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Task,
                          $TasksTable,
                          Notification,
                          $NotificationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$TasksTableReferences
                              ._notificationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TasksTableReferences(
                                db,
                                table,
                                p0,
                              ).notificationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'task_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({
        bool subjectId,
        bool companyId,
        bool notificationsRefs,
      })
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      Value<int?> taskId,
      Value<int?> companyId,
      required String scheduledAt,
      Value<bool> isEnabled,
      required int platformNotificationId,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<int> id,
      Value<int?> taskId,
      Value<int?> companyId,
      Value<String> scheduledAt,
      Value<bool> isEnabled,
      Value<int> platformNotificationId,
    });

final class $$NotificationsTableReferences
    extends BaseReferences<_$AppDatabase, $NotificationsTable, Notification> {
  $$NotificationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TasksTable _taskIdTable(_$AppDatabase db) =>
      db.tasks.createAlias('notifications__task_id__tasks__id');

  $$TasksTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<int>('task_id');
    if ($_column == null) return null;
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CompaniesTable _companyIdTable(_$AppDatabase db) =>
      db.companies.createAlias('notifications__company_id__companies__id');

  $$CompaniesTableProcessedTableManager? get companyId {
    final $_column = $_itemColumn<int>('company_id');
    if ($_column == null) return null;
    final manager = $$CompaniesTableTableManager(
      $_db,
      $_db.companies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompaniesTableFilterComposer get companyId {
    final $$CompaniesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableFilterComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompaniesTableOrderingComposer get companyId {
    final $$CompaniesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableOrderingComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => column,
  );

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompaniesTableAnnotationComposer get companyId {
    final $$CompaniesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.companyId,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableAnnotationComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (Notification, $$NotificationsTableReferences),
          Notification,
          PrefetchHooks Function({bool taskId, bool companyId})
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> taskId = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                Value<String> scheduledAt = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> platformNotificationId = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                taskId: taskId,
                companyId: companyId,
                scheduledAt: scheduledAt,
                isEnabled: isEnabled,
                platformNotificationId: platformNotificationId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> taskId = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                required String scheduledAt,
                Value<bool> isEnabled = const Value.absent(),
                required int platformNotificationId,
              }) => NotificationsCompanion.insert(
                id: id,
                taskId: taskId,
                companyId: companyId,
                scheduledAt: scheduledAt,
                isEnabled: isEnabled,
                platformNotificationId: platformNotificationId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationsTable, Notification>(table),
                  $$NotificationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false, companyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.taskId,
                        referencedTable: $$NotificationsTableReferences
                            ._taskIdTable(db),
                        referencedColumn: $$NotificationsTableReferences
                            ._taskIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (companyId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.companyId,
                        referencedTable: $$NotificationsTableReferences
                            ._companyIdTable(db),
                        referencedColumn: $$NotificationsTableReferences
                            ._companyIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (Notification, $$NotificationsTableReferences),
      Notification,
      PrefetchHooks Function({bool taskId, bool companyId})
    >;
typedef $$ActiveTimersTableCreateCompanionBuilder =
    ActiveTimersCompanion Function({
      Value<int> id,
      required int subjectId,
      Value<int?> unitId,
      required String startedAt,
      Value<String?> runningSince,
      Value<int> elapsedSeconds,
      required String state,
    });
typedef $$ActiveTimersTableUpdateCompanionBuilder =
    ActiveTimersCompanion Function({
      Value<int> id,
      Value<int> subjectId,
      Value<int?> unitId,
      Value<String> startedAt,
      Value<String?> runningSince,
      Value<int> elapsedSeconds,
      Value<String> state,
    });

final class $$ActiveTimersTableReferences
    extends BaseReferences<_$AppDatabase, $ActiveTimersTable, ActiveTimer> {
  $$ActiveTimersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('active_timers__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $StudyUnitsTable _unitIdTable(_$AppDatabase db) =>
      db.studyUnits.createAlias('active_timers__unit_id__study_units__id');

  $$StudyUnitsTableProcessedTableManager? get unitId {
    final $_column = $_itemColumn<int>('unit_id');
    if ($_column == null) return null;
    final manager = $$StudyUnitsTableTableManager(
      $_db,
      $_db.studyUnits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActiveTimersTableFilterComposer
    extends Composer<_$AppDatabase, $ActiveTimersTable> {
  $$ActiveTimersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get runningSince => $composableBuilder(
    column: $table.runningSince,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyUnitsTableFilterComposer get unitId {
    final $$StudyUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableFilterComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActiveTimersTableOrderingComposer
    extends Composer<_$AppDatabase, $ActiveTimersTable> {
  $$ActiveTimersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get runningSince => $composableBuilder(
    column: $table.runningSince,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyUnitsTableOrderingComposer get unitId {
    final $$StudyUnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableOrderingComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActiveTimersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActiveTimersTable> {
  $$ActiveTimersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get runningSince => $composableBuilder(
    column: $table.runningSince,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$StudyUnitsTableAnnotationComposer get unitId {
    final $$StudyUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.studyUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudyUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.studyUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActiveTimersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActiveTimersTable,
          ActiveTimer,
          $$ActiveTimersTableFilterComposer,
          $$ActiveTimersTableOrderingComposer,
          $$ActiveTimersTableAnnotationComposer,
          $$ActiveTimersTableCreateCompanionBuilder,
          $$ActiveTimersTableUpdateCompanionBuilder,
          (ActiveTimer, $$ActiveTimersTableReferences),
          ActiveTimer,
          PrefetchHooks Function({bool subjectId, bool unitId})
        > {
  $$ActiveTimersTableTableManager(_$AppDatabase db, $ActiveTimersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActiveTimersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActiveTimersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActiveTimersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int?> unitId = const Value.absent(),
                Value<String> startedAt = const Value.absent(),
                Value<String?> runningSince = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<String> state = const Value.absent(),
              }) => ActiveTimersCompanion(
                id: id,
                subjectId: subjectId,
                unitId: unitId,
                startedAt: startedAt,
                runningSince: runningSince,
                elapsedSeconds: elapsedSeconds,
                state: state,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subjectId,
                Value<int?> unitId = const Value.absent(),
                required String startedAt,
                Value<String?> runningSince = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                required String state,
              }) => ActiveTimersCompanion.insert(
                id: id,
                subjectId: subjectId,
                unitId: unitId,
                startedAt: startedAt,
                runningSince: runningSince,
                elapsedSeconds: elapsedSeconds,
                state: state,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActiveTimersTable, ActiveTimer>(table),
                  $$ActiveTimersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subjectId = false, unitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (subjectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.subjectId,
                        referencedTable: $$ActiveTimersTableReferences
                            ._subjectIdTable(db),
                        referencedColumn: $$ActiveTimersTableReferences
                            ._subjectIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (unitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.unitId,
                        referencedTable: $$ActiveTimersTableReferences
                            ._unitIdTable(db),
                        referencedColumn: $$ActiveTimersTableReferences
                            ._unitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ActiveTimersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActiveTimersTable,
      ActiveTimer,
      $$ActiveTimersTableFilterComposer,
      $$ActiveTimersTableOrderingComposer,
      $$ActiveTimersTableAnnotationComposer,
      $$ActiveTimersTableCreateCompanionBuilder,
      $$ActiveTimersTableUpdateCompanionBuilder,
      (ActiveTimer, $$ActiveTimersTableReferences),
      ActiveTimer,
      PrefetchHooks Function({bool subjectId, bool unitId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$StudyUnitsTableTableManager get studyUnits =>
      $$StudyUnitsTableTableManager(_db, _db.studyUnits);
  $$StudySessionsTableTableManager get studySessions =>
      $$StudySessionsTableTableManager(_db, _db.studySessions);
  $$CompaniesTableTableManager get companies =>
      $$CompaniesTableTableManager(_db, _db.companies);
  $$ApplicationEventsTableTableManager get applicationEvents =>
      $$ApplicationEventsTableTableManager(_db, _db.applicationEvents);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$ActiveTimersTableTableManager get activeTimers =>
      $$ActiveTimersTableTableManager(_db, _db.activeTimers);
}
