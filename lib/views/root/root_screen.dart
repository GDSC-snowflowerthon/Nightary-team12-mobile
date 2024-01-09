import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nightary/views/analyze/analyze_screen.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/views/home/home_screen.dart';
import 'package:nightary/views/root/custom_bottom_navigation_bar.dart';
import 'package:nightary/views/setting/setting_screen.dart';
import 'package:nightary/views/statistic/statistic_screen.dart';

import '../../viewModels/root/root_viewmodel.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => IndexedStack(
        index: viewModel.selectedIndex,
        children: const [
          HomeScreen(),
          StatisticScreen(),
          AnalyzeScreen(),
          SettingScreen(),
        ],
      ),
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return const CustomBottomNavigationBar();
  }

  @override
  Widget? get buildFloatingActionButton => Container(
        width: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8A1FD),
              Color(0xFFD097F4),
              Color(0xFF6980FD),
            ],
            stops: [0, 0.5, 1],
          ),
        ),
        child: FloatingActionButton.large(
          onPressed: controller.onTapBed,
          elevation: 0,
          highlightElevation: 2,
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(
            'assets/icons/bed.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
      );

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  Color? get unSafeAreaColor => const Color(0xFF0D0B26);

  @override
  bool get setTopOuterSafeArea => false;
}
