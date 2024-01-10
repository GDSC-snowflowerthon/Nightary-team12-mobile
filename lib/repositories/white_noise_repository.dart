import 'package:get/get.dart';
import 'package:nightary/providers/white_noise_local_provider.dart';

class WhiteNoiseRepository extends GetxService {
  late final WhiteNoiseLocalProvider _provider;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<WhiteNoiseLocalProvider>();
  }
}
