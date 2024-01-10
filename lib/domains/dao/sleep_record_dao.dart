import 'package:drift/drift.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/domains/entities/sleep_record.dart';

part 'sleep_record_dao.g.dart';

/// DataClass를 통해 toJson, fromJson을 자동으로 생성해줌
/// SleepRecordData.fromJson(json) 형태로 사용 가능
///
@DriftAccessor(tables: [SleepRecord])
abstract class SleepRecordDao extends DatabaseAccessor<NightaryDatabase>
    with _$SleepRecordDaoMixin {
  SleepRecordDao(super.db);
}
