import 'package:flutter/material.dart';
import 'package:nightary/viewModels/white_noise/white_noise_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class WhiteNoiseScreen extends BaseScreen<WhiteNoiseViewModel> {
  const WhiteNoiseScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text(
        'White Noise Screen',
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
  String? get backgroundImagePath => "assets/images/background_statistic.png";
}
