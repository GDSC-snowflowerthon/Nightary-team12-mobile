import 'package:drift/drift.dart';

/// Select 시점
/// 1. [백색 소음 화면] 백색 소음 목록 조회 쿼리문 필요
///
/// Table Column 설명
/// 1. id: 백색 소음 기록의 고유 ID
/// 2. imgUrl: 백색 소음 이미지 URL
/// 3. fileLocation: 백색 소음 파일 위치
@TableIndex(name: 'id', columns: {#id})
class WhiteNoise extends Table {
  @override
  String get tableName => 'SleepRecord';

  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get imgUrl => text().named('imgUrl')();
  TextColumn get fileLocation => text().named('fileLocation')();
}
