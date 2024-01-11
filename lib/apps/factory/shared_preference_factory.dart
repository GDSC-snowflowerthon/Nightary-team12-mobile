import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFactory {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _instance!;
}
