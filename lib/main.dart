import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  // Splash Screen Duration 1.0s
  await Future.delayed(const Duration(seconds: 1));

  runApp(const MainApp(initialRoute: Routes.ROOT));
}
