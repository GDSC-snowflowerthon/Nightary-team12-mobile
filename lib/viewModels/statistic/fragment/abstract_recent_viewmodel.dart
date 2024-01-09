import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AbstractRecentViewModel extends GetxController {
  TimeOfDay get averageSleepTime;
  int get changeAverageBattery;
  int get changeLiabilities;
}
