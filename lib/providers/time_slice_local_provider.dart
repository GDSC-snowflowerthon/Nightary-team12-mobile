import 'package:nightary/apps/database.dart';
import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/domains/dao/time_slice_dao.dart';

class TimeSliceLocalProvider {
  static final TimeSliceDao _timeSliceDao =
      DatabaseFactory.instance.timeSliceDao;

  Future<void> saveAll(List<TimeSliceCompanion> list) async {
    await _timeSliceDao.saveAll(list);
  }
}
