import 'package:get/get.dart';
import 'package:nightary/providers/sleep_record_local_provider.dart';
import 'package:nightary/providers/user_local_provider.dart';
import 'package:nightary/providers/white_noise_local_provider.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:nightary/repositories/white_noise_repository.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<UserLocalProvider>(() => UserLocalProvider());
    Get.lazyPut<WhiteNoiseLocalProvider>(() => WhiteNoiseLocalProvider());
    Get.lazyPut<SleepRecordLocalProvider>(() => SleepRecordLocalProvider());

    // Repositories
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<WhiteNoiseRepository>(() => WhiteNoiseRepository());
    Get.lazyPut<SleepRecordRepository>(() => SleepRecordRepository());
  }
}
