import 'package:drift/native.dart';
import 'package:nightary/domains/entities/sleep_record.dart';
import 'package:nightary/domains/entities/white_noise.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import '../domains/types/e_source.dart';

part 'database.g.dart';

// 만약 필요하면 넣기
// CREATE TABLE User
// (UserID INTEGER PRIMARY KEY,
// Nickname TEXT,
// TargetSleepTime INTEGER,
// NotificationAt TEXT,
// CreatedAt TEXT)

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [
  SleepRecord,
  WhiteNoise,
])
class NightaryDatabase extends _$NightaryDatabase {
  NightaryDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// class DatabaseHelper {
//   static Future<Database> initializeDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'app_database.db');
//
//     return openDatabase(
//       path,
//       onCreate: (db, version) {
//         db.execute(
//           "CREATE TABLE User(UserID INTEGER PRIMARY KEY, Nickname TEXT, TargetSleepTime INTEGER, NotificationAt TEXT, CreatedAt TEXT)",
//         );
//         db.execute(
//           "CREATE TABLE SleepRecord(RecordID INTEGER PRIMARY KEY, UserID INTEGER, StartSleepDate TEXT, EndSleepDate TEXT, Source TEXT, TodaySleepDebt INTEGER, TotalSleepDebt INTEGER, CreatedAt TEXT, FOREIGN KEY (UserID) REFERENCES User(UserID))",
//         );
//         db.execute(
//           "CREATE TABLE WhiteNoise(WhiteNoiseID INTEGER PRIMARY KEY, ImgUrl TEXT, FileLocation TEXT)",
//         );
//       },
//       version: 1,
//     );
//   }
// }
