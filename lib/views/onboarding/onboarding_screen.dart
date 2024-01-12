import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/utilities/app_routes.dart';
import 'package:nightary/viewModels/onboarding/onboarding_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/utilities/font_system.dart';
import 'package:nightary/views/base/base_widget.dart';

class OnboardingScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 0),
          margin:
              const EdgeInsets.only(top: 110, left: 20, right: 20, bottom: 0),
          child: Image.asset('assets/images/text_onboarding.png'),
        ),
        Text(
          "어떤 이름으로 불러드릴까요?",
          style: FontSystem.KR18B.copyWith(color: Colors.white),
        ),
        _InputSample(),
        const SizedBox(height: 80),
        _ContinueButton(),
      ],
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_analyze.png";
}

class _InputSample extends BaseWidget<OnboardingViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      width: Get.width * 0.7,
      child: Center(
        child: TextFormField(
          cursorColor: Colors.white,
          cursorWidth: 0.5,
          cursorHeight: 20,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
          controller: viewModel.nicknameController,
          decoration: const InputDecoration(
            hintText: '',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends BaseWidget<OnboardingViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return Container(
      width: Get.width * 0.75,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8A1FD), Color(0xFFB97BFC)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {
            FocusScope.of(context).unfocus(),
            viewModel.onTapContinue().then(
                  (value) => {
                    if (value)
                      {Get.offAllNamed(Routes.ROOT)}
                    else
                      {
                        Get.snackbar(
                          "부적절한 이름",
                          "이름을 입력해주세요",
                          snackPosition: SnackPosition.TOP,
                          colorText: Colors.white,
                          duration:
                              const Duration(seconds: 1, milliseconds: 500),
                        )
                      }
                  },
                ),
          },
          borderRadius: BorderRadius.circular(30),
          child: const Center(
            child: Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
