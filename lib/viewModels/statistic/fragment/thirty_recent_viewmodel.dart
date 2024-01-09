import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';

class ThirtyRecentViewModel extends AbstractRecentViewModel {
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
  // TODO: implement sleepTimes
  List<DateTimeRange> get sleepTimes => _sleepTimes;

  @override
  void onInit() {
    super.onInit();

    _averageSleepTime = const TimeOfDay(hour: 10, minute: 0).obs;
    _changeAverageBattery = 0.obs;
    _changeLiabilities = 0.obs;
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
      DateTimeRange(
        start: DateTime(2024, 1, 3, 22, 00),
        end: DateTime(2024, 1, 4, 8, 00),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 2, 22, 00),
        end: DateTime(2024, 1, 3, 8, 00),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 1, 14, 00),
        end: DateTime(2024, 1, 2, 10, 59),
      ),
      DateTimeRange(
        start: DateTime(2024, 1, 1, 1, 00),
        end: DateTime(2024, 1, 1, 12, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 30, 9, 00),
        end: DateTime(2023, 12, 31, 0, 30),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 29, 12, 00),
        end: DateTime(2023, 12, 29, 16, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 28, 20, 00),
        end: DateTime(2023, 12, 29, 5, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 27, 23, 00),
        end: DateTime(2023, 12, 28, 7, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 26, 22, 00),
        end: DateTime(2023, 12, 27, 8, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 25, 22, 00),
        end: DateTime(2023, 12, 26, 8, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 24, 14, 00),
        end: DateTime(2023, 12, 25, 10, 59),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 24, 1, 00),
        end: DateTime(2023, 12, 24, 12, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 22, 9, 00),
        end: DateTime(2023, 12, 23, 0, 30),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 21, 12, 00),
        end: DateTime(2023, 12, 21, 16, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 20, 20, 00),
        end: DateTime(2023, 12, 21, 5, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 19, 23, 00),
        end: DateTime(2023, 12, 20, 7, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 18, 22, 00),
        end: DateTime(2023, 12, 19, 8, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 17, 22, 00),
        end: DateTime(2023, 12, 18, 8, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 16, 14, 00),
        end: DateTime(2023, 12, 17, 10, 59),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 16, 1, 00),
        end: DateTime(2023, 12, 16, 12, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 14, 9, 00),
        end: DateTime(2023, 12, 15, 0, 30),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 13, 12, 00),
        end: DateTime(2023, 12, 13, 16, 00),
      ),
      DateTimeRange(
        start: DateTime(2023, 12, 12, 20, 00),
        end: DateTime(2023, 12, 13, 5, 00),
      ),
    ].obs;
  }
}
