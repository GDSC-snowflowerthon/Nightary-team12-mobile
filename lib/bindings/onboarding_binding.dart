import 'package:get/get.dart';
import 'package:nightary/viewModels/onboarding/onboarding_viewmodel.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingViewModel>(() => OnboardingViewModel());
  }
}
