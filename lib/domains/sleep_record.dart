class SleepRecord {
  final int recordID;
  final int userID;
  final DateTime startSleepDate;
  final DateTime endSleepDate;
  final String source;
  final int todaySleepDebt;
  final int totalSleepDebt;
  final DateTime createdAt;

  const SleepRecord({
    required this.recordID,
    required this.userID,
    required this.startSleepDate,
    required this.endSleepDate,
    required this.source,
    required this.todaySleepDebt,
    required this.totalSleepDebt,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'recordID': recordID,
      'userID': userID,
      'startSleepDate': startSleepDate.toIso8601String(),
      'endSleepDate': endSleepDate.toIso8601String(),
      'source': source,
      'todaySleepDebt': todaySleepDebt,
      'totalSleepDebt': totalSleepDebt,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 직렬화에만 추가 로직이 사용될 수 있다길래, toMap()이랑 toJson()이랑 구분함. 현재 코드상으로는 toMap과 같은 기능을 수행하긴함.
  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return toMap();
  }

  factory SleepRecord.fromJson(Map<String, dynamic> json) {
    return SleepRecord(
      recordID: json['recordID'],
      userID: json['userID'],
      startSleepDate: DateTime.parse(json['startSleepDate']),
      endSleepDate: DateTime.parse(json['endSleepDate']),
      source: json['source'],
      todaySleepDebt: json['todaySleepDebt'],
      totalSleepDebt: json['totalSleepDebt'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
