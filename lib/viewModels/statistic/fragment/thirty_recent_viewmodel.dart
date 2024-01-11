import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';

class ThirtyRecentViewModel extends AbstractRecentViewModel {
  late final SleepRecordRepository _sleepRecordRepository;
  late final RxBool _isLoading;
  late final Rx<TimeOfDay> _averageSleepTime;
  late final RxInt _changeAverageBattery;
  late final RxInt _changeLiabilities;
  late final RxList<DateTimeRange> _sleepTimes;
  late final RxList<FlSpot> _liabilities;
  late final RxMap<String, dynamic> _chartRange;

  @override
  bool get isLoading => _isLoading.value;

  @override
  TimeOfDay get averageSleepTime => _averageSleepTime.value;

  @override
  int get changeAverageBattery => _changeAverageBattery.value;

  @override
  int get changeLiabilities => _changeLiabilities.value;

  @override
  List<DateTimeRange> get sleepTimes => _sleepTimes;

  @override
  List<FlSpot> get liabilities => _liabilities;

  @override
  Map<String, dynamic> get chartRange => _chartRange;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _sleepRecordRepository = Get.find<SleepRecordRepository>();

    _isLoading = true.obs;
    _sleepRecordRepository
        .loadSleepTimesLimit(60)
        .then(
          (value) => {
            _chartRange = RxMap<String, dynamic>(value["graphRange"]),
            _averageSleepTime = Rx<TimeOfDay>(value["averageSleepTime"]),
            _changeAverageBattery = RxInt(value["changeAverageBattery"]),
            _changeLiabilities = RxInt(value["changeLiabilities"]),
            _sleepTimes = RxList<DateTimeRange>(value["sleepTimes"]),
            _liabilities = RxList<FlSpot>(value["liabilities"]),
          },
        )
        .then((value) => _isLoading.value = false);
  }
}
