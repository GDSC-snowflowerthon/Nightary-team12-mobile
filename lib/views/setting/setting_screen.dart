import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/utilities/font_system.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/setting/setting_viewmodel.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';

class SettingScreen extends BaseScreen<SettingViewModel> {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final homeViewModel = Get.find<HomeViewModel>();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 122, bottom: 93),
          child: Center(
            child: Image.asset('assets/images/setting_logo.png'),
          ),
        ),
        Expanded(
          child: Container(
              width: Get.width - 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF17191D),
                    Color(0xFF17191D),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
              child: Column(
                children: [
                  _Header(),
                  SizedBox(
                    height: 25,
                  ),
                  _CardButton(
                      text: "하루 목표 수면시간 설정하기",
                      onTap: () {
                        showCupertinoDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: _SetSleepTime(),
                            );
                          },
                        );
                      }),
                  _CardButton(
                      text: "알림 보낼 시간 설정하기",
                      onTap: () {
                        showCupertinoDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: _SetNoticeTime(),
                            );
                          },
                        );
                      }),
                  _CardButton(text: "이용약관", onTap: () {}),
                  _CardButton(text: "회원탈퇴", onTap: () {}),
                ],
              ),
            ),
            child: Column(
              children: [
                _Header(controller.onTapProfile),
                const SizedBox(height: 25),
                const _CardButton(text: "잘 시간 설정하기"),
                const _CardButton(text: "알림 보낼 시간 설정하기"),
                const _CardButton(text: "이용약관"),
                const _CardButton(text: "회원탈퇴"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_setting.png";
}

class _Header extends StatelessWidget {
  final Function() onTap;
  const _Header(this.onTap);

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Get.find<HomeViewModel>();
    return Container(
      margin: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/setting_people.png'),
              SizedBox(
                width: 16,
              ),
              Text(
                "손형준",
                style: FontSystem.KR18B.copyWith(color: Colors.white),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/setting_sun_icon.png',
                  width: 25.0,
                  height: 25.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 4),
                Obx(
                  () => Text(
                    "${homeViewModel.goalHour.value}h ${homeViewModel.goalMin.value}m",
                    style: FontSystem.KR20B.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/setting_sun_icon.png',
                    width: 25.0,
                    height: 25.0,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "6h 00m",
                    style: FontSystem.KR20B.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  _CardButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 여기에서 콜백 함수를 사용
      borderRadius: BorderRadius.circular(30),
      child: Container(
        margin: EdgeInsets.only(bottom: 7, top: 7),
        width: Get.width - 60,
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Color(0xFF2B2B2B)),
        child: Container(
          margin: EdgeInsets.only(top: 17, left: 20),
          child: Text(
            text,
            style: FontSystem.KR16B.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _SetSleepTime extends StatelessWidget {
  const _SetSleepTime({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Get.find<HomeViewModel>();
    return Container(
      height: 300.0,
      color: Colors.white,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        use24hFormat: true,
        initialDateTime: DateTime(2020, 1, 1, 6),
        // 오전 6시부터 선택 가능하도록 초기값 설정
        minimumDate: DateTime(2020, 1, 1, 6),
        // 오전 6시부터
        maximumDate: DateTime(2020, 1, 1, 10),
        // 오전 10시까지
        onDateTimeChanged: (DateTime value) {
          homeViewModel.setGoalHour(value.hour);
          homeViewModel.setGoalMin(value.minute);
        },
      ),
    );
  }
}

class _SetNoticeTime extends StatelessWidget {
  const _SetNoticeTime({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Get.find<HomeViewModel>();
    final settingViewModel = Get.find<SettingViewModel>();
    return Container(
      height: 300.0,
      color: Colors.white,
      child:  CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (DateTime value) {
            settingViewModel.noticeHour = value.hour as RxInt;
            settingViewModel.noticeMin = value.minute as RxInt;
          },
        ),
    );
  }
}

// void showSleepTimeDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("수면시간 설정"),
//         content: Text("6시간~10시간 사이 목표 수면시간을 선택해주세요"),
//         actions: <Widget>[
//           TextButton(
//             child: Text("확인"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
