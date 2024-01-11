import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';
import 'package:nightary/utilities/log_system.dart';

class SleepRecordRepository extends GetxService {
  late final SleepRecordLocalProvider _provider;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<SleepRecordLocalProvider>();
  }

  Future<Map<String, dynamic>> loadSleepTimesLimit(int limitCnt) async {
    List<SleepRecordData> totalRecords =
        await _provider.readSleepRecordsLimit(limitCnt);

    LogSystem.logger.d("${totalRecords.length} sleep records found");

    /**
     * 최근 7개와 그 이전 7개의 수면 빚 변화량 계산
     */
    int changeLiabilities = totalRecords.first.totalSleepDebt -
        totalRecords[totalRecords.length ~/ 2].totalSleepDebt;

    /**
     * 최근 7개에 대한 수면 빚 변화량 및 그래프용 데이터(시간 역순)
     */
    List<SleepRecordData> recentRecords =
        totalRecords.sublist(0, limitCnt ~/ 2);
    List<SleepRecordData> reversedRecentRecords =
        recentRecords.reversed.toList();

    /**
     * 평균 수면 시간 계산
     */
    int averageSleepMinutes = (recentRecords
                .map((e) =>
                    e.endSleepDate.difference(e.startSleepDate).inMinutes)
                .reduce((value, element) => value + element) /
            totalRecords.length)
        .floor();

    TimeOfDay averageSleepTimeOfDay = TimeOfDay(
        hour: averageSleepMinutes ~/ 60, minute: averageSleepMinutes % 60);

    /**
     * 수면 시간 그래프용 데이터 후처리(시간 역순)
     */
    List<DateTimeRange> sleepTimes = recentRecords
        .map((e) => DateTimeRange(start: e.startSleepDate, end: e.endSleepDate))
        .toList();

    /**
     * 수면빚 그래프용 데이터 후처리(시간 정순)
     */
    List<FlSpot> liabilities = reversedRecentRecords
        .map((e) => FlSpot(
            reversedRecentRecords.indexOf(e).toDouble() +
                (e.endSleepDate.difference(e.startSleepDate).inDays / 2),
            e.totalSleepDebt.toDouble()))
        .toList();

    /**
     * 수면 빚 그래프에 대한 범위 계산
     */
    DateTime firstDate = recentRecords
        .map((e) => e.startSleepDate)
        .reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime lastDate = recentRecords
        .map((e) => e.endSleepDate)
        .reduce((value, element) => value.isAfter(element) ? value : element);
    int firstHour = min(
        recentRecords
                .map((e) => e.totalSleepDebt)
                .reduce((value, element) => value < element ? value : element) -
            5,
        0);
    int lastHour = recentRecords
            .map((e) => e.totalSleepDebt)
            .reduce((value, element) => value > element ? value : element) +
        1;

    int graphRangeX = lastDate.difference(firstDate).inDays + 1;
    int graphRangeY = lastHour - firstHour;

    Map<String, dynamic> graphRange = {
      "firstXLabel": firstDate,
      "xLabelRange": graphRangeX,
      "firstYLabel": firstHour,
      "yLabelRange": graphRangeY,
    };

    // 결과 반환
    return {
      "averageSleepTime": averageSleepTimeOfDay,
      "changeAverageBattery": 10,
      "changeLiabilities": changeLiabilities,
      "graphRange": graphRange,
      "sleepTimes": sleepTimes,
      "liabilities": liabilities
    };
  }
}
