import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/repositories/user_repository.dart';
import 'package:nightary/utilities/app_routes.dart';

class NameMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    UserRepository userRepository = Get.find<UserRepository>();

    if (userRepository.readNickname() == null) {
      return const RouteSettings(name: Routes.ONBOARDING);
    }

    return null;
  }
}
