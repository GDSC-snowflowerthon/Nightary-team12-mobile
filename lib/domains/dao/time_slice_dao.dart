import 'package:drift/drift.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/domains/entities/time_slice.dart';

part 'time_slice_dao.g.dart';

@DriftAccessor(tables: [TimeSlice])
class TimeSliceDao extends DatabaseAccessor<NightaryDatabase>
    with _$TimeSliceDaoMixin {
  TimeSliceDao(super.db);
}
