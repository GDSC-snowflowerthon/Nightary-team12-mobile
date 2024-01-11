import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';

class SevenRecentViewModel extends AbstractRecentViewModel {
  late final SleepRecordRepository _sleepRecordRepository;

  late final RxBool _isLoading;
  late final Rx<TimeOfDay> _averageSleepTime;
  late final RxInt _changeAverageBattery;
  late final RxInt _changeLiabilities;
  late final RxList<DateTimeRange> _sleepTimes;
  late final RxList<FlSpot> _liabilities;

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
  Map<String, double> get liabilityChartRange => {
        "minX": liabilities
            .map((e) => e.x)
            .reduce((value, element) => value < element ? value : element)
            .toDouble(),
        "maxX": liabilities
            .map((e) => e.x)
            .reduce((value, element) => value > element ? value : element)
            .ceil()
            .toDouble(),
        "minY": liabilities
                .map((e) => e.y)
                .reduce((value, element) => value < element ? value : element)
                .toDouble() -
            1,
        "maxY": liabilities
                .map((e) => e.y)
                .reduce((value, element) => value > element ? value : element)
                .toDouble() +
            1,
      };

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _sleepRecordRepository = Get.find<SleepRecordRepository>();

    // Initialize Loading State
    _isLoading = true.obs;
    _sleepRecordRepository
        .readSleepRecords()
        .then((value) => _isLoading.value = false);

    _averageSleepTime = const TimeOfDay(hour: 5, minute: 0).obs;
    _changeAverageBattery = 12.obs;
    _changeLiabilities = (-3).obs;
    _sleepTimes = [
      DateTimeRange(
        start: DateTime(2024, 1, 10, 14, 00),
        end: DateTime(2024, 1, 11, 10, 59),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 10, 1, 00),
        end: DateTime(2024, 1, 10, 12, 00),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 8, 9, 00),
        end: DateTime(2024, 1, 9, 0, 30),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 7, 12, 00),
        end: DateTime(2024, 1, 7, 16, 00),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 6, 20, 00),
        end: DateTime(2024, 1, 7, 5, 00),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 5, 23, 00),
        end: DateTime(2024, 1, 6, 7, 00),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 4, 22, 00),
        end: DateTime(2024, 1, 5, 8, 00),
      ),
    ].obs;
    _liabilities = const [
      FlSpot(4, 4),
      FlSpot(4.5, 3),
      FlSpot(5.5, 5),
      FlSpot(6.5, 2),
      FlSpot(7.5, 4),
      FlSpot(8.5, 5),
      FlSpot(9.5, 6),
      FlSpot(10.5, 2),
    ].obs;
  }

  void fetchSleepRecords() {
    _isLoading = true.obs;
    _sleepRecordRepository
        .readSleepRecords()
        .then((value) => _isLoading = false.obs);
  }
}
