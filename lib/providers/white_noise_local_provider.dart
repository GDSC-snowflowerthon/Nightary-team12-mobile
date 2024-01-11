import 'package:nightary/apps/database.dart';
import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/domains/dao/white_noise_dao.dart';

class WhiteNoiseLocalProvider {
  static final WhiteNoiseDao _whiteNoiseDao =
      DatabaseFactory.instance.whiteNoiseDao;
}
