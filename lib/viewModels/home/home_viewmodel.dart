import 'package:get/get.dart';
import '../../models/User.dart';

class HomeViewModel extends GetxController {
  var userName = "손형준".obs;

  void setUserName(String newName) {
    userName.value = newName;
  }
}