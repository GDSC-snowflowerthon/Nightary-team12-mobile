import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/utilities/font_system.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';
import 'package:nightary/views/base/base_widget.dart';

class LiabilityChart<T extends AbstractRecentViewModel> extends BaseWidget<T> {
  const LiabilityChart({super.key});

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
          // Widget Title
          Text(
            "최근 ${viewModel.runtimeType.toString() == "SevenRecentViewModel" ? "7" : "30"}번의 수면 빚 변화",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // 여백
          const SizedBox(height: 20),

          // Chart
          AspectRatio(
            aspectRatio: 1.50,
            child: LineChart(
              LineChartData(
                // 차트 배경색 설정
                backgroundColor: Colors.transparent,

                // 격자 설정
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: drawingHorizontalLine,
                  getDrawingVerticalLine: drawingVerticalLine,
                ),

                // 차트 축 표기 설정
                titlesData: FlTitlesData(
                  show: true,
                  // 차트 축 표기 설정 - 왼쪽
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  // 차트 축 표기 설정 - 오른쪽
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  // 차트 축 표기 설정 - 오른쪽
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: leftTitleWidgets,
                      reservedSize: 35,
                    ),
                  ),

                  // 차트 축 표기 설정 - 아래쪽
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                ),

                // 차트 외곽선 설정
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d)),
                ),

                // 차트 데이터 설정
                minX: viewModel.liabilityChartRange["minX"]!,
                maxX: viewModel.liabilityChartRange["maxX"]!,
                minY: viewModel.liabilityChartRange["minY"]!,
                maxY: viewModel.liabilityChartRange["maxY"]!,
                lineBarsData: [
                  LineChartBarData(
                    spots: viewModel.liabilities,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: viewModel.gradientColors,
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: viewModel.gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  FlLine drawingHorizontalLine(double value) {
    return FlLine(
      color: value % 2 != 0 ? Colors.transparent : const Color(0x44757575),
      strokeWidth: 1,
    );
  }

  FlLine drawingVerticalLine(double value) {
    return const FlLine(
      color: Color(0x44757575),
      strokeWidth: 1,
      dashArray: [4],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: FontSystem.KR14R.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 2 != 0) {
      return const SizedBox();
    }

    return Text(
      "${value.toInt().toString()}h",
      style: FontSystem.KR14R.copyWith(color: Colors.white),
      textAlign: TextAlign.right,
    );
  }
}
