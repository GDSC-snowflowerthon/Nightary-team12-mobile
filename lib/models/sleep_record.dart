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
}