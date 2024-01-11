import 'package:nightary/apps/database.dart';

abstract class DatabaseFactory {
  static NightaryDatabase? _instance;

  static init() {
    _instance = NightaryDatabase();
  }

  static NightaryDatabase get instance => _instance!;
}
