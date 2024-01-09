import 'package:flutter/material.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/views/base/base_widget.dart';
import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        _TopPart(),
        _MiddlePart(),
        _BottomPart(),
      ],
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
    return Center(
      child: Card(
        color: Colors.transparent,
        child: Container(
            height: 170,
            width: 394,
            decoration: BoxDecoration(
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
                  child: Text(
                    "손형준님 반가워요.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                _BatteryPart(),
                Text(
                  "목표한 시간보다 3시간 더 못잤어요.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
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
    return Center(
      child: Card(
        color: Colors.black,
        child: Container(
          height: 170,
          width: 394,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "오늘의 건강 브리핑",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        
                      ),
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
                          "5h 32m",
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
    );
  }
}

class _BottomPart extends BaseWidget<HomeViewModel> {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          height: 60, // 카드의 높이를 60으로 설정
          width: double.infinity, // 카드의 너비를 최대로 설정
          child: Center(
            child: Text(
              '여기에 텍스트를 입력하세요',
              style: TextStyle(fontSize: 20),
            ),
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
    return Container(
      margin: EdgeInsets.all(20),
      child: BasedBatteryIndicator(
        status: BasedBatteryStatus(
          value: 80,
          type: BasedBatteryStatusType.normal,
        ),
        trackHeight: 40.0,
        trackAspectRatio: 2.2,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _CarouselSlider extends StatelessWidget {
  const _CarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 64.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Color(0xFF3C3C3C),
                borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 4),
                    Image.asset(
                      'assets/images/health_card_icon.png', // 이미지 파일 경로
                      width: 56.0, // 아이콘 크기
                      height: 56.0,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "심장병확률이 2.5% 늘어났어요.",
                      style: TextStyle(
                        color: Colors.white,
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
