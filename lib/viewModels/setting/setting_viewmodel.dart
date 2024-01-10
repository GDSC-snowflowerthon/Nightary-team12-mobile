import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingViewModel extends GetxController {
  RxInt noticeHour = 10.obs;
  RxInt noticeMin = 0.obs;

  void setNoticeHour(int hour){
    noticeHour.value = hour;
  }
  void setNoticeMin(int min){
    noticeMin.value = min;
  }
}
