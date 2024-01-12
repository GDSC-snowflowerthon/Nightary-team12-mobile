import 'package:get/get.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:health/health.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';

class HomeViewModel extends GetxController {
  late final UserRepository _userRepository;
  late final SleepRecordRepository _sleepRecordRepository;

  late final RxString _userName;
  RxInt goalHour = 8.obs; //목표자는시간
  RxInt goalMin = 30.obs; //목표자는 분

  RxInt todaySleep = 0.obs;
  RxInt sleepDebt = 5.obs;
  var healthPercent = [0.0, 0.0, 0.0].obs;

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

  String get userName => _userName.value;

  int get hourDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) - (todaySleep.value);
    return (totalDiff / 60).floor();
  }

  int get minuteDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) - (todaySleep.value);
    return (totalDiff % 60).abs();
  }

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
    goalHour.value = targetSleepTime[TargetSleepTime.startHour] ?? 0;
    goalMin.value = targetSleepTime[TargetSleepTime.startMinute] ?? 0;

    _sleepRecordRepository
        .readRecentSleepRecord()
        .then((value) => {
              todaySleep.value =
                  value["sleepHour"]! * 60 + value["sleepMinutes"]!,
              sleepDebt.value = value["totalDept"]!,
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
    return (todaySleep / 480 * 100).toInt(); //8시간자야 꽉차게
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
            .where((data) =>
                data.type == HealthDataType.SLEEP_IN_BED ||
                data.type == HealthDataType.SLEEP_ASLEEP)
            .reduce((a, b) => a.dateTo.isAfter(b.dateTo) ? a : b);
        print("가장 최근의 수면 데이터: ${latestSleepData.value}분");
        todaySleep.value =
            double.parse(latestSleepData.value.toString()).toInt();
      } catch (error) {
        print("에러 발생: $error");
      }
    }
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
