import 'package:get/get.dart';
import 'package:nightary/bindings/onboarding_binding.dart';
import 'package:nightary/bindings/root_binding.dart';
import 'package:nightary/bindings/white_noise_binding.dart';
import 'package:nightary/middlewares/name_middlewares.dart';
import 'package:nightary/utilities/app_routes.dart';
import 'package:nightary/views/onboarding/onboarding_screen.dart';
import 'package:nightary/views/root/root_screen.dart';
import 'package:nightary/views/white_noise/white_noise_screen.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding(),
    middlewares: [NameMiddleware()],
  ),
  GetPage(
    name: Routes.WHITE_NOISE,
    page: () => const WhiteNoiseScreen(),
    binding: WhiteNoiseBinding(),
  ),
  GetPage(
    name: Routes.ONBOARDING,
    page: () => const OnboardingScreen(),
    binding: OnboardingBinding(),
  ),
];
