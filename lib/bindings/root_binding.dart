import 'package:get/get.dart';
import 'package:nightary/bindings/statistic_binding.dart';
import 'package:nightary/viewModels/analyze/analyze_viewmodel.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/viewModels/root/root_viewmodel.dart';
import 'package:nightary/viewModels/setting/setting_viewmodel.dart';
import 'package:nightary/viewModels/statistic/statistic_screen.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());

    Get.lazyPut(() => HomeViewModel());
    StatisticBinding().dependencies();
    Get.lazyPut(() => AnalyzeViewModel());
    Get.lazyPut(() => SettingViewModel());
  }
}
