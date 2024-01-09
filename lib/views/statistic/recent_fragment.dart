import 'package:flutter/material.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:time_chart/time_chart.dart';

class RecentFragment<T extends AbstractRecentViewModel> extends BaseScreen<T> {
  const RecentFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          averageSleepTime(),
          const SizedBox(height: 20),
          informationTiles(context),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF0D0B26),
            ),
            child: TimeChart(
              data: [
                DateTimeRange(
                  start: DateTime(2021, 2, 24, 23, 15),
                  end: DateTime(2021, 2, 25, 7, 30),
                ),
                DateTimeRange(
                  start: DateTime(2021, 2, 22, 1, 55),
                  end: DateTime(2021, 2, 22, 9, 12),
                ),
                DateTimeRange(
                  start: DateTime(2021, 2, 20, 0, 25),
                  end: DateTime(2021, 2, 20, 7, 34),
                ),
                DateTimeRange(
                  start: DateTime(2021, 2, 17, 21, 23),
                  end: DateTime(2021, 2, 18, 4, 52),
                ),
                DateTimeRange(
                  start: DateTime(2021, 2, 13, 6, 32),
                  end: DateTime(2021, 2, 13, 13, 12),
                ),
                DateTimeRange(
                  start: DateTime(2021, 2, 1, 9, 32),
                  end: DateTime(2021, 2, 1, 15, 22),
                ),
                DateTimeRange(
                  start: DateTime(2021, 1, 22, 12, 10),
                  end: DateTime(2021, 1, 22, 16, 20),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Container(
          //   width: MediaQuery.of(context).size.width - 40,
          //   height: 300,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: const Color(0xFF0D0B26),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget averageSleepTime() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 동그란 색깔 있는 원
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: viewModel.averageSleepTime.hour >= 7
                        ? const [
                            Color(0xFF43E97B),
                            Color(0xFF38F9D7),
                          ]
                        : const [
                            Color(0xFFFFA78F),
                            Color(0xFFF23E2C),
                          ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "평균 취침시간",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "${viewModel.averageSleepTime.hour}h ${viewModel.averageSleepTime.minute}m",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  Widget informationTiles(BuildContext context) => Row(
        children: [
          roundTile(
            context: context,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${viewModel.changeAverageBattery.abs()} %",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "최근 ${viewModel.runtimeType.toString() == "SevenRecentViewModel" ? "7" : "30"}번의 수면 동안",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  changeAverageBatteryText(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          roundTile(
            context: context,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${viewModel.changeLiabilities.abs()} h",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "최근 ${viewModel.runtimeType.toString() == "SevenRecentViewModel" ? "7" : "30"}번의 수면 동안",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  changeLiabilitiesText(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      );

  Widget roundTile({required BuildContext context, required Widget widget}) =>
      Container(
        width: (MediaQuery.of(context).size.width - 60) * 0.5,
        height: (MediaQuery.of(context).size.width - 60) * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF0D0B26),
        ),
        child: widget,
      );

  String changeAverageBatteryText() {
    if (viewModel.changeAverageBattery > 0) {
      return "평균 충전량이 증가했어요";
    } else if (viewModel.changeAverageBattery < 0) {
      return "평균 충전량이 감소했어요";
    } else {
      return "평균 충전량이 변하지 않았어요";
    }
  }

  String changeLiabilitiesText() {
    if (viewModel.changeLiabilities > 0) {
      return "수면 빚이 증가했어요";
    } else if (viewModel.changeLiabilities < 0) {
      return "수면 빚이 감소했어요";
    } else {
      return "수면 빚이 변하지 않았어요";
    }
  }
}
