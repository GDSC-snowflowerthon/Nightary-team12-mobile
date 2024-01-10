import 'package:flutter/material.dart';
import 'package:nightary/viewModels/setting/setting_screen.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/utilities/font_system.dart';
import 'package:get/get.dart';

class SettingScreen extends BaseScreen<SettingViewModel> {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 122, bottom: 93),
            child: Center(
              child: Image.asset('assets/images/setting_logo.png'),
            ),
          ),
          Container(
            width: Get.width - 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF17191D),
                  const Color(0xFF17191D),
                  Colors.black.withOpacity(0.0),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/setting_people.png'),
                const SizedBox(width: 16),
                Text(
                  "손형준",
                  style: FontSystem.KR18B.copyWith(color: Colors.white),
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

  const _CardButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: Get.width - 60,
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFF2B2B2B)),
      child: Container(
        margin: const EdgeInsets.only(top: 17, left: 20),
        child: Text(
          text,
          style: FontSystem.KR16B.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
