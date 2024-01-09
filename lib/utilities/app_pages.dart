import 'package:get/get.dart';
import 'package:nightary/bindings/root_binding.dart';
import 'package:nightary/bindings/white_noise_binding.dart';
import 'package:nightary/utilities/app_routes.dart';
import 'package:nightary/views/root/root_screen.dart';
import 'package:nightary/views/white_noise/white_noise_screen.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding(),
  ),
  GetPage(
    name: Routes.WHITE_NOISE,
    page: () => const WhiteNoiseScreen(),
    binding: WhiteNoiseBinding(),
  ),
];
