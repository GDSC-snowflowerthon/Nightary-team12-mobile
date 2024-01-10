// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SleepRecordTable extends SleepRecord
    with TableInfo<$SleepRecordTable, SleepRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepRecordTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startSleepDateMeta =
      const VerificationMeta('startSleepDate');
  @override
  late final GeneratedColumn<DateTime> startSleepDate =
      GeneratedColumn<DateTime>('startSleepDate', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endSleepDateMeta =
      const VerificationMeta('endSleepDate');
  @override
  late final GeneratedColumn<DateTime> endSleepDate = GeneratedColumn<DateTime>(
      'endSleepDate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumnWithTypeConverter<ESource, String> source =
      GeneratedColumn<String>('source', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ESource>($SleepRecordTable.$convertersource);
  static const VerificationMeta _todaySleepDebtMeta =
      const VerificationMeta('todaySleepDebt');
  @override
  late final GeneratedColumn<int> todaySleepDebt = GeneratedColumn<int>(
      'todaySleepDebt', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalSleepDebtMeta =
      const VerificationMeta('totalSleepDebt');
  @override
  late final GeneratedColumn<int> totalSleepDebt = GeneratedColumn<int>(
      'totalSleepDebt', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'createdAt', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        startSleepDate,
        endSleepDate,
        source,
        todaySleepDebt,
        totalSleepDebt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'SleepRecord';
  @override
  VerificationContext validateIntegrity(Insertable<SleepRecordData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('startSleepDate')) {
      context.handle(
          _startSleepDateMeta,
          startSleepDate.isAcceptableOrUnknown(
              data['startSleepDate']!, _startSleepDateMeta));
    } else if (isInserting) {
      context.missing(_startSleepDateMeta);
    }
    if (data.containsKey('endSleepDate')) {
      context.handle(
          _endSleepDateMeta,
          endSleepDate.isAcceptableOrUnknown(
              data['endSleepDate']!, _endSleepDateMeta));
    } else if (isInserting) {
      context.missing(_endSleepDateMeta);
    }
    context.handle(_sourceMeta, const VerificationResult.success());
    if (data.containsKey('todaySleepDebt')) {
      context.handle(
          _todaySleepDebtMeta,
          todaySleepDebt.isAcceptableOrUnknown(
              data['todaySleepDebt']!, _todaySleepDebtMeta));
    } else if (isInserting) {
      context.missing(_todaySleepDebtMeta);
    }
    if (data.containsKey('totalSleepDebt')) {
      context.handle(
          _totalSleepDebtMeta,
          totalSleepDebt.isAcceptableOrUnknown(
              data['totalSleepDebt']!, _totalSleepDebtMeta));
    } else if (isInserting) {
      context.missing(_totalSleepDebtMeta);
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepRecordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepRecordData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startSleepDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}startSleepDate'])!,
      endSleepDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}endSleepDate'])!,
      source: $SleepRecordTable.$convertersource.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!),
      todaySleepDebt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}todaySleepDebt'])!,
      totalSleepDebt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}totalSleepDebt'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}createdAt'])!,
    );
  }

  @override
  $SleepRecordTable createAlias(String alias) {
    return $SleepRecordTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ESource, String, String> $convertersource =
      const EnumNameConverter<ESource>(ESource.values);
}

