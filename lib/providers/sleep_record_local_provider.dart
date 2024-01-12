import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/apps/database.dart';
import 'package:nightary/apps/factory/database_factory.dart';
import 'package:nightary/domains/dao/sleep_record_dao.dart';
import 'package:nightary/utilities/log_system.dart';

class SleepRecordLocalProvider extends GetConnect {
  static final SleepRecordDao _sleepRecordDao =
      DatabaseFactory.instance.sleepRecordDao;

  @override
  void onInit() {
    super.onInit();
    httpClient
      ..baseUrl = "https://nightary.dcs-hyungjoon.com/"
      ..timeout = const Duration(seconds: 60)
      ..addRequestModifier<dynamic>((request) {
        LogSystem.logger.d("Request: ${request.method} ${request.url}");

        return request;
      })
      ..addResponseModifier((request, response) {
        if (response.status.hasError) {
          LogSystem.logger.e(
              "Response: ${response.statusCode} ${response.statusCode} ${response.statusText}");
        } else {
          LogSystem.logger
              .d("Response: ${response.statusCode} ${response.body}");
        }

        return response;
      });
  }

  Future<SleepRecordData?> findRecentOne() async {
    try {
      return await _sleepRecordDao.findRecentOne();
    } catch (e) {
      LogSystem.logger.e(e.toString());
      return null;
    }
  }

  Future<List<int>> saveAll(List<SleepRecordCompanion> entities) async {
    return await _sleepRecordDao.saveAll(entities);
  }

  Future<List<SleepRecordData>> readSleepRecordsLimit(int limitCnt) async {
    List<SleepRecordData> sleepRecords =
        await _sleepRecordDao.findAllOrderByEndSleepDateLimit(limitCnt);

    return sleepRecords;
  }

  Future<List<DateTimeRange>> getPredictedSleepByLastTwentySleeps(
      String endpoint, final requestBody) async {
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

  Future<List<String>> getAnalysisSleepByLastTwentySleeps(
      endpoint, final requestBody) async {
    final Response response =
        await post(endpoint, requestBody, contentType: "application/json");
    print(response.body);
    final data = response.body as Map<String, dynamic>;
    final String chatGptAnalysis = data["chat_gpt_analysis"];
    final String chatGptFeedback = data["chat_gpt_feedback"];
    final List<String> analysisText = [chatGptAnalysis, chatGptFeedback];
    return analysisText;
  }
}
