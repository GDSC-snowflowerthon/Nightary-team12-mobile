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

  /// carousel에서 선택한 index
  RxInt index = 0.obs;

  /// 현재 음악 재생 상태
  RxBool isPlaying = false.obs;

  /// 음악 재생 상태 보여줄 지 여부, 일시 정지 상태일 경우에는 현재 데이터와 상관 없이 보여짐
  RxBool isShowIndicator = true.obs;

  /// 음악 재생 상태 변경
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

  final musics = [
    'assets/data/music_1.mp3',
  ];

  /* 음악 재생 관련 데이터 */
  /// 재생바 색상
  final colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  /// 각 재생바 애니메이션 시간
  final List<int> duration = [900, 700, 600, 800, 900];

  void onTapBack() {
    Get.back();
  }
}
