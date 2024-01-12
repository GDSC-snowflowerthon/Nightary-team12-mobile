import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:nightary/utilities/app_routes.dart';
import 'package:nightary/utilities/debouncer.dart';
import 'package:nightary/views/setting/setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingViewModel extends GetxController {
  RxInt alarmHour = 8.obs;
  RxInt alarmMinute = 0.obs;

  RxInt startGoalHour = 23.obs;
  RxInt startGoalMinute = 0.obs;
  RxInt endGoalHour = 7.obs;
  RxInt endGoalMinute = 0.obs;

  Debouncer debouncer = Debouncer(milliseconds: 100);

  RxInt get goalHour => () {
        int hour = endGoalHour.value - startGoalHour.value;
        int min = endGoalMinute.value - startGoalMinute.value;
        if (min < 0) {
          hour -= 1;
          min += 60;
        }
        if (hour < 0) hour += 24;
        return hour.obs;
      }();

  RxInt get goalMinute => () {
        int min = endGoalMinute.value - startGoalMinute.value;
        if (min < 0) min += 60;
        return min.obs;
      }();

  RxString nickname = "".obs;

  @override
  void onInit() {
    super.onInit();
    nickname.value = Get.find<UserRepository>().readNickname() ?? "";
    updateGoalTime();
    updateAlarmTime();
  }

  void onChangeAlarmTime(int hour, int minute) {
    debouncer.run(() {
      alarmHour.value = hour;
      alarmMinute.value = minute;
      SharedPreferenceFactory.setAlarmTime(hour, minute);
    });
  }

  void onTapSetAlarm(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const SetAlarmTimeDialog();
      },
    );
  }

  void onTapSetSleepTime(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const SetTargetSleepTimeDialog();
      },
    );
  }

  void updateGoalTime() {
    Map<TargetSleepTime, int> targetSleepTime =
        SharedPreferenceFactory.getTargetSleepTime();
    startGoalHour.value = targetSleepTime[TargetSleepTime.startHour] ?? 23;
    startGoalMinute.value = targetSleepTime[TargetSleepTime.startMinute] ?? 0;
    endGoalHour.value = targetSleepTime[TargetSleepTime.endHour] ?? 7;
    endGoalMinute.value = targetSleepTime[TargetSleepTime.endMinute] ?? 0;
  }

  void updateAlarmTime() {
    Map<AlarmTime, int> alarmTime = SharedPreferenceFactory.getAlarmTime();
    alarmHour.value = alarmTime[AlarmTime.hour] ?? 8;
    alarmMinute.value = alarmTime[AlarmTime.minute] ?? 0;
  }

  // void onTapSetDateSleepTime(BuildContext context) async {
  //   DateTime selectedTime = DateTime.now();
  //   final result = await showCupertinoDialog(
  //     context: context,
  //     builder: (_) => SleepTimeDatePicker(onSubmitDate: (date) {
  //       selectedTime = date;
  //     }),
  //   );
  //   if (result == null) {
  //     return;
  //   }

  //   // ignore: use_build_context_synchronously
  //   showCupertinoDialog(
  //     context: context,
  //     builder: (_) => SetSpecificDateSleepTime(
  //       startTime: selectedTime.copyWith(hour: 23, minute: 0),
  //       endTime: selectedTime.copyWith(hour: 7, minute: 0),
  //       onSubmitDate: (start, end) {
  //         // save time
  //       },
  //     ),
  //   );
  // }

  void onChangeStartTime(int hour, int minute) {
    debouncer.run(() {
      startGoalHour.value = hour;
      startGoalMinute.value = minute;
      SharedPreferenceFactory.setTargetSleepTime(
        hour,
        minute,
        endGoalHour.value,
        endGoalHour.value,
      );
    });
  }

  void onChangeEndTime(int hour, int minute) {
    debouncer.run(() {
      endGoalHour.value = hour;
      endGoalMinute.value = minute;
      SharedPreferenceFactory.setTargetSleepTime(
        startGoalHour.value,
        startGoalMinute.value,
        hour,
        minute,
      );
    });
  }

  void onTapTerm() {
    try {
      launchUrl(
        Uri.parse(
            "https://hyungjoon.notion.site/952fa77d1a6c4b8e9e0e2754ad7d22a2"),
      );
    } catch (e) {
      Get.snackbar("오류", "약관을 불러오는데 실패했습니다.");
    }
  }

  void onTapWithdrawal() {
    Get.offAllNamed(Routes.ONBOARDING);
  }
}
