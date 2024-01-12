import 'package:nightary/apps/database.dart';

abstract class DatabaseFactory {
  static NightaryDatabase? _instance;

  static NightaryDatabase get instance => _instance!;

  static Future<void> init() async {
    _instance = NightaryDatabase();
    // await deleteDummyDataInSleepRecord();
  }

  static Future<void> deleteDummyDataInSleepRecord() async {
    await instance.delete(instance.timeSlice).go();
    await instance.delete(instance.sleepRecord).go();
  }
}
