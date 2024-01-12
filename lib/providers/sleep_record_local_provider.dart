import 'package:nightary/apps/database.dart';
import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/domains/dao/sleep_record_dao.dart';

class SleepRecordLocalProvider {
  static final SleepRecordDao _sleepRecordDao =
      DatabaseFactory.instance.sleepRecordDao;

  Future<List<SleepRecordData>> readSleepRecordsLimit(int limitCnt) async {
    List<SleepRecordData> sleepRecords =
        await _sleepRecordDao.findAllOrderByEndSleepDateLimit(limitCnt);

    return sleepRecords;
  }
}
