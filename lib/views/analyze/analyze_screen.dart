import 'package:nightary/views/analyze/widgets/predict_sleep_time_chart.dart';
import 'package:flutter/material.dart';
import 'package:nightary/viewModels/analyze/analyze_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

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
                      padding: EdgeInsets.only(
                          left: 10, top: 0, right: 0, bottom: 15),
                      child: Text(
                        '수면 패턴 분석',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Column(
                        children: [
                          PredictSleepTimeChart(),
                        ]
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildAnalysisBox(),
                  SizedBox(height: 16),
                  _buildImageBox(),
                  SizedBox(height: 16),
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
      child: const Text(
        '당신의 수면 패턴을 분석해보겠습니다.\n\n1. 수면 시간:\n당신은 대부분 14:00 ~ 16:00 사이에 수면을 시작하며, 20:00 ~ 23:00 사이에 일어나는 것으로 보입니다. 수면 시간은 약 6 ~ 7시간 정도로 유지되고 있습니다.\n\n2. 수면 일관성:\n당신은 대부분 주중과 주말 모두 비슷한 수면 패턴을 보이고 있습니다. 주중과 주말 모두 대체로 비슷한 시간에 수면하고 일어나고 있으며, 수면 시간의 변동이 크지 않은 것으로 보입니다. 이는 수면 일관성이 높은 것으로 평가할 수 있습니다.\n\n3. 예측된 수면 시간:\n다음 5일 동안의 예측된 수면 시간은 대부분 15:58 ~ 16:01 사이에 시작하여 23:41 ~ 23:47 사이에 일어나는 것으로 보입니다. 수면 시간은 약 6시간 40분에서 6시간 50분 정도로 예측됩니다.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
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
      child: const Column(
        children: [
          Text(
            '수면 품질을 향상시키기 위한 조언:\n1. 정해진 시간에 수면하기: 가능하면 매일 동일한 시간에 수면하고 일어나는 것이 좋습니다. 이는 수면 패턴을 안정화시키는 데 도움이 됩니다.\n2. 수면 환경 조성: 조용하고 어두운 환경을 유지하고 침실을 편안하게 만들어주세요. 이는 좋은 수면을 유도하는 데 도움이 됩니다.\n3. 스트레스 관리: 스트레스가 수면에 영향을 미칠 수 있으므로, 스트레스를 효과적으로 관리하는 방법을 찾아보세요. 예를 들어 명상이나 심호흡을 통해 스트레스를 해소할 수 있습니다.\n4. 규칙적인 운동: 매일 일정한 운동을 하는 것도 좋은 수면을 유도하는 데 도움이 됩니다. 하지만 수면 시간과 운동 시간 사이에 충분한 시간 간격을 두는 것이 중요합니다.\n\n이러한 조언들을 따라 수면 품질을 향상시키는 데 도움이 되길 바랍니다. 좋은 수면을 취하면 건강과 기분의 개선에 도움이 될 것입니다.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
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
