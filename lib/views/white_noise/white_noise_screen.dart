import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nightary/utilities/font_system.dart';
import 'package:nightary/utilities/music_visualizer.dart';
import 'package:nightary/viewModels/white_noise/white_noise_viewmodel.dart';
import 'package:nightary/views/base/base_screen.dart';

class WhiteNoiseScreen extends BaseScreen<WhiteNoiseViewModel> {
  const WhiteNoiseScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: controller.onTapBack,
                child: const Icon(Icons.close, color: Colors.white),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 300,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: false,
              onPageChanged: (index, reason) {
                controller.index.value = index;
                controller.onChangePlayStatus(false);
              },
            ),
            itemCount: controller.musics.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  controller.onChangePlayStatus(!controller.isPlaying.value);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/white_noise_1.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Obx(
                        () {
                          if (controller.index.value == index) {
                            if (controller.isPlaying.value) {
                              return MusicVisualizer(
                                barCount: 30,
                                colors: controller.colors,
                                duration: controller.isPlaying.value
                                    ? controller.duration
                                    : controller.stopDuration,
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  30,
                                  (index) => Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      )),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    Obx(() {
                      return AnimatedOpacity(
                        opacity: controller.isPlaying.value &&
                                !controller.isShowIndicator.value
                            ? 0.0
                            : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Obx(
                            () => Icon(
                              controller.isPlaying.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Try winding down your day with white noise",
                  style: FontSystem.KR24B.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "만족스러운 하루를 보내셨나요?\n잔잔한 소리를 들으며 함께 하루를 마무리 해봐요.",
                  style: FontSystem.KR16R.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  String? get backgroundImagePath => "assets/images/background_statistic.png";
}
