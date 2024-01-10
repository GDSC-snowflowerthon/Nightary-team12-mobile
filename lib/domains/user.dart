import 'package:flutter/material.dart';

class User {
  final int userID;
  final String nickname;
  final int targetSleepTime;
  final TimeOfDay notificationAt;
  final DateTime createdAt;

  const User({
    required this.userID,
    required this.nickname,
    required this.targetSleepTime,
    required this.notificationAt,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'nickname': nickname,
      'targetSleepTime': targetSleepTime,
      'notificationAt': _formatTimeOfDay(notificationAt),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 직렬화에만 추가 로직이 사용될 수 있다길래, toMap()이랑 toJson()이랑 구분함. 현재 코드상으로는 toMap과 같은 기능을 수행하긴함.
  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return toMap();
  }

  // JSON을 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      nickname: json['nickname'],
      targetSleepTime: json['targetSleepTime'],
      notificationAt: parseTimeOfDay(json['notificationAt']),
      createdAt: DateTime.parse(json['createdAt']),
    );
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
