import 'package:drift/drift.dart';
import 'package:nightary/domains/entities/sleep_record.dart';

class TimeSlice extends Table {
  @override
  String get tableName => 'TimeSlice';

  // @override
  // List<Set<Column<Object>>>? get uniqueKeys => [
  //       {startSleepDate, endSleepDate}
  //     ];

  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get recordId =>
      integer().references(SleepRecord, #id).named('recordId')();
  DateTimeColumn get startSleepDate => dateTime().named('startSleepDate')();
  DateTimeColumn get endSleepDate => dateTime().named('endSleepDate')();
}
