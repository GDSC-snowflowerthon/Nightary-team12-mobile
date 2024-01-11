import 'package:get/get.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';

class SleepRecordRepository extends GetxService {
  late final SleepRecordLocalProvider _provider;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<SleepRecordLocalProvider>();
  }
}
