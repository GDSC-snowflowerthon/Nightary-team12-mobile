import 'package:get/get.dart';
import 'package:nightary/viewModels/white_noise/white_noise_viewmodel.dart';

class WhiteNoiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WhiteNoiseViewModel());
  }
}
