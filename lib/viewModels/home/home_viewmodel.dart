import 'package:get/get.dart';
import '../../models/User.dart';

class HomeViewModel extends GetxController {
  RxString userName = "손형준".obs;

  RxInt GoalHour = 8.obs;
  RxInt GoalMin = 30.obs;

  RxInt morningHour = 8.obs;
  RxInt morningMin = 7.obs;
  RxInt sleepDebt = 6.obs;


  void setUserName(String newName) { //사용자 이름
    userName.value = newName;
  }
  void setGoalHour(int hour){//목표자는시간
    GoalHour.value = hour;
  }
  void setGoalMin(int minute){//목표자는 분
    GoalMin.value = minute;
  }

  void setSleepHour(int hour){//잔 시간
    morningHour.value = hour;
  }
  void setSleepMin(int minute){//잔 분
    morningMin.value = minute;
  }
  void addSleepDebt(int hour){//쌓인 수면 빚
    sleepDebt.value += hour;
    if(sleepDebt.value < 0)sleepDebt.value = 0;
  }


  RxInt get hourDifference {
    int totalDiff = (GoalHour.value * 60 + GoalMin.value) - (morningHour.value * 60 + morningMin.value);
    return (totalDiff / 60).floor().obs;
  }

  RxInt get minuteDifference {
    int totalDiff = (GoalHour.value * 60 + GoalMin.value) - (morningHour.value * 60 + morningMin.value);
    return (totalDiff % 60).abs().obs;
  }

  int batteryPercentage(){
    return ((morningHour.value * 60 + morningMin.value)/1440 * 100).toInt();
  }


}