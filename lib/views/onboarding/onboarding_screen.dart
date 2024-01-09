import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/viewModels/analyze/analyze_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class OnboardingScreen extends BaseScreen<AnalyzeViewModel> {
  const OnboardingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 0),
          margin: EdgeInsets.only(top: 110, left: 20, right: 20, bottom: 0),
          child: Image.asset('assets/images/text_onboarding.png'),
        ),
        Text(
          "어떤 이름으로 불러드릴까요?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        InputSample(),
        _Button(),

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
        children: <Widget>[
          Container(
            child: TextField(
              cursorColor: Colors.white,
              cursorWidth: 0.5,
              cursorHeight: 20,

              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: '',

                border: UnderlineInputBorder( // 하단에 직선 테두리를 설정합니다.
                  borderSide: BorderSide(color: Colors.white), // 테두리 색상을 하얀색으로 지정합니다.
                ),
                enabledBorder: UnderlineInputBorder( // 텍스트 필드가 활성화되었을 때의 하단 테두리 스타일.
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder( // 텍스트 필드에 포커스가 맞춰졌을 때의 하단 테두리 스타일.
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (String str) {
                setState(() => textContent = textController.text);
              },
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: 300,
          ),
          Container(
            child: Text(
              inputs,
              style: TextStyle(fontSize: 32),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: 300,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({super.key});

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
          onTap: () {
            print('hell');
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