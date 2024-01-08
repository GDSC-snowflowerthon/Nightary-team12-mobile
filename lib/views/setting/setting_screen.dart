import 'package:flutter/material.dart';
import 'package:nightary/viewModels/setting/setting_screen.dart';
import 'package:nightary/views/base/base_screen.dart';

class SettingScreen extends BaseScreen<SettingViewModel> {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text(
        'Setting Screen',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundSvgPath => "assets/images/background_setting.png";
}
