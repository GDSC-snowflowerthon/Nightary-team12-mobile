import 'package:flutter/material.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/views/base/base_widget.dart';
import 'package:nightary/views/statistic/widgets/average_sleep_time.dart';
import 'package:nightary/views/statistic/widgets/liability_chart.dart';
import 'package:nightary/views/statistic/widgets/sleep_time_chart.dart';
import 'package:nightary/views/statistic/widgets/statistic_tile.dart';

class RecentFragment<T extends AbstractRecentViewModel> extends BaseScreen<T> {
  const RecentFragment({super.key});

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => false;

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AverageSleepTime<T>(),
            const SizedBox(height: 20),
            statisticTiles(),
            const SizedBox(height: 20),
            SleepTimeChart<T>(),
            const SizedBox(height: 20),
            LiabilityChart<T>(),
            const SizedBox(height: 130),
          ],
        ),
      ),
    );
  }

  Widget statisticTiles() => Row(
        children: [
          StatisticTile<T>(isBattery: true),
          const SizedBox(width: 20),
          StatisticTile<T>(isBattery: false),
        ],
      );
}
