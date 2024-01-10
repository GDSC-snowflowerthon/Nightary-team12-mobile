import 'package:drift/drift.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/domains/entities/white_noise.dart';

part 'white_noise_dao.g.dart';

/// WhiteNoiseDao Class
/// 1. DataBase Accessor Class
///
/// WhiteNoiseData Class
/// 1. 기본적인 Return Value
/// 2. 정렬 및 비교 가능
/// 3. SleepRecordData.fromJson(json) 형태로 사용 가능
/// 4. SleepRecordData.toJson() 형태로 사용 가능
@DriftAccessor(tables: [WhiteNoise])
abstract class WhiteNoiseDao extends DatabaseAccessor<NightaryDatabase>
    with _$WhiteNoiseDaoMixin {
  WhiteNoiseDao(super.db);

  // Create
  Future<void> save(WhiteNoiseCompanion entity) =>
      into(whiteNoise).insert(entity);

  // Read One
  Future<List<WhiteNoiseData>> findById(int id) =>
      (select(whiteNoise)..where((tbl) => tbl.id.equals(id))).get();

  // Read All
  Future<List<WhiteNoiseData>> findAll() => select(whiteNoise).get();

  // Update
  Future<void> updateByEntity(WhiteNoiseData entity) =>
      update(whiteNoise).replace(entity);

  // Delete
  Future<void> deleteByEntity(WhiteNoiseData entity) =>
      delete(whiteNoise).delete(entity);
}
