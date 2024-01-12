import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/repositories/user_repository.dart';

class OnboardingViewModel extends GetxController {
  late final UserRepository _userRepository;
  late final SleepRecordRepository _sleepRecordRepository;
  late final HealthFactory _health;

  static final List<HealthDataType> types = [
    HealthDataType.SLEEP_IN_BED,
    // HealthDataType.SLEEP_ASLEEP,
    // HealthDataType.SLEEP_AWAKE,
  ];

  late final TextEditingController _nicknameController;

  TextEditingController get nicknameController => _nicknameController;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _userRepository = Get.find<UserRepository>();
    _sleepRecordRepository = Get.find<SleepRecordRepository>();
    _health = HealthFactory(useHealthConnectIfAvailable: true);

    // Initialize
    _nicknameController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    _nicknameController.dispose();
    focusNode.unfocus();
    focusNode.dispose();
  }

  Future<bool> onTapContinue() async {
    focusNode.unfocus();
    /**
     * text 검증 로직
     */
    if (_nicknameController.text.isEmpty) {
      return false;
    }

    await _userRepository.writeNickname(_nicknameController.text);

    /**
     * healthkit 권한 요청
     * 권한이 없으면 false 반환
     * 권한이 있으면 데이터를 가져와서 저장
     */
    final now = DateTime.now();

    bool requested = await _health.requestAuthorization(types);
    if (!requested) {
      return false;
    }

    List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
      now.subtract(const Duration(days: 180)),
      now,
      types,
    );

    if (healthData.isNotEmpty) {
      await _sleepRecordRepository.saveSleepRecordsByHealthData(
          healthData.reversed.map((e) => e.toJson()).toList(),
          _userRepository.readTargetSleepTime());
    }

    return true;
  }
}
