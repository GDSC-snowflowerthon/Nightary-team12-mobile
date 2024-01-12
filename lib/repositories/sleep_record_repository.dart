import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/domains/types/e_source.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';
import 'package:nightary/providers/time_slice_local_provider.dart';
import 'package:nightary/utilities/log_system.dart';

class SleepRecordRepository extends GetxService {
  late final SleepRecordLocalProvider _sleepRecordProvider;
  late final TimeSliceLocalProvider _timeSliceProvider;

  @override
  void onInit() {
    super.onInit();
    _sleepRecordProvider = Get.find<SleepRecordLocalProvider>();
    _timeSliceProvider = Get.find<TimeSliceLocalProvider>();
  }

  Future<void> saveSleepRecordsByHealthData(
      List<Map<String, dynamic>> reversedHealthData,
      int userTargetSleepTime) async {
    List<SleepRecordModel> sleepRecordList = [];
    List<TimeSliceModel> timeSliceList = [];

    Map<String, dynamic> currentHealthData, nextHealthData;
    for (int i = 0; i < reversedHealthData.length - 1; i++) {
      currentHealthData = reversedHealthData[i];
      nextHealthData = reversedHealthData[i + 1];

      timeSliceList.add(
        TimeSliceModel(
          DateTime.parse(currentHealthData["date_from"]),
          DateTime.parse(currentHealthData["date_to"]),
        ),
      );

      int timeTerm = DateTime.parse(currentHealthData["date_to"])
          .difference(DateTime.parse(nextHealthData["date_from"]))
          .inMinutes;

      if (timeTerm.abs() > 120) {
        int targetSleepTime = userTargetSleepTime;
        int currentSleepTime = timeSliceList.last.end
            .difference(timeSliceList.first.start)
            .inMinutes;

        if (currentSleepTime < 10) {
          timeSliceList.clear();
          continue;
        }

        int todaySleepDebt = targetSleepTime - currentSleepTime;
        int totalSleepDebt = sleepRecordList.isNotEmpty
            ? sleepRecordList.last.totalSleepDebt
            : 0;

        sleepRecordList.add(
          SleepRecordModel(
            DateTime.parse(timeSliceList.first.start.toString()),
            DateTime.parse(timeSliceList.last.end.toString()),
            ESource.watch,
            todaySleepDebt,
            totalSleepDebt + todaySleepDebt,
            timeSliceList,
          ),
        );

        timeSliceList.clear();
      }
    }

    for (var record in sleepRecordList) {
      LogSystem.logger.d(record);
    }
    LogSystem.logger.d("sleepRecordList length: ${sleepRecordList.length}");

    List<int> recordIds = await _sleepRecordProvider.saveAll(sleepRecordList
        .map((e) => SleepRecordCompanion.insert(
              startSleepDate: e.start,
              endSleepDate: e.end,
              source: e.source,
              todaySleepDebt: e.todaySleepDebt,
              totalSleepDebt: e.totalSleepDebt,
              createdAt: DateTime.now(),
            ))
        .toList());

    // for (var recordId in recordIds) {
    //   await _timeSliceProvider.saveAll(timeSliceList
    //       .map((e) => TimeSliceCompanion.insert(
    //             recordId: recordId,
    //             startSleepDate: e.start,
    //             endSleepDate: e.end,
    //           ))
    //       .toList());
    // }
  }

  Future<Map<String, dynamic>> readRecentSleepRecord() async {
    SleepRecordData? sleepRecord = await _sleepRecordProvider.findRecentOne();

    print("sleepRecord: $sleepRecord");

    if (sleepRecord == null) {
      return {
        "todaySleepTime": 490,
        "totalDept": 23,
      };
    } else {
      return {
        "todaySleepTime": sleepRecord.endSleepDate
            .difference(sleepRecord.startSleepDate)
            .inMinutes,
        "totalDept": sleepRecord.totalSleepDebt ~/ 60,
      };
    }
  }

