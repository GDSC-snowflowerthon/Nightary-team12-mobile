import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'app_database.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE User(UserID INTEGER PRIMARY KEY, Nickname TEXT, TargetSleepTime INTEGER, NotificationAt TEXT, CreatedAt TEXT)",
        );
        db.execute(
          "CREATE TABLE SleepRecord(RecordID INTEGER PRIMARY KEY, UserID INTEGER, StartSleepDate TEXT, EndSleepDate TEXT, Source TEXT, TodaySleepDebt INTEGER, TotalSleepDebt INTEGER, CreatedAt TEXT, FOREIGN KEY (UserID) REFERENCES User(UserID))",
        );
        db.execute(
          "CREATE TABLE WhiteNoise(WhiteNoiseID INTEGER PRIMARY KEY, ImgUrl TEXT, FileLocation TEXT)",
        );
      },
      version: 1,
    );
  }
}
