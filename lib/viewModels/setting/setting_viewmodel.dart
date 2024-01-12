import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:nightary/utilities/app_routes.dart';
import 'package:nightary/utilities/debouncer.dart';
import 'package:nightary/views/setting/setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
    showNotification();
  }

  void onChangeAlarmTime(int hour, int minute) {
    debouncer.run(() {
      alarmHour.value = hour;
      alarmMinute.value = minute;
      showNotification();

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
    DatabaseFactory.deleteDummyDataInSleepRecord();
    SharedPreferenceFactory.removeNickname();
    WidgetKit.removeItem("widgetData", "group.nightary");
    WidgetKit.reloadAllTimelines();
    Get.offAllNamed(Routes.ONBOARDING);
  }

  showNotification() async {
    final notifications = FlutterLocalNotificationsPlugin();

    //ios에서 앱 로드시 유저에게 권한요청하려면
    const iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings =
        InitializationSettings(iOS: iosSetting, macOS: iosSetting);
    await notifications.initialize(initializationSettings);

    notifications.initialize(initializationSettings);
    tz.initializeTimeZones();

    var iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    notifications.cancel(1);
    await notifications.zonedSchedule(
        1,
        '오늘의 배터리 양을 확인하세요!',
        '',
        makeDate(alarmHour.value, alarmMinute.value, 0),
        NotificationDetails(iOS: iosDetails),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  makeDate(int hour, int min, int sec) {
    var now = tz.TZDateTime.now(tz.local);
    var when =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min, sec);
    if (when.isBefore(now)) {
      return when.add(const Duration(days: 1));
    } else {
      return when;
    }
  }
}