class SleepRecordData extends DataClass implements Insertable<SleepRecordData> {
  final int id;
  final DateTime startSleepDate;
  final DateTime endSleepDate;
  final ESource source;
  final int todaySleepDebt;
  final int totalSleepDebt;
  final DateTime createdAt;
  const SleepRecordData(
      {required this.id,
      required this.startSleepDate,
      required this.endSleepDate,
      required this.source,
      required this.todaySleepDebt,
      required this.totalSleepDebt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['startSleepDate'] = Variable<DateTime>(startSleepDate);
    map['endSleepDate'] = Variable<DateTime>(endSleepDate);
    {
      map['source'] =
          Variable<String>($SleepRecordTable.$convertersource.toSql(source));
    }
    map['todaySleepDebt'] = Variable<int>(todaySleepDebt);
    map['totalSleepDebt'] = Variable<int>(totalSleepDebt);
    map['createdAt'] = Variable<DateTime>(createdAt);
    return map;
  }

  SleepRecordCompanion toCompanion(bool nullToAbsent) {
    return SleepRecordCompanion(
      id: Value(id),
      startSleepDate: Value(startSleepDate),
      endSleepDate: Value(endSleepDate),
      source: Value(source),
      todaySleepDebt: Value(todaySleepDebt),
      totalSleepDebt: Value(totalSleepDebt),
      createdAt: Value(createdAt),
    );
  }

  factory SleepRecordData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepRecordData(
      id: serializer.fromJson<int>(json['id']),
      startSleepDate: serializer.fromJson<DateTime>(json['startSleepDate']),
      endSleepDate: serializer.fromJson<DateTime>(json['endSleepDate']),
      source: $SleepRecordTable.$convertersource
          .fromJson(serializer.fromJson<String>(json['source'])),
      todaySleepDebt: serializer.fromJson<int>(json['todaySleepDebt']),
      totalSleepDebt: serializer.fromJson<int>(json['totalSleepDebt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startSleepDate': serializer.toJson<DateTime>(startSleepDate),
      'endSleepDate': serializer.toJson<DateTime>(endSleepDate),
      'source': serializer
          .toJson<String>($SleepRecordTable.$convertersource.toJson(source)),
      'todaySleepDebt': serializer.toJson<int>(todaySleepDebt),
      'totalSleepDebt': serializer.toJson<int>(totalSleepDebt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SleepRecordData copyWith(
          {int? id,
          DateTime? startSleepDate,
          DateTime? endSleepDate,
          ESource? source,
          int? todaySleepDebt,
          int? totalSleepDebt,
          DateTime? createdAt}) =>
      SleepRecordData(
        id: id ?? this.id,
        startSleepDate: startSleepDate ?? this.startSleepDate,
        endSleepDate: endSleepDate ?? this.endSleepDate,
        source: source ?? this.source,
        todaySleepDebt: todaySleepDebt ?? this.todaySleepDebt,
        totalSleepDebt: totalSleepDebt ?? this.totalSleepDebt,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('SleepRecordData(')
          ..write('id: $id, ')
          ..write('startSleepDate: $startSleepDate, ')
          ..write('endSleepDate: $endSleepDate, ')
          ..write('source: $source, ')
          ..write('todaySleepDebt: $todaySleepDebt, ')
          ..write('totalSleepDebt: $totalSleepDebt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startSleepDate, endSleepDate, source,
      todaySleepDebt, totalSleepDebt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepRecordData &&
          other.id == this.id &&
          other.startSleepDate == this.startSleepDate &&
          other.endSleepDate == this.endSleepDate &&
          other.source == this.source &&
          other.todaySleepDebt == this.todaySleepDebt &&
          other.totalSleepDebt == this.totalSleepDebt &&
          other.createdAt == this.createdAt);
}

class SleepRecordCompanion extends UpdateCompanion<SleepRecordData> {
  final Value<int> id;
  final Value<DateTime> startSleepDate;
  final Value<DateTime> endSleepDate;
  final Value<ESource> source;
  final Value<int> todaySleepDebt;
  final Value<int> totalSleepDebt;
  final Value<DateTime> createdAt;
  const SleepRecordCompanion({
    this.id = const Value.absent(),
    this.startSleepDate = const Value.absent(),
    this.endSleepDate = const Value.absent(),
    this.source = const Value.absent(),
    this.todaySleepDebt = const Value.absent(),
    this.totalSleepDebt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SleepRecordCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startSleepDate,
    required DateTime endSleepDate,
    required ESource source,
    required int todaySleepDebt,
    required int totalSleepDebt,
    required DateTime createdAt,
  })  : startSleepDate = Value(startSleepDate),
        endSleepDate = Value(endSleepDate),
        source = Value(source),
        todaySleepDebt = Value(todaySleepDebt),
        totalSleepDebt = Value(totalSleepDebt),
        createdAt = Value(createdAt);
  static Insertable<SleepRecordData> custom({
    Expression<int>? id,
    Expression<DateTime>? startSleepDate,
    Expression<DateTime>? endSleepDate,
    Expression<String>? source,
    Expression<int>? todaySleepDebt,
    Expression<int>? totalSleepDebt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startSleepDate != null) 'startSleepDate': startSleepDate,
      if (endSleepDate != null) 'endSleepDate': endSleepDate,
      if (source != null) 'source': source,
      if (todaySleepDebt != null) 'todaySleepDebt': todaySleepDebt,
      if (totalSleepDebt != null) 'totalSleepDebt': totalSleepDebt,
      if (createdAt != null) 'createdAt': createdAt,
    });
  }

  SleepRecordCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? startSleepDate,
      Value<DateTime>? endSleepDate,
      Value<ESource>? source,
      Value<int>? todaySleepDebt,
      Value<int>? totalSleepDebt,
      Value<DateTime>? createdAt}) {
    return SleepRecordCompanion(
      id: id ?? this.id,
      startSleepDate: startSleepDate ?? this.startSleepDate,
      endSleepDate: endSleepDate ?? this.endSleepDate,
      source: source ?? this.source,
      todaySleepDebt: todaySleepDebt ?? this.todaySleepDebt,
      totalSleepDebt: totalSleepDebt ?? this.totalSleepDebt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startSleepDate.present) {
      map['startSleepDate'] = Variable<DateTime>(startSleepDate.value);
    }
    if (endSleepDate.present) {
      map['endSleepDate'] = Variable<DateTime>(endSleepDate.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
          $SleepRecordTable.$convertersource.toSql(source.value));
    }
    if (todaySleepDebt.present) {
      map['todaySleepDebt'] = Variable<int>(todaySleepDebt.value);
    }
    if (totalSleepDebt.present) {
      map['totalSleepDebt'] = Variable<int>(totalSleepDebt.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordCompanion(')
          ..write('id: $id, ')
          ..write('startSleepDate: $startSleepDate, ')
          ..write('endSleepDate: $endSleepDate, ')
          ..write('source: $source, ')
          ..write('todaySleepDebt: $todaySleepDebt, ')
          ..write('totalSleepDebt: $totalSleepDebt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WhiteNoiseTable extends WhiteNoise
    with TableInfo<$WhiteNoiseTable, WhiteNoiseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WhiteNoiseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _imgUrlMeta = const VerificationMeta('imgUrl');
  @override
  late final GeneratedColumn<String> imgUrl = GeneratedColumn<String>(
      'imgUrl', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileLocationMeta =
      const VerificationMeta('fileLocation');
  @override
  late final GeneratedColumn<String> fileLocation = GeneratedColumn<String>(
      'fileLocation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, imgUrl, fileLocation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'SleepRecord';
  @override
  VerificationContext validateIntegrity(Insertable<WhiteNoiseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('imgUrl')) {
      context.handle(_imgUrlMeta,
          imgUrl.isAcceptableOrUnknown(data['imgUrl']!, _imgUrlMeta));
    } else if (isInserting) {
      context.missing(_imgUrlMeta);
    }
    if (data.containsKey('fileLocation')) {
      context.handle(
          _fileLocationMeta,
          fileLocation.isAcceptableOrUnknown(
              data['fileLocation']!, _fileLocationMeta));
    } else if (isInserting) {
      context.missing(_fileLocationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WhiteNoiseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WhiteNoiseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      imgUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imgUrl'])!,
      fileLocation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fileLocation'])!,
    );
  }

  @override
  $WhiteNoiseTable createAlias(String alias) {
    return $WhiteNoiseTable(attachedDatabase, alias);
  }
}

class WhiteNoiseData extends DataClass implements Insertable<WhiteNoiseData> {
  final int id;
  final String imgUrl;
  final String fileLocation;
  const WhiteNoiseData(
      {required this.id, required this.imgUrl, required this.fileLocation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['imgUrl'] = Variable<String>(imgUrl);
    map['fileLocation'] = Variable<String>(fileLocation);
    return map;
  }

  WhiteNoiseCompanion toCompanion(bool nullToAbsent) {
    return WhiteNoiseCompanion(
      id: Value(id),
      imgUrl: Value(imgUrl),
      fileLocation: Value(fileLocation),
    );
  }

  factory WhiteNoiseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WhiteNoiseData(
      id: serializer.fromJson<int>(json['id']),
      imgUrl: serializer.fromJson<String>(json['imgUrl']),
      fileLocation: serializer.fromJson<String>(json['fileLocation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imgUrl': serializer.toJson<String>(imgUrl),
      'fileLocation': serializer.toJson<String>(fileLocation),
    };
  }

  WhiteNoiseData copyWith({int? id, String? imgUrl, String? fileLocation}) =>
      WhiteNoiseData(
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        fileLocation: fileLocation ?? this.fileLocation,
      );
  @override
  String toString() {
    return (StringBuffer('WhiteNoiseData(')
          ..write('id: $id, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('fileLocation: $fileLocation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imgUrl, fileLocation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WhiteNoiseData &&
          other.id == this.id &&
          other.imgUrl == this.imgUrl &&
          other.fileLocation == this.fileLocation);
}

class WhiteNoiseCompanion extends UpdateCompanion<WhiteNoiseData> {
  final Value<int> id;
  final Value<String> imgUrl;
  final Value<String> fileLocation;
  const WhiteNoiseCompanion({
    this.id = const Value.absent(),
    this.imgUrl = const Value.absent(),
    this.fileLocation = const Value.absent(),
  });
  WhiteNoiseCompanion.insert({
    this.id = const Value.absent(),
    required String imgUrl,
    required String fileLocation,
  })  : imgUrl = Value(imgUrl),
        fileLocation = Value(fileLocation);
  static Insertable<WhiteNoiseData> custom({
    Expression<int>? id,
    Expression<String>? imgUrl,
    Expression<String>? fileLocation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imgUrl != null) 'imgUrl': imgUrl,
      if (fileLocation != null) 'fileLocation': fileLocation,
    });
  }

  WhiteNoiseCompanion copyWith(
      {Value<int>? id, Value<String>? imgUrl, Value<String>? fileLocation}) {
    return WhiteNoiseCompanion(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      fileLocation: fileLocation ?? this.fileLocation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imgUrl.present) {
      map['imgUrl'] = Variable<String>(imgUrl.value);
    }
    if (fileLocation.present) {
      map['fileLocation'] = Variable<String>(fileLocation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WhiteNoiseCompanion(')
          ..write('id: $id, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('fileLocation: $fileLocation')
          ..write(')'))
        .toString();
  }
}

abstract class _$NightaryDatabase extends GeneratedDatabase {
  _$NightaryDatabase(QueryExecutor e) : super(e);
  late final $SleepRecordTable sleepRecord = $SleepRecordTable(this);
  late final $WhiteNoiseTable whiteNoise = $WhiteNoiseTable(this);
  late final Index id = Index('id', 'CREATE INDEX id ON SleepRecord (id)');
  late final SleepRecordDao sleepRecordDao =
      SleepRecordDao(this as NightaryDatabase);
  late final WhiteNoiseDao whiteNoiseDao =
      WhiteNoiseDao(this as NightaryDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [sleepRecord, whiteNoise, id];
}
