import 'package:flutter/material.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
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
