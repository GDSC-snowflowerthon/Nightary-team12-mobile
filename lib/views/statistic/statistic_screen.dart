import 'package:flutter/material.dart';
import 'package:nightary/viewModels/statistic/fragment/seven_recent_viewmodel.dart';
import 'package:nightary/viewModels/statistic/fragment/thirty_recent_viewmodel.dart';
import 'package:nightary/viewModels/statistic/statistic_screen.dart';
import 'package:nightary/views/base/base_screen.dart';
import 'package:nightary/views/statistic/recent_fragment.dart';

class StatisticScreen extends BaseScreen<StatisticViewModel> {
  const StatisticScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: DefaultTabController(
            animationDuration: const Duration(milliseconds: 300),
            length: 2,
            child: Column(
              children: [
                SizedBox.fromSize(size: const Size.fromHeight(20)),
                _tabBar(context),
                SizedBox.fromSize(size: const Size.fromHeight(20)),
                _tabBarView(),
                SizedBox.fromSize(size: const Size.fromHeight(20)),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_statistic.png";

  Widget _tabBar(BuildContext context) => Container(
        // 탭의 너비와 높이
        width: MediaQuery.of(context).size.width - 40,
        height: 60,

        // 탭의 배경색과 모서리 둥글기
        decoration: BoxDecoration(
          color: const Color(0xCC33335F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: viewModel.tabController,

          // 탭의 배경색
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          dividerColor: Colors.transparent,

          // 탭의 모서리 둥글기
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF564F85),
          ),

          // 탭의 크기
          indicatorSize: TabBarIndicatorSize.tab,

          // 선택된 탭의 색상과 글자 스타일
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),

          // 미선택 탭의 색상과 글자 스타일
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),

          tabs: const [
            Tab(text: "7 Recent"),
            Tab(text: "30 Recent"),
          ],

          // 탭의 간격
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      );

  Widget _tabBarView() => Expanded(
        child: TabBarView(
          controller: viewModel.tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            RecentFragment<SevenRecentViewModel>(),
            RecentFragment<ThirtyRecentViewModel>(),
          ],
        ),
      );
}
