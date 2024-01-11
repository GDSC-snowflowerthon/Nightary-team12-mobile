import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:nightary/views/setting/setting_screen.dart';
import 'package:time_range_picker/time_range_picker.dart';

class SettingViewModel extends GetxController {
  RxInt noticeHour = 10.obs;
  RxInt noticeMin = 0.obs;

  RxInt goalHour = 8.obs; //목표자는시간
  RxInt goalMin = 30.obs; //목표자는 분

  RxInt startHour = 23.obs;
  RxInt startMin = 0.obs;
  RxInt endHour = 7.obs;
  RxInt endMin = 0.obs;

  RxString nickname = "".obs;

  @override
  void onInit() {
    super.onInit();
    nickname.value = Get.find<UserRepository>().readNickname() ?? "";
    updateGoalTime();
  }

  void setNoticeHour(int hour) {
    noticeHour.value = hour;
  }

  void setNoticeMin(int min) {
    noticeMin.value = min;
  }

  void onTapSetAlarm(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const SetNoticeTime();
      },
    );
  }

  void onTapSetSleepTime(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const SetTargetSleepTime();
      },
    );
  }

  void updateGoalTime() {
    Map<TargetSleepTime, int> targetSleepTime =
    SharedPreferenceFactory.getTargetSleepTime();
    goalHour.value = targetSleepTime[TargetSleepTime.startHour] ?? 0;
    goalMin.value = targetSleepTime[TargetSleepTime.startMinute] ?? 0;
  }

  void onChangeStartTime(int hour, int minute) {
    startHour.value = hour;
    startMin.value = minute;
  }

  void onChangeEndTime(int hour, int minute) {
    endHour.value = hour;
    endMin.value = minute;
  }
}