  Future<Map<String, dynamic>> loadSleepTimesLimit(int limitCnt) async {
    List<SleepRecordData> totalRecords =
        await _sleepRecordProvider.readSleepRecordsLimit(limitCnt);

    LogSystem.logger.d("${totalRecords.length} sleep records found");

    /**
     * 최근 7개와 그 이전 7개의 평균 배터리 변화량 계산
     */
    List<int> processingBattery = totalRecords
        .map((e) => ((e.endSleepDate.difference(e.startSleepDate).inHours * 60 +
                    e.endSleepDate.difference(e.startSleepDate).inMinutes) /
                480 *
                100)
            .toInt())
        .toList();

    int recentAverageBattery = (processingBattery
                .sublist(0, limitCnt ~/ 2)
                .reduce((value, element) => value + element) -
            processingBattery
                .sublist(limitCnt ~/ 2, limitCnt)
                .reduce((value, element) => value + element)) ~/
        100;

    /**
     * 최근 7개와 그 이전 7개의 수면 빚 변화량 계산
     */
    int changeLiabilities = (totalRecords.first.totalSleepDebt -
            totalRecords[totalRecords.length ~/ 2].totalSleepDebt) ~/
        60;

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
            recentRecords.length)
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
            (e.totalSleepDebt ~/ 60).toDouble()))
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
        (recentRecords.map((e) => e.totalSleepDebt).reduce(
                    (value, element) => value < element ? value : element)) ~/
                60 -
            2,
        0);
    int lastHour = (recentRecords.map((e) => e.totalSleepDebt).reduce(
                (value, element) => value > element ? value : element)) ~/
            60 +
        2;

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
      "changeAverageBattery": recentAverageBattery,
      "changeLiabilities": changeLiabilities,
      "graphRange": graphRange,
      "sleepTimes": sleepTimes,
      "liabilities": liabilities
    };
  }
  Future<List<DateTimeRange>> getPredictedSleepByLastTwentySleeps() async {
    // 최근 20개의 수면 기록을 가져온다.
    List<SleepRecordData> sleepRecords =
        await _provider.readSleepRecordsLimit(20);
    String endpoint = "analyze/predict/";
    final startSleepDateList = [];
    final endSleepDateList = [];
    sleepRecords.forEach((element) {
      startSleepDateList.add(element.startSleepDate.toString());
      endSleepDateList.add(element.endSleepDate.toString());
    });
    final requestBody = {
      "startSleepDate": startSleepDateList,
      "endSleepDate": endSleepDateList
    };
    return await _provider.getPredictedSleepByLastTwentySleeps(endpoint, requestBody);
  }

  Future<List<String>> getAnalysisSleepByLastTwentySleeps() async {
    // 최근 20개의 수면 기록을 가져온다.
    List<SleepRecordData> sleepRecords =
        await _provider.readSleepRecordsLimit(20);
    String endpoint = "analyze/analyze/";
    final startSleepDateList = [];
    final endSleepDateList = [];
    sleepRecords.forEach((element) {
      startSleepDateList.add(element.startSleepDate.toString());
      endSleepDateList.add(element.endSleepDate.toString());
    });
    final requestBody = {
      "startSleepDate": startSleepDateList,
      "endSleepDate": endSleepDateList
    };
    return await _provider.getAnalysisSleepByLastTwentySleeps(endpoint, requestBody);
  }
}

class SleepRecordModel {
  final DateTime start;
  final DateTime end;
  final ESource source;
  final int todaySleepDebt;
  final int totalSleepDebt;
  final List<TimeSliceModel> timeSliceList;

  SleepRecordModel(
    this.start,
    this.end,
    this.source,
    this.todaySleepDebt,
    this.totalSleepDebt,
    this.timeSliceList,
  );

  @override
  String toString() {
    return "start: $start\nend: $end\nsource: $source\ntodaySleepDebt: ${todaySleepDebt / 60}\ntotalSleepDebt: ${totalSleepDebt / 60}";
  }
}

class TimeSliceModel {
  final DateTime start;
  final DateTime end;

  TimeSliceModel(this.start, this.end);

  @override
  String toString() {
    return "time: $start ~ $end";
  }
}
