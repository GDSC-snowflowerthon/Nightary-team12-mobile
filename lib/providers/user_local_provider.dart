import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalProvider {
  static final SharedPreferences _sharedPreferences =
      SharedPreferenceFactory.instance;
}
