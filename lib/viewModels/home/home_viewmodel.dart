import 'dart:convert';

import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:get/get.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:nightary/utilities/home_widget.dart';

class HomeViewModel extends GetxController {
  late final UserRepository _userRepository;
  late final SleepRecordRepository _sleepRecordRepository;

  late final RxString _userName;
  RxInt goalHour = 8.obs; //목표자는시간
  RxInt goalMin = 30.obs; //목표자는 분

  RxInt todaySleep = 0.obs;
  RxInt sleepDebt = 5.obs;
  var healthPercent = [0.0, 0.0, 0.0].obs;

  String get userName => _userName.value;

  final List<String> healthSentance = [
    '심장병',
    '조기사망',
    '고혈압',
  ];

  RxInt get sleepDebtPercent {
    RxInt percent = 0.obs;
    if (sleepDebt.value >= 24) {
      percent = 100.obs;
    } else {
      percent = ((sleepDebt.value / 24) * 100).toInt().obs;
    }
    return percent;
  }

  int get differenceSleepTime =>
      (goalHour.value * 60 + goalMin.value) - (todaySleep.value);

  void makeSentence(int hour) {
    double mind = mindPercent(hour);
    double die = diePercent(hour);
    double highblood = highBloodPressure(hour);
    healthPercent[0] = mind;
    healthPercent[1] = die;
    healthPercent[2] = highblood;
  }

  @override
  void onInit() {
    super.onInit();
    // DI
    _userRepository = Get.find<UserRepository>();
    _sleepRecordRepository = Get.find<SleepRecordRepository>();

    // Init Fetch
    _userName = _userRepository.readNickname()!.obs;

    Map<TargetSleepTime, int> targetSleepTime =
        SharedPreferenceFactory.getTargetSleepTime();
    goalHour.value = targetSleepTime[TargetSleepTime.endHour]! <
            targetSleepTime[TargetSleepTime.startHour]!
        ? targetSleepTime[TargetSleepTime.endHour]! +
            24 -
            targetSleepTime[TargetSleepTime.startHour]!
        : targetSleepTime[TargetSleepTime.endHour]! -
            targetSleepTime[TargetSleepTime.startHour]!;
    goalMin.value = targetSleepTime[TargetSleepTime.endMinute]! <
            targetSleepTime[TargetSleepTime.endMinute]!
        ? targetSleepTime[TargetSleepTime.endMinute]! +
            60 -
            targetSleepTime[TargetSleepTime.startMinute]!
        : targetSleepTime[TargetSleepTime.endMinute]! -
            targetSleepTime[TargetSleepTime.startMinute]!;

    _sleepRecordRepository
        .readRecentSleepRecord()
        .then((value) => {
              todaySleep.value = value["todaySleepTime"]!,
              sleepDebt.value = value["totalDept"]!,
              WidgetKit.setItem(
                  "widgetData",
                  jsonEncode(
                    WidgetData((todaySleep /
                            (goalHour.value * 60 + goalMin.value) *
                            100)
                        .toInt()),
                  ),
                  "group.nightary"),
              WidgetKit.reloadAllTimelines(),
            })
        .then((value) => makeSentence(todaySleep.value));
  }

  void setGoalHour(int hour) {
    goalHour.value = hour;
  }

  void setGoalMin(int minute) {
    goalMin.value = minute;
  }

  int batteryPercentage() {
    return (todaySleep / (goalHour.value * 60 + goalMin.value) * 100).toInt();
  }

  double mindPercent(int hour) {
    if (hour <= 4) {
      return 14;
    } else if (hour == 5) {
      return 12;
    } else if (hour == 6) {
      return 10;
    } else if (hour == 7) {
      return 8;
    } else if (hour == 8) {
      return 6;
    } else if (hour == 9) {
      return 4;
    } else if (hour >= 10) {
      return 2;
    } else {
      return 0;
    }
  }

  double diePercent(int hour) {
    if (hour <= 5) {
      return 1.21;
    } else if (hour == 6) {
      return 1.1;
    } else if (hour == 7) {
      return 1;
    } else if (hour == 8) {
      return 1.05;
    } else if (hour == 9) {
      return 1.36;
    } else if (hour >= 10) {
      return 1.36;
    } else {
      return 0;
    }
  }

  double highBloodPressure(int hour) {
    if (hour < 5) {
      return 23.5;
    }
    if (hour == 5) {
      return 14.1;
    } else if (hour == 6) {
      return 16.5;
    } else if (hour == 7) {
      return 19.9;
    } else if (hour == 8) {
      return 20.4;
    } else if (hour >= 9) {
      return 21.3;
    } else {
      return 0;
    }
  }
}
