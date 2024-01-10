import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  RxString userName = "손형준".obs;

  RxInt goalHour = 8.obs;//목표자는시간
  RxInt goalMin = 30.obs;//목표자는 분

  RxInt sleepHour = 8.obs;//잔 시간
  RxInt sleepMin = 7.obs;//잔 분
  RxInt sleepDebt = 6.obs;


  void setUserName(String newName) {
    userName.value = newName;
  }
  void setGoalHour(int hour){
    goalHour.value = hour;
  }
  void setGoalMin(int minute){
    goalMin.value = minute;
  }

  void setSleepHour(int hour){
    sleepHour.value = hour;
  }
  void setSleepMin(int minute){
    sleepMin.value = minute;
  }
  void addSleepDebt(int hour){//쌓인 수면 빚
    sleepDebt.value += hour;
    if(sleepDebt.value < 0)sleepDebt.value = 0;
  }
  void setSleepDebt(int hour){//수면빚 재계산
    sleepDebt.value = hour;
  }


  RxInt get hourDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) - (sleepHour.value * 60 + sleepMin.value);
    return (totalDiff / 60).floor().obs;
  }

  RxInt get minuteDifference {
    int totalDiff = (goalHour.value * 60 + goalMin.value) - (sleepHour.value * 60 + sleepMin.value);
    return (totalDiff % 60).abs().obs;
  }

  int batteryPercentage(){
    return ((sleepHour.value * 60 + sleepMin.value)/1440 * 100).toInt();
  }

  RxInt get sleepDebtPercent {
    RxInt percent = 0.obs;
    if(sleepDebt.value >= 24) percent = 100.obs;
    else {
      percent = ((sleepDebt.value / 24) * 100).toInt().obs;
    }
    return percent;
  }

}