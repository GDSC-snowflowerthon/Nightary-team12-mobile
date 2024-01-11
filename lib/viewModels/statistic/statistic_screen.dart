import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController _tabController;

  TabController get tabController => _tabController;

  @override
  void onInit() {
    super.onInit();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
