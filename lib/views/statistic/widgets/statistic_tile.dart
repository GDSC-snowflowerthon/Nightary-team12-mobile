import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';
import 'package:nightary/views/base/base_widget.dart';

class StatisticTile<T extends AbstractRecentViewModel> extends BaseWidget<T> {
  const StatisticTile({
    super.key,
    required this.isBattery,
  });

  final bool isBattery;

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => viewModel.isLoading
          ? Container()
          : roundTile(
              context: context,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isBattery
                        ? "${viewModel.changeAverageBattery.abs()} %"
                        : "${viewModel.changeLiabilities.abs()} h",
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
                    isBattery
                        ? changeAverageBatteryText()
                        : changeLiabilitiesText(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
    );
  }

  Widget roundTile({required BuildContext context, required Widget widget}) =>
      Container(
        width: (Get.width - 60) * 0.5,
        height: (Get.width - 60) * 0.5,
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
