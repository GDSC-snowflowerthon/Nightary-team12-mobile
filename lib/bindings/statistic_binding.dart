import 'package:get/get.dart';
import 'package:nightary/viewModels/statistic/statistic_screen.dart';

import '../viewModels/statistic/fragment/seven_recent_viewmodel.dart';
import '../viewModels/statistic/fragment/thirty_recent_viewmodel.dart';

class StatisticBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel
    Get.put(StatisticViewModel());

    // ChildViewModel
    Get.put(SevenRecentViewModel());
    Get.put(ThirtyRecentViewModel());
  }
}
