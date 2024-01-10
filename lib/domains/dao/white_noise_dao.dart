import 'package:drift/drift.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/domains/entities/white_noise.dart';

part 'white_noise_dao.g.dart';

@DriftAccessor(tables: [WhiteNoise])
abstract class WhiteNoiseDao extends DatabaseAccessor<NightaryDatabase>
    with _$WhiteNoiseDaoMixin {
  WhiteNoiseDao(super.db);
}
