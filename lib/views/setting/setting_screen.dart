import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nightary/apps/factory/shared_preference_factory.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/utilities/font_system.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/setting/setting_viewmodel.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:time_range_picker/time_range_picker.dart';

part 'setting_view.dart';

class SettingScreen extends BaseScreen<SettingViewModel> {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 70, bottom: 70),
            child: Center(
              child: Image.asset('assets/images/setting_logo.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
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
                Obx(
                  () => Header(
                    goalHour: controller.goalHour.value,
                    goalMin: controller.goalMinute.value,
                    nickname: controller.nickname.value,
                  ),
                ),
                const SizedBox(height: 14),
                CardButton(
                  text: "하루 목표 수면시간 설정하기",
                  onTap: () => controller.onTapSetSleepTime(context),
                ),
                const SizedBox(height: 14),
                CardButton(
                  text: "알림 보낼 시간 설정하기",
                  onTap: () => controller.onTapSetAlarm(context),
                ),
                const SizedBox(height: 14),
                CardButton(text: "이용약관", onTap: controller.onTapTerm),
                const SizedBox(height: 14),
                CardButton(text: "회원탈퇴", onTap: controller.onTapWithdrawal),
              ],
            ),
          ),
          const SizedBox(height: 130),
        ],
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_setting.png";
}
