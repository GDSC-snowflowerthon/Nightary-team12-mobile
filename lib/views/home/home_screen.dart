import 'package:flutter/material.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/views/base/base_widget.dart';
import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:nightary/repositories/temp.dart';
import 'package:nightary/utilities/font_system.dart';
import 'dart:ui';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    Get.put(HomeViewModel());
    return SingleChildScrollView(
      child: Column(
        children: [
          _TopPart(),
          _MiddlePart(),
          _BottomPart(),
        ],
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_home.png";
}

class _TopPart extends BaseWidget<HomeViewModel> {
  const _TopPart({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();

    return Center(
      child: Card(
        color: Colors.transparent,
        child: Container(
            height: 170,
            width: Get.width-40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage('assets/images/home_head_card.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      "${viewModel.userName.value}님 반가워요.",
                      style: FontSystem.KR20B.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                _BatteryPart(),
                Obx(() {
                  String message;
                  int minuteDifference = viewModel.minuteDifference.value;
                  int hourDifference = viewModel.hourDifference.value;

                  if (hourDifference > 0) {
                    message =
                        "목표한 시간보다 $hourDifference시간 $minuteDifference분 더 못잤어요.";
                  } else if (hourDifference < 0) {
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
                // Container(
                //   height: 5,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         viewModel.addSleepDebt(10);
                //       },
                //       child: Text('zz')),
                // )
              ],
            )),
      ),
    );
  }
}

class _MiddlePart extends BaseWidget<HomeViewModel> {
  const _MiddlePart({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        child: Card(
          color: Color(0xFF0A0A25),
          child: Container(
            height: 170,
            width: Get.width-40,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "오늘의 건강 브리핑",
                        style: FontSystem.KR20B.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/health_card_moon.png', // 이미지 파일 경로
                            width: 16.0, // 아이콘 크기
                            height: 16.0,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${viewModel.sleepHour.value}h ${viewModel.sleepMin.value}m",
                            style:
                                FontSystem.KR20B.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                _CarouselSlider(), // 여기에 추가적인 위젯들이 필요하면 추가
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomPart extends BaseWidget<HomeViewModel> {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Center(
      child: Card(
        color: Color(0xFF0A0A25),
        child: Container(
          height: 348,
          width: Get.width - 40,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(20),
                child: Text(
                  "내가 가진 수면빚",
                  style: FontSystem.KR20B.copyWith(color: Colors.white),
                ),
              ),
              _MyPieChart(data: [30, 70]),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatteryPart extends StatelessWidget {
  const _BatteryPart({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();
    return Container(
      margin: EdgeInsets.all(20),
      child: Obx(
        () => BasedBatteryIndicator(
          status: BasedBatteryStatus(
            value: viewModel.batteryPercentage(),
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
  const _CarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 64.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Color(0xFF3C3C3C),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 4),
                    Image.asset(
                      'assets/images/health_card_icon.png',
                      width: 56.0, // 아이콘 크기
                      height: 56.0,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        sentences[i],
                        style: FontSystem.KR16R.copyWith(color: Colors.white),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

class _MyPieChart extends StatefulWidget {
  final List<double> data;

  const _MyPieChart({Key? key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyPieChartState();
}

class MyPieChartState extends State<_MyPieChart> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<HomeViewModel>();
    return Container(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => PieChart(
              PieChartData(
                sections: getSections(widget.data),
                centerSpaceRadius: 100,
                sectionsSpace: 0,
              ),
            ),
          ),
          Container(
            child: Obx(
              () => Text(
                '${viewModel.sleepDebt.value}h',
                style: FontSystem.KR50R.copyWith(color: Color(0xFF755EBB)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(List<double> values) {
    final viewModel = Get.find<HomeViewModel>();
    final isNotEmpty = values.isNotEmpty;
    final total = isNotEmpty ? values.reduce((a, b) => a + b) : 1;

    return [
      PieChartSectionData(
          gradient: LinearGradient(
            colors: [Color(0xFF32134B), Color(0xFF131C4C)], // 그라데이션 색상
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          value: 100 - viewModel.sleepDebtPercent.toDouble(), // 차트의 절반
          title: '',
          radius: 15),
      PieChartSectionData(
        gradient: LinearGradient(
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
