import 'package:flutter/material.dart';
import 'package:nightary/viewModels/analyze/analyze_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class AnalyzeScreen extends BaseScreen<AnalyzeViewModel> {
  const AnalyzeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text(
        'Analyze Screen',
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
  String? get backgroundSvgPath => "assets/images/background_analyze.png";
}
