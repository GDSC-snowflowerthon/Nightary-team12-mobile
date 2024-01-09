class SleepRecord {
  int recordID;
  int userID;
  DateTime startSleepDate;
  DateTime endSleepDate;
  String source;
  int todaySleepDebt;
  int totalSleepDebt;
  DateTime createdAt;

  SleepRecord({
    this.recordID,
    this.userID,
    this.startSleepDate,
    this.endSleepDate,
    this.source,
    this.todaySleepDebt,
    this.totalSleepDebt,
    this.createdAt,
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