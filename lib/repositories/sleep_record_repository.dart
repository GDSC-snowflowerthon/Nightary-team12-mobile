import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';

class SleepRecordRepository extends GetxService {
  late final SleepRecordLocalProvider _provider;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<SleepRecordLocalProvider>();
  }

  Future<Map<String, dynamic>> readRecentSleepRecord() async {
    SleepRecordData? sleepRecord = await _provider.findRecentOne();

    if (sleepRecord == null) {
      return {
        "sleepHour": 7,
        "sleepMinutes": 50,
        "totalDept": 23,
      };
    } else {
      return {
        "sleepHour": sleepRecord.endSleepDate.difference(sleepRecord.startSleepDate).inHours,
        "sleepMinutes": sleepRecord.endSleepDate.difference(sleepRecord.startSleepDate).inMinutes,
        "totalDept": sleepRecord.totalSleepDebt,
      };
    }
  }
}
