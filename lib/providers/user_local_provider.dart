import 'package:flutter/material.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalProvider {
  static final SharedPreferences _sharedPreferences =
      SharedPreferenceFactory.instance;

  String? findNickname() {
    return _sharedPreferences.getString('nickname');
  }

  int findTargetSleepTime() {
    TimeOfDay start = TimeOfDay(
      hour: _sharedPreferences.getInt(TargetSleepTime.startHour.name) ?? 0,
      minute: _sharedPreferences.getInt(TargetSleepTime.startMinute.name) ?? 0,
    );

    TimeOfDay end = TimeOfDay(
      hour: _sharedPreferences.getInt(TargetSleepTime.endHour.name) ?? 0,
      minute: _sharedPreferences.getInt(TargetSleepTime.endMinute.name) ?? 0,
    );

    return end.hour > start.hour
        ? end.hour * 60 + end.minute - start.hour * 60 - start.minute
        : end.hour * 60 + end.minute - start.hour * 60 - start.minute + 24 * 60;
  }

  Future<void> writeNickname(String nickname) async {
    await _sharedPreferences.setString('nickname', nickname);
    await _sharedPreferences.setInt(TargetSleepTime.startHour.name, 23);
    await _sharedPreferences.setInt(TargetSleepTime.startMinute.name, 00);
    await _sharedPreferences.setInt(TargetSleepTime.endHour.name, 6);
    await _sharedPreferences.setInt(TargetSleepTime.endMinute.name, 00);
    await _sharedPreferences.setInt(AlarmTime.hour.name, 7);
    await _sharedPreferences.setInt(AlarmTime.minute.name, 00);
  }
}
