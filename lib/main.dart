import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nightary/main_app.dart';
import 'package:nightary/utilities/app_routes.dart';
import 'apps/factory/database_factory.dart';
import 'apps/factory/shared_preference_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");
  await initializeDateFormatting();

  /* Initialize Factory */
  await SharedPreferenceFactory.init();
  await DatabaseFactory.init();

  /* Loading Recent Sleep Record */
  if (SharedPreferenceFactory.instance.getString("nickname") != null) {
    // 헬스 킷에서 데이터 들고오기
  }

  /* Add Duration 1.0s In Splash Screen */
  await Future.delayed(const Duration(seconds: 1));
  await initNotification();

  /* Run App */
  runApp(const MainApp(initialRoute: Routes.ROOT));
}

initNotification() async {
  final notifications = FlutterLocalNotificationsPlugin();

  //ios에서 앱 로드시 유저에게 권한요청하려면
  const iosSetting = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initializationSettings = InitializationSettings(iOS: iosSetting);
  await notifications.initialize(initializationSettings);
}
