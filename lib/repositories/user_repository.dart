import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:nightary/providers/user_local_provider.dart';

class UserRepository extends GetxService {
  late final UserLocalProvider _provider;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<UserLocalProvider>();
  }

  String? readNickname() {
    return _provider.findNickname();
  }

  int readTargetSleepTime() {
    return _provider.findTargetSleepTime();
  }

  Future<void> writeNickname(String nickname) async {
    await _provider.writeNickname(nickname);
  }
}
