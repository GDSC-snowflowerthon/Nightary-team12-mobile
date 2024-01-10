import 'package:drift/drift.dart';
import 'package:nightary/domains/types/e_source.dart';

/// Insert 시점(사용자 입력 or 타이머 기록 or 워치 기록)
/// 1. Insert 시점 : 사용자가 직접 입력하거나, 타이머 종료 버튼을 누르거나, 워치에서 불러오기 버튼을 수락했을 때
/// 수면 시작 시각, 수면 끝 시각을 바탕으로 '총 수면시간'을 계산.
/// TargetSleepTime과 '총 수면시간'의 차이를 통해 TodaySleepDebt 구함. 가장 최근의 수면 기록에서의 TotalSleepDebt를 가져와, 위의 TodaySleepDebt를 반영하여 Insert
///
/// Select 시점
/// 1. [홈 화면] 배터리, 수면 빚 표시할 때 조회 쿼리문 필요,
/// ID순으로 정렬하여 해당 사용자의 가장 최근의 레코드를 조회-> 기상 시 배터리 계산 후, 현재 시각과 기상 시각과의 차이를 통해 현재 배터리 표현
/// 2. [통계 화면] 최근 N번의 수면 차트, 수면 빚 추이 표시할 때 조회 쿼리문 필요
///
/// Table Column 설명
/// 1. id: 수면 기록의 고유 ID
/// 2. startSleepDate: 수면 시작 시간
/// 3. endSleepDate: 수면 종료 시간
/// 4. source: 수면 기록의 출처(Direct, Timer, Watch)
/// 5. todaySleepDebt: 수면 부족량
/// 6. totalSleepDebt: 총 수면 부족량
/// 7. createdAt: 수면 기록 생성 시간
class SleepRecord extends Table {
  @override
  String get tableName => 'SleepRecord';

  IntColumn get id => integer().named('id').autoIncrement()();
  DateTimeColumn get startSleepDate => dateTime().named('startSleepDate')();
  DateTimeColumn get endSleepDate => dateTime().named('endSleepDate')();
  TextColumn get source => textEnum<ESource>().named('source')();
  IntColumn get todaySleepDebt => integer().named('todaySleepDebt')();
  IntColumn get totalSleepDebt => integer().named('totalSleepDebt')();
  DateTimeColumn get createdAt => dateTime().named('createdAt')();
}
