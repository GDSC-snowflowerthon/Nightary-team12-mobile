import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AbstractRecentViewModel extends GetxController {
  List<Color> gradientColors = const [
    Color(0xFF477FFF),
    Color(0xFF39AFFD),
  ];

  TimeOfDay get averageSleepTime;
  int get changeAverageBattery;
  int get changeLiabilities;
  List<DateTimeRange> get sleepTimes;
  List<FlSpot> get liabilities;
  Map<String, double> get liabilityChartRange;
}
