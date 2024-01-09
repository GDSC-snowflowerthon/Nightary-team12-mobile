import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nightary/main_app.dart';
void main() async {
  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");
  await initializeDateFormatting();

  // Splash Screen Duration 1.0s
  await Future.delayed(const Duration(seconds: 1));

  runApp(const MainApp(initialRoute: "/"));
}
