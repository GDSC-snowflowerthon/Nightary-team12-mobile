import 'package:flutter/material.dart';
import 'package:nightary/viewModels/statistic/fragment/abstract_recent_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class RecentFragment<T extends AbstractRecentViewModel> extends BaseScreen<T> {
  const RecentFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          averageSleepTime(),
        ],
      ),
    );
  }

  // Widget
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
}
