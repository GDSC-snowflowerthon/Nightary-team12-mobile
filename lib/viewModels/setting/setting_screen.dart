import 'package:get/get.dart';
import 'package:nightary/utilities/app_routes.dart';

class SettingViewModel extends GetxController {
  void onTapProfile() {
    Get.toNamed(Routes.ONBOARDING);
  }
}
