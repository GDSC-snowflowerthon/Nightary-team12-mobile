import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/root/root_viewmodel.dart';
import 'package:nightary/views/base/base_widget.dart';

class CustomBottomNavigationBar extends BaseWidget<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 65,
            color: const Color(0xFF0D0B26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavigationBarItem(
                  index: 0,
                  size: 24,
                  svgPath: 'assets/icons/home.svg',
                ),
                _buildBottomNavigationBarItem(
                  index: 1,
                  size: 30,
                  svgPath: 'assets/icons/chart.svg',
                ),
                const SizedBox(width: 70),
                _buildBottomNavigationBarItem(
                  index: 2,
                  size: 24,
                  svgPath: 'assets/icons/search.svg',
                ),
                _buildBottomNavigationBarItem(
                  index: 3,
                  size: 28,
                  svgPath: 'assets/icons/setting.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem({
    required int index,
    required double size,
    required String svgPath,
  }) =>
      Expanded(
        child: SvgPicture.asset(
          svgPath,
          height: size,
          colorFilter: viewModel.selectedIndex == index
              ? const ColorFilter.mode(Color(0xFFD097F4), BlendMode.srcATop)
              : const ColorFilter.mode(Color(0xFF67686D), BlendMode.srcATop),
        ),
      );
}
