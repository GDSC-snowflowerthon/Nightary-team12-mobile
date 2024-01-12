import 'package:drift/drift.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/domains/entities/sleep_record.dart';

part 'sleep_record_dao.g.dart';

/// SleepRecordDao Class
/// 1. DataBase Accessor Class
///
/// SleepRecordData Class
/// 1. 기본적인 Return Value
/// 2. 정렬 및 비교 가능
/// 3. SleepRecordData.fromJson(json) 형태로 사용 가능
/// 4. SleepRecordData.toJson() 형태로 사용 가능
@DriftAccessor(tables: [SleepRecord])
class SleepRecordDao extends DatabaseAccessor<NightaryDatabase>
    with _$SleepRecordDaoMixin {
  SleepRecordDao(super.db);

  // Create
  Future<void> save(SleepRecordCompanion entity) =>
      into(sleepRecord).insertOnConflictUpdate(entity);

  Future<void> saveAll(List<SleepRecordCompanion> entities) =>
      batch((batch) => batch.insertAllOnConflictUpdate(sleepRecord, entities));

  Future<List<SleepRecordData>> findAllOrderByEndSleepDateLimit(int limitCnt) =>
      (select(sleepRecord)
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.endSleepDate)])
            ..limit(limitCnt))
          .get();

  // Read One
  Future<List<SleepRecordData>> findById(int id) =>
      (select(sleepRecord)..where((tbl) => tbl.id.equals(id))).get();
  
  Future<SleepRecordData> findRecentOne() => (select(sleepRecord)..orderBy([(tbl) => OrderingTerm.desc(tbl.endSleepDate)])).getSingle();

  // Read All
  Future<List<SleepRecordData>> findAll() => select(sleepRecord).get();

  // Update
  Future<void> updateByEntity(SleepRecordData entity) =>
      update(sleepRecord).replace(entity);

  // Delete
  Future<void> deleteByEntity(SleepRecordData entity) =>
      delete(sleepRecord).delete(entity);
}
