import 'package:flutter/material.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/views/base/base_widget.dart';
import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:nightary/utilities/font_system.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _TopPart(),
          _MiddlePart(),
          _BottomPart(),
          SizedBox(height: 130),
        ],
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_home.png";
}

class _TopPart extends BaseWidget<HomeViewModel> {
  const _TopPart();

  @override
  Widget buildView(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();

    return Center(
      child: Card(
        color: Colors.transparent,
        child: Container(
          height: 170,
          width: Get.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              image: AssetImage('assets/images/home_head_card.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20),
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => Text(
                    "${viewModel.userName}님 반가워요.",
                    style: FontSystem.KR20B.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const _BatteryPart(),
              Obx(() {
                String message;
                int hourDifference = viewModel.differenceSleepTime.abs() ~/ 60;
                int minuteDifference = viewModel.differenceSleepTime.abs() % 60;

                if (viewModel.differenceSleepTime > 0) {
                  message =
                      "목표한 시간보다 $hourDifference시간 $minuteDifference분 더 못잤어요.";
                } else if (viewModel.differenceSleepTime < 0) {
                  // 부호를 바꾸어 음수를 양수로 만듭니다.
                  hourDifference = hourDifference.abs();
                  message =
                      "목표한 시간보다 $hourDifference시간 $minuteDifference분 더 잤어요.";
                } else {
                  // minuteDifference가 0인 경우
                  message = "목표한 시간과 정확히 같은 시간을 잤어요.";
                }

                return Text(
                  message,
                  style: FontSystem.KR16R.copyWith(color: Colors.white),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiddlePart extends BaseWidget<HomeViewModel> {
  const _MiddlePart();

  @override
  Widget buildView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        child: Card(
          color: const Color(0xFF0A0A25),
          child: SizedBox(
            height: 170,
            width: Get.width - 40,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Text(
                        "오늘의 건강 브리핑",
                        style: FontSystem.KR20B.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/health_card_moon.png', // 이미지 파일 경로
                            width: 16.0, // 아이콘 크기
                            height: 16.0,
                          ),
                          const SizedBox(width: 4),
                          Obx(
                            () => Text(
                              "${viewModel.todaySleep.value ~/ 60}h ${viewModel.todaySleep.value % 60}m",
                              style: FontSystem.KR20B
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const _CarouselSlider(), // 여기에 추가적인 위젯들이 필요하면 추가
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomPart extends BaseWidget<HomeViewModel> {
  const _BottomPart();

  @override
  Widget buildView(BuildContext context) {
    return Center(
      child: Card(
        color: const Color(0xFF0A0A25),
        child: SizedBox(
          height: 348,
          width: Get.width - 40,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.all(20),
                child: Text(
                  "내가 가진 수면빚",
                  style: FontSystem.KR20B.copyWith(color: Colors.white),
                ),
              ),
              const _MyPieChart(data: [30, 70]),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatteryPart extends StatelessWidget {
  const _BatteryPart();

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();
    return Container(
      margin: const EdgeInsets.all(20),
      child: Obx(
        () => BasedBatteryIndicator(
          status: BasedBatteryStatus(
            value: viewModel.todaySleep.value * 480 ~/ 100,
            type: BasedBatteryStatusType.normal,
          ),
          trackHeight: 40.0,
          trackAspectRatio: 2.2,
          curve: Curves.ease,
          duration: const Duration(seconds: 1),
        ),
      ),
    );
  }
}

class _CarouselSlider extends StatelessWidget {
  const _CarouselSlider();

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();
    return CarouselSlider(
      options: CarouselOptions(
        height: 64.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: [0, 1, 2].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C3C3C),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/images/health_card_icon.png',
                      width: 56.0, // 아이콘 크기
                      height: 56.0,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(
                        () => Text(
                          "${viewModel.healthSentance[i]} 확률이 ${viewModel.healthPercent[i]}% 늘었어요.",
                          style: FontSystem.KR16R.copyWith(color: Colors.white),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
      }).toList(),
    );
  }
}

class _MyPieChart extends BaseWidget<HomeViewModel> {
  final List<double> data;

  const _MyPieChart({required this.data});

  @override
  Widget buildView(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => PieChart(
              PieChartData(
                sections: getSections(data),
                centerSpaceRadius: 100,
                sectionsSpace: 0,
              ),
            ),
          ),
          SizedBox(
            child: Obx(
              () => Text(
                '${viewModel.sleepDebt.value}h',
                style:
                    FontSystem.KR50R.copyWith(color: const Color(0xFF755EBB)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(List<double> values) {
    return [
      PieChartSectionData(
          gradient: const LinearGradient(
            colors: [Color(0xFF32134B), Color(0xFF131C4C)], // 그라데이션 색상
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          value: 100 - viewModel.sleepDebtPercent.toDouble(), // 차트의 절반
          title: '',
          radius: 15),
      PieChartSectionData(
        gradient: const LinearGradient(
          colors: [Color(0xFFE742EB), Color(0xFF3D70F1)], // 그라데이션 색상
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        value: viewModel.sleepDebtPercent.toDouble(), // 차트의 다른 절반
        title: '',
        radius: 15,
      ),
    ];
  }
}

//건강 그래프 출력

//내가 가진 수면 빚
