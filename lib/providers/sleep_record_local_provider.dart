import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/domains/dao/sleep_record_dao.dart';

class SleepRecordLocalProvider {
  static final SleepRecordDao _sleepRecordDao =
      DatabaseFactory.instance.sleepRecordDao;

  Future<List<dynamic>> readSleepRecords() async {
    final sleepRecords = await _sleepRecordDao.findAll();

    return sleepRecords.map((e) => e.toJson()).toList();
  }
}
