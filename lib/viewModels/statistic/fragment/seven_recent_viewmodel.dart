import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';

class SevenRecentViewModel extends AbstractRecentViewModel {
  late final Rx<TimeOfDay> _averageSleepTime;
  late final RxInt _changeAverageBattery;
  late final RxInt _changeLiabilities;
  late final RxList<DateTimeRange> _sleepTimes;

  @override
  TimeOfDay get averageSleepTime => _averageSleepTime.value;

  @override
  int get changeAverageBattery => _changeAverageBattery.value;

  @override
  int get changeLiabilities => _changeLiabilities.value;

  @override
  List<DateTimeRange> get sleepTimes => _sleepTimes;

  @override
  void onInit() {
    super.onInit();

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
  }
}
