part of 'setting_screen.dart';

class SetNoticeTime extends StatelessWidget {
  const SetNoticeTime({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingViewModel>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF17191D),
        ),
        child: CupertinoTheme(
          data: const CupertinoThemeData(brightness: Brightness.dark),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (DateTime date) {
              controller.noticeHour.value = date.hour;
              controller.noticeMin.value = date.minute;
              final now = DateTime.now();
              SharedPreferenceFactory.setTargetSleepTime(
                  date.hour, date.minute, now.hour, now.minute);
              controller.updateGoalTime();
            },
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CardButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 여기에서 콜백 함수를 사용
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: Get.width - 60,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFF2B2B2B),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 17, left: 20),
          child: Text(
            text,
            style: FontSystem.KR16B.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SetSleepTime extends StatelessWidget {
  const SetSleepTime({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Get.find<HomeViewModel>();
    return Container(
      height: 300.0,
      color: Colors.white,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        use24hFormat: true,
        initialDateTime: DateTime(2020, 1, 1, 6),
        // 오전 6시부터 선택 가능하도록 초기값 설정
        minimumDate: DateTime(2020, 1, 1, 6),
        // 오전 6시부터
        maximumDate: DateTime(2020, 1, 1, 10),
        // 오전 10시까지
        onDateTimeChanged: (DateTime value) {
          homeViewModel.setGoalHour(value.hour);
          homeViewModel.setGoalMin(value.minute);
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  final int goalHour;
  final int goalMin;
  final String nickname;

  const Header({
    required this.goalHour,
    required this.goalMin,
    required this.nickname,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/setting_people.png',
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nickname,
              style: FontSystem.KR20B.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'assets/images/setting_sun_icon.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Text(
                  "${goalHour}h ${goalMin}m",
                  style: FontSystem.KR16M.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class SetTargetSleepTime extends StatelessWidget {
  const SetTargetSleepTime({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF24282F);
    const disabledColor = Colors.black;
    const handlerColor = Color(0xFF9CA2AC);
    const selectedColor = Color(0xFF363C46);
    const tickColor = Color(0xFF24282F);
    final controller = Get.find<SettingViewModel>();

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.transparent.withOpacity(0.5),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: const Color(0xFF0A0A25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "취침 시간",
                        style: FontSystem.KR14M.copyWith(color: handlerColor),
                      ),
                      Obx(() {
                        String isAm =
                        controller.startHour.value < 12 ? "오전" : "오후";

                        return Text(
                          "$isAm ${controller.startHour.value.toString().padLeft(2, '0')}:${controller.startMin.value.toString().padLeft(2, '0')}",
                          style: FontSystem.KR20B.copyWith(color: Colors.white),
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "기상",
                        style: FontSystem.KR14M.copyWith(color: handlerColor),
                      ),
                      Obx(() {
                        String isAm =
                        controller.endHour.value < 12 ? "오전" : "오후";
                        return Text(
                          "$isAm ${controller.endHour.value.toString().padLeft(2, '0')}:${controller.endMin.value.toString().padLeft(2, '0')}",
                          style: FontSystem.KR20B.copyWith(color: Colors.white),
                        );
                      }),
                    ],
                  ),
                ],
              ),
              TimeRangePicker(
                fromText: "취침 시간",
                toText: "기상",
                selectedColor: selectedColor,
                backgroundColor: disabledColor,
                ticksColor: tickColor,
                ticks: 90,
                ticksLength: 24,
                ticksWidth: 1.5,
                ticksOffset: 5,
                handlerColor: handlerColor,
                strokeColor: const Color(0xFF232633).withOpacity(0.9),
                strokeWidth: 25,
                onStartChange: (p0) {
                  controller.onChangeStartTime(p0.hour, p0.minute);
                },
                onEndChange: (p0) {
                  controller.onChangeEndTime(p0.hour, p0.minute);
                },
                labels: [
                  ClockLabel(angle: 0, text: "06:00 pm"),
                  ClockLabel(angle: math.pi / 2, text: "12:00 am"),
                  ClockLabel(angle: math.pi, text: "06:00 am"),
                  ClockLabel(angle: math.pi * 3 / 2, text: "12:00 pm"),
                ],
                start: TimeOfDay(
                    hour: controller.startHour.value,
                    minute: controller.startMin.value),
                end: TimeOfDay(
                    hour: controller.endHour.value,
                    minute: controller.endMin.value),
                labelOffset: -40,
                clockRotation: 180,
                rotateLabels: true,
                labelStyle: FontSystem.KR14SB.copyWith(color: Colors.white),
                minDuration: const Duration(hours: 4),
                maxDuration: const Duration(hours: 20),
                use24HourFormat: false,
                hideButtons: true,
                hideTimes: true,
                timeTextStyle: FontSystem.KR20B.copyWith(color: Colors.white),
                backgroundWidget: Container(
                  decoration: const BoxDecoration(
                    color: disabledColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(40),
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: backgroundColor,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "닫기",
                        style: FontSystem.KR16B.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}