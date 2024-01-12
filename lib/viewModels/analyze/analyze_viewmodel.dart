import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';

class AnalyzeViewModel extends GetxController {
  late final SleepRecordRepository _sleepRecordRepository;
  late final RxBool _isLoading;
  late final Rx<TimeOfDay> _averageSleepTime;
  late final RxList<DateTimeRange> _sleepTimes;
  late final RxMap<String, dynamic> _chartRange;

  @override
  bool get isLoading => _isLoading.value;

  @override
  TimeOfDay get averageSleepTime => _averageSleepTime.value;

  @override
  List<DateTimeRange> get sleepTimes => _sleepTimes;

  @override
  Map<String, dynamic> get chartRange => _chartRange;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _sleepRecordRepository = Get.find<SleepRecordRepository>();

    // Initialize Loading State
    _isLoading = true.obs;
    _sleepRecordRepository
        .loadSleepTimesLimit(14)
        .then(
          (value) => {
        _chartRange = RxMap<String, dynamic>(value["graphRange"]),
        _averageSleepTime = Rx<TimeOfDay>(value["averageSleepTime"]),
        _sleepTimes = RxList<DateTimeRange>(value["sleepTimes"]),
      },
    )
        .then((value) => _isLoading.value = false);
  }
}
