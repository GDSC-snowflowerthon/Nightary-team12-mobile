import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/domains/dao/sleep_record_dao.dart';

class SleepRecordLocalProvider extends GetConnect implements GetxService {
  static final SleepRecordDao _sleepRecordDao =
      DatabaseFactory.instance.sleepRecordDao;

  Future<List<SleepRecordData>> readSleepRecordsLimit(int limitCnt) async {
    List<SleepRecordData> sleepRecords =
        await _sleepRecordDao.findAllOrderByEndSleepDateLimit(limitCnt);

    return sleepRecords;
  }

  Future<List<DateTimeRange>> getPredictedSleepByLastTwentySleeps(String endpoint, final requestBody) async {
    final response =
        await post(endpoint, requestBody, contentType: "application/json");
    final data = response.body as Map<String, dynamic>;
    final List<dynamic> startTimeList = data["start_time_forecast"];
    final List<dynamic> endTimeList = data["end_time_forecast"];
    final predictedSleep = <DateTimeRange>[];
    for (int i = 0; i < startTimeList.length; i++) {
      predictedSleep.add(DateTimeRange(
          start: DateTime.parse(startTimeList[i]),
          end: DateTime.parse(endTimeList[i])));
    }
    return predictedSleep;
  }
}
