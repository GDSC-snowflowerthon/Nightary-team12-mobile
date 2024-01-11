import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:nightary/utilities/app_routes.dart';

class OnboardingViewModel extends GetxController {
  void onTapContinue() async {
    final now = DateTime.now();
    HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

    final List<HealthDataType> types = [
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_REM,
    ];

    bool requested = await health.requestAuthorization(types);
    if (!requested) {
      return;
    }

    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      now.subtract(const Duration(days: 10)),
      now,
      types,
    );
    for (var data in healthData) {
      print(data);
    }

    Get.offAllNamed(Routes.ROOT);
  }
}
