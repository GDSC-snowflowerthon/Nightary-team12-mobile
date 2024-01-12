import 'package:nightary/utilities/font_system.dart';
import 'package:nightary/views/analyze/widgets/predict_sleep_time_chart.dart';
import 'package:flutter/material.dart';
import 'package:nightary/viewModels/analyze/analyze_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:get/get.dart';

class AnalyzeScreen extends BaseScreen<AnalyzeViewModel> {
  const AnalyzeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 0, right: 0, bottom: 15),
                      child: const Text(
                        '수면 패턴 분석',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: const Column(
                        children: [
                          PredictSleepTimeChart(),
                        ]
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildAnalysisBox(),
                  const SizedBox(height: 20),
                  _buildImageBox(),
                  const SizedBox(height: 20),
                  _buildFeedbackBox(),
                ],
              ),
            ),
            const SizedBox(height: 110),
          ],
        )
        ,
      )
      ,
    );
  }
  Widget _buildAnalysisBox() {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(() {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Text(
          viewModel.analysisText,
          style: FontSystem.KR16M.copyWith(color: Colors.white),
        );
      }),
    );
  }

  Widget _buildImageBox() {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/images/analyze.png'),
        )
    );
  }

  Widget _buildFeedbackBox() {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Obx(() {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Text(
              viewModel.feedbackText,
              style: FontSystem.KR16M.copyWith(color: Colors.white),
            );
          })
        ],
      ),
    );
  }


  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_analyze.png";
}
