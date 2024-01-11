import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:nightary/repositories/user_repository.dart';

class OnboardingViewModel extends GetxController {
  late final UserRepository _repository;

  late final TextEditingController _nicknameController;

  TextEditingController get nicknameController => _nicknameController;

  @override
  void onInit() {
    super.onInit();
    _repository = Get.find<UserRepository>();
    _nicknameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameController.dispose();
  }

  Future<bool> onTapContinue() async {
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
      return false;
    }

    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      now.subtract(const Duration(days: 10)),
      now,
      types,
    );

    // text 검증 로직
    // 추가 해야함
    if (_nicknameController.text.isEmpty) {
      return false;
    }

    // text 저장
    _repository.writeNickname(_nicknameController.text);

    for (var data in healthData) {
      print(data);
    }

    return true;
  }
}
