import 'package:get/get.dart';
import 'package:nightary/utilities/app_routes.dart';

class RootViewModel extends GetxController {
  late final RxInt _selectedIndex;

  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();

    _selectedIndex = 0.obs;
  }

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  void onTapBed() {
    Get.toNamed(Routes.WHITE_NOISE);
  }
}
