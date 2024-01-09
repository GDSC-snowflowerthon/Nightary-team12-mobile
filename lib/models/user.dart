class User {
  int userID;
  String nickname;
  int targetSleepTime;
  TimeOfDay notificationAt;
  DateTime createdAt;

  User({this.userID, this.nickname, this.targetSleepTime, this.notificationAt, this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'nickname': nickname,
      'targetSleepTime': targetSleepTime,
      'notificationAt': _formatTimeOfDay(notificationAt),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // TimeOfDay -> 'HH:mm' 형식의 문자열
  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // 'HH:mm' 형식 문자열 -> TimeOfDay 
  static TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
