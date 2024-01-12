import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';

class AnalyzeViewModel extends GetxController {
  late final SleepRecordRepository _sleepRecordRepository;
  late final RxBool _isLoading;
  late final RxList<DateTimeRange> _sleepTimes;

  bool get isLoading => _isLoading.value;
  List<DateTimeRange> get sleepTimes => _sleepTimes;

  @override
  void onInit() async {
    super.onInit();
    //Dependency Injection
    _sleepRecordRepository = Get.find<SleepRecordRepository>();
    _isLoading = true.obs;
    List<DateTimeRange> currentSleepTimes = (await _sleepRecordRepository.loadSleepTimesLimit(15))["sleepTimes"];
    List<DateTimeRange> predictedSleepTimes = await _sleepRecordRepository.getPredictedSleepByLastTwentySleeps();
    _sleepTimes = RxList<DateTimeRange>(predictedSleepTimes.reversed.toList() + currentSleepTimes);
    _isLoading.value = false;
  }
}
