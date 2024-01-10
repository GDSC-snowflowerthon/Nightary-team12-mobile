import 'package:drift/drift.dart';

/// Select 시점
/// 1. [통계 화면] 최근 N번의 수면 차트, 수면 빚 추이 표시할 때 조회 쿼리문 필요
///
/// Table Column 설명
/// 1. id: 수면 기록의 고유 ID
/// 2. startSleepDate: 수면 시작 시간
/// 3. endSleepDate: 수면 종료 시간
@DataClassName('WhiteNoise')
class WhiteNoise extends Table {
  @override
  String get tableName => 'SleepRecord';

  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get imgUrl => text().named('imgUrl')();
  TextColumn get fileLocation => text().named('fileLocation')();
}
