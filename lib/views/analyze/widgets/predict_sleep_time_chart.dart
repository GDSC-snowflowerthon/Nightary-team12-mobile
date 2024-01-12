import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/analyze/analyze_viewmodel.dart';
import 'package:nightary/views/base/base_widget.dart';
import 'package:nightary/widgets/custom_time_chart/components/view_mode.dart';
import 'package:nightary/widgets/custom_time_chart/time_chart.dart';
import 'package:nightary/repositories/sleep_record_repository.dart';

class PredictSleepTimeChart extends BaseWidget<AnalyzeViewModel> {
  const PredictSleepTimeChart({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Container(
      width: Get.width - 40,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF0D0B26),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "수면 패턴을 지키기 위한 이번주의 시간",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          CustomTimeChart(
            height: 250,
            viewMode: ViewMode.weekly,
            tooltipStart: "취침시간",
            tooltipEnd: "기상시간",
            barColor: const Color(0xFF3D4C70),
            data: viewModel.sleepTimes,
          ),
        ],
      ),
    );
  }
}
