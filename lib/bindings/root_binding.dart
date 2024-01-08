import 'package:get/get.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/viewModels/root/root_viewmodel.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());

    // ChildViewModel is singleton
    Get.put(HomeViewModel());
  }
}
