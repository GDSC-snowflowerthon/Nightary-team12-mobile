import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFactory {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
    _instance!.remove("nickname");
  }

  static SharedPreferences get instance => _instance!;
}
