import 'package:get/get.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:health/health.dart';

class HomeViewModel extends GetxController {
  late final UserRepository _repository;

  late final RxString userName;

  RxInt goalHour = 8.obs; //목표자는시간
  RxInt goalMin = 30.obs; //목표자는 분

  RxInt todaySleep = 0.obs;

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
    fetchLatestSleepData();
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

  int getTodaySleep(){
    return todaySleep.value;
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
    int totalDiff = (goalHour.value * 60 + goalMin.value) - (todaySleep.value);
    return (totalDiff / 60).floor().obs;
  }

  RxInt get minuteDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) - (todaySleep.value);
    return (totalDiff % 60).abs().obs;
  }

  int batteryPercentage() {
    return (todaySleep / 480 * 100).toInt(); //8시간자야 꽉차게
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
  //오늘 잔 시간 받아오기
  void fetchLatestSleepData() async {
    HealthFactory health = HealthFactory();
    bool accessGranted = await health.requestAuthorization([
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_ASLEEP,
    ]);

    if (accessGranted) {
      try {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 7)),
          DateTime.now(),
          [HealthDataType.SLEEP_IN_BED, HealthDataType.SLEEP_ASLEEP],
        );
        HealthDataPoint latestSleepData = healthData
            .where((data) => data.type == HealthDataType.SLEEP_IN_BED || data.type == HealthDataType.SLEEP_ASLEEP)
            .reduce((a, b) => a.dateTo.isAfter(b.dateTo) ? a : b);
        print("가장 최근의 수면 데이터: ${latestSleepData.value}분");
        todaySleep.value = double.parse(latestSleepData.value.toString()).toInt();
      } catch (error) {
        print("에러 발생: $error");
      }
    }

  }
}

