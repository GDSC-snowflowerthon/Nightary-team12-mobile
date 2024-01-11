import 'package:get/get.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';
import 'package:nightary/utilities/log_system.dart';

class SleepRecordRepository extends GetxService {
  late final SleepRecordLocalProvider _provider;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<SleepRecordLocalProvider>();
  }

  Future<Map<String, dynamic>> readSleepRecords() async {
    List<dynamic> sleepRecords = await _provider.readSleepRecords();

    LogSystem.logger.i("${sleepRecords.length} sleep records found");

    for (var sleepRecord in sleepRecords) {
      LogSystem.logger.i(sleepRecord.toString());
    }

    return {
      "sleepRecords": null,
    };
  }
}
