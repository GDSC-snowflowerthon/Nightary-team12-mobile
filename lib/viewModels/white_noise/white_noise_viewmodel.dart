import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class WhiteNoiseViewModel extends GetxController {
  final player = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    player.setUrl(
        "https://archive-halfmoon-mind.s3.ap-northeast-2.amazonaws.com/music_1.mp3");
  }

  @override
  void onClose() {
    super.onClose();
    player.dispose();
  }

  RxInt index = 0.obs;

  RxBool isPlaying = false.obs;

  void onChangePlayStatus(bool isPlaying) async {
    this.isPlaying.value = isPlaying;
    if (isPlaying) {
      player.play();
    }
    if (!isPlaying) {
      player.pause();
    }

    isShowIndicator.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      isShowIndicator.value = false;
    });
  }

  RxBool isShowIndicator = true.obs;

  final musics = [
    'assets/data/music_1.mp3',
    'assets/data/music_1.mp3',
    'assets/data/music_1.mp3',
    'assets/data/music_1.mp3',
    'assets/data/music_1.mp3',
  ];

  RxInt currentIndex = 0.obs;

  final colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  final List<int> duration = [900, 700, 600, 800, 900];

  final List<int> stopDuration = [1, 1, 1, 1, 1];

  void onTapBack() {
    Get.back();
  }
}
