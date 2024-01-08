import 'package:flutter/material.dart';
import 'package:nightary/viewModels/statistic/statistic_screen.dart';
import 'package:nightary/views/base/base_screen.dart';

class StatisticScreen extends BaseScreen<StatisticViewModel> {
  const StatisticScreen({super.key});

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
  String? get backgroundImagePath => "assets/images/background_statistic.png";
}
