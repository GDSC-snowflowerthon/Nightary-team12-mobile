import 'package:get/get.dart';
import 'package:nightary/repositories/user_repository.dart';

class HomeViewModel extends GetxController {
  late final UserRepository _repository;

  late final RxString userName;

  RxInt goalHour = 8.obs; //목표자는시간
  RxInt goalMin = 30.obs; //목표자는 분

  RxInt sleepHour = 8.obs; //잔 시간
  RxInt sleepMin = 7.obs; //잔 분
  RxInt sleepDebt = 6.obs;

  var healthSentance = [
    '심장병 확률이 2.5% 올라갔어요.'.obs,
    '암 확률이 3.5% 올라갔어요.'.obs,
    '집에 보내주세요.'.obs,
    '심장병 확률이 2.5% 올라갔어요.'.obs,
    '암에 걸릴 확률이 3.5% 올라갔어요.'.obs,
    '심장병 확률이 2.5% 올라갔어요.'.obs,
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _repository = Get.find<UserRepository>();
    userName = _repository.readNickname()!.obs;
  }

  void setUserName(String newName) {
    userName.value = newName;
  }

  void setGoalHour(int hour) {
    goalHour.value = hour;
  }

  void setGoalMin(int minute) {
    goalMin.value = minute;
  }

  void setSleepHour(int hour) {
    sleepHour.value = hour;
  }

  void setSleepMin(int minute) {
    sleepMin.value = minute;
  }

  void addSleepDebt(int hour) {
    //쌓인 수면 빚
    sleepDebt.value += hour;
    if (sleepDebt.value < 0) sleepDebt.value = 0;
  }

  void setSleepDebt(int hour) {
    //수면빚 재계산
    sleepDebt.value = hour;
  }

  RxInt get hourDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) -
        (sleepHour.value * 60 + sleepMin.value);
    return (totalDiff / 60).floor().obs;
  }

  RxInt get minuteDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) -
        (sleepHour.value * 60 + sleepMin.value);
    return (totalDiff % 60).abs().obs;
  }

  int batteryPercentage() {
    return ((sleepHour.value * 60 + sleepMin.value) / 1440 * 100).toInt();
  }

  RxInt get sleepDebtPercent {
    RxInt percent = 0.obs;
    if (sleepDebt.value >= 24) {
      percent = 100.obs;
    } else {
      percent = ((sleepDebt.value / 24) * 100).toInt().obs;
    }
    return percent;
  }
}
