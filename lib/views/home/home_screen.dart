import 'package:flutter/material.dart';
import 'package:nightary/viewModels/home/home_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }

  @override
  bool get wrapWithSafeArea => false;
}
