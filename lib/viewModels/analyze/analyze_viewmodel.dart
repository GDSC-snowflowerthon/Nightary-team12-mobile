import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';

class AnalyzeViewModel extends GetxController {
  late final SleepRecordRepository _sleepRecordRepository;
  late final RxBool _isLoading;
  late final RxList<DateTimeRange> _sleepTimes;
  late final List<String> _totalAnalysisText;
  late final String _analysisText;
  late final String _feedbackText;

  bool get isLoading => _isLoading.value;
  List<DateTimeRange> get sleepTimes => _sleepTimes;
  String get analysisText => _analysisText;
  String get feedbackText => _feedbackText;

  @override
  void onInit() async {
    super.onInit();
    //Dependency Injection
    _sleepRecordRepository = Get.find<SleepRecordRepository>();
    _isLoading = true.obs;
    List<DateTimeRange> currentSleepTimes = (await _sleepRecordRepository.loadSleepTimesLimit(15))["sleepTimes"];
    List<DateTimeRange> predictedSleepTimes = await _sleepRecordRepository.getPredictedSleepByLastTwentySleeps();
    _sleepTimes = RxList<DateTimeRange>(predictedSleepTimes.reversed.toList() + currentSleepTimes);
    _totalAnalysisText = await _sleepRecordRepository.getAnalysisSleepByLastTwentySleeps();
    _analysisText = _totalAnalysisText[0];
    _feedbackText = _totalAnalysisText[1];

    _isLoading.value = false;
  }
}
