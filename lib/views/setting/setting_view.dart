part of 'setting_screen.dart';

class SetAlarmTimeDialog extends StatelessWidget {
  const SetAlarmTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingViewModel>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: const Color(0xFF0A0A25),
      surfaceTintColor: const Color(0xFF0A0A25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            "알림 시간 설정",
            style: FontSystem.KR20B.copyWith(color: Colors.white),
          ),
          Container(
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF0A0A25),
            ),
            child: CupertinoTheme(
              data: const CupertinoThemeData(brightness: Brightness.dark),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime date) {
                  controller.onChangeAlarmTime(date.hour, date.minute);
                },
                initialDateTime: DateTime(
                  2020,
                  1,
                  1,
                  controller.alarmHour.value,
                  controller.alarmMinute.value,
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
                    "완료",
                    style: FontSystem.KR16B.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
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
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: Get.width - 60,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: const Color(0xFF2B2B2B),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: FontSystem.KR16B.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SetSleepTimeDialog extends StatelessWidget {
  const SetSleepTimeDialog({super.key});

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

class SetTargetSleepTimeDialog extends StatelessWidget {
  const SetTargetSleepTimeDialog({super.key});

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
                            controller.startGoalHour.value < 12 ? "오전" : "오후";

                        return Text(
                          "$isAm ${controller.startGoalHour.value.toString().padLeft(2, '0')}:${controller.startGoalMinute.value.toString().padLeft(2, '0')}",
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
                            controller.endGoalHour.value < 12 ? "오전" : "오후";
                        return Text(
                          "$isAm ${controller.endGoalHour.value.toString().padLeft(2, '0')}:${controller.endGoalMinute.value.toString().padLeft(2, '0')}",
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
                  ClockLabel(angle: 0, text: "오후 6시"),
                  ClockLabel(angle: math.pi / 2, text: "오전 12시"),
                  ClockLabel(angle: math.pi, text: "오전 6시"),
                  ClockLabel(angle: math.pi * 3 / 2, text: "오후 12시"),
                ],
                start: TimeOfDay(
                    hour: controller.startGoalHour.value,
                    minute: controller.startGoalMinute.value),
                end: TimeOfDay(
                    hour: controller.endGoalHour.value,
                    minute: controller.endGoalMinute.value),
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
              Obx(() {
                // 취침 시간과 기상 시간의 차이를 계산
                int hour = controller.endGoalHour.value -
                    controller.startGoalHour.value;
                int min = controller.endGoalMinute.value -
                    controller.startGoalMinute.value;
                if (min < 0) {
                  hour -= 1;
                  min += 60;
                }
                if (hour < 0) {
                  hour += 24;
                }
                return Text(
                  "수면 목표 시간 : $hour시간 $min분",
                  style: FontSystem.KR16M.copyWith(color: Colors.white),
                );
              }),
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
