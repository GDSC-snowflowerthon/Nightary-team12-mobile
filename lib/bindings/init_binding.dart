import 'package:get/get.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';
import 'package:nightary/providers/white_noise_local_provider.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/repositories/white_noise_repository.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<SleepRecordLocalProvider>(() => SleepRecordLocalProvider());
    Get.lazyPut<WhiteNoiseLocalProvider>(() => WhiteNoiseLocalProvider());

    // Repositories
    Get.lazyPut<SleepRecordRepository>(() => SleepRecordRepository());
    Get.lazyPut<WhiteNoiseRepository>(() => WhiteNoiseRepository());
  }
}
