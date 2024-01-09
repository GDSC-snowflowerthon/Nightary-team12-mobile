import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';

class SevenRecentViewModel extends AbstractRecentViewModel {
  late final Rx<TimeOfDay> _averageSleepTime;

  @override
  TimeOfDay get averageSleepTime => _averageSleepTime.value;

  @override
  void onInit() {
    super.onInit();

    _averageSleepTime = const TimeOfDay(hour: 5, minute: 0).obs;
  }
}
