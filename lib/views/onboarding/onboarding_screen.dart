import 'package:flutter/material.dart';
import 'package:nightary/viewModels/onboarding/onboarding_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/utilities/font_system.dart';

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
        const InputSample(),
        _Button(controller.onTapContinue),
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

class InputSample extends StatefulWidget {
  const InputSample({super.key});

  @override
  State createState() => InputSampleState();
}

class InputSampleState extends State<InputSample> {
  String inputs = '';
  TextEditingController textController = TextEditingController();
  String textContent = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: 300,
            child: TextField(
              cursorColor: Colors.white,
              cursorWidth: 0.5,
              cursorHeight: 20,
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
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
              onChanged: (String str) {
                setState(() => textContent = textController.text);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: 300,
            child: Text(
              inputs,
              style: const TextStyle(fontSize: 32),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Function() onTap;
  const _Button(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338,
      height: 54,
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
          onTap: onTap,
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
