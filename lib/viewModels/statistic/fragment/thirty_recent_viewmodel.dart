import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';

class ThirtyRecentViewModel extends AbstractRecentViewModel {
  late final Rx<TimeOfDay> _averageSleepTime;
  late final RxInt _changeAverageBattery;
  late final RxInt _changeLiabilities;

  @override
  TimeOfDay get averageSleepTime => _averageSleepTime.value;

  @override
  int get changeAverageBattery => _changeAverageBattery.value;

  @override
  int get changeLiabilities => _changeLiabilities.value;

  @override
  void onInit() {
    super.onInit();

    _averageSleepTime = const TimeOfDay(hour: 10, minute: 0).obs;
    _changeAverageBattery = 0.obs;
    _changeLiabilities = 0.obs;
  }
}
