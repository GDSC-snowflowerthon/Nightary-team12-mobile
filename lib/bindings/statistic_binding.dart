import 'package:get/get.dart';
import 'package:nightary/viewModels/statistic/fragment/seven_recent_viewmodel.dart';
import 'package:nightary/viewModels/statistic/fragment/thirty_recent_viewmodel.dart';
import 'package:nightary/viewModels/statistic/statistic_screen.dart';

class StatisticBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel
    Get.lazyPut(() => StatisticViewModel());

    // ChildViewModel
    Get.lazyPut(() => SevenRecentViewModel());
    Get.lazyPut(() => ThirtyRecentViewModel());
  }
}
