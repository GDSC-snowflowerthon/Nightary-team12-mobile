import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:nightary/bindings/root_binding.dart';
import 'views/root/root_screen.dart';

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    _init(context);

    return GetMaterialApp(
      title: "Nightary",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf6f6f8),
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(
            name: '/', page: () => const RootScreen(), binding: RootBinding()),
      ],
    );
  }

  Future<void> _init(BuildContext context) async {
    // 이미지 프리캐싱을 위한 Future 리스트 생성
    final List<Future<void>> precacheFutures = [
      precacheImage(
          const AssetImage('assets/images/background_home.png'), context),
      precacheImage(
          const AssetImage('assets/images/background_analyze.png'), context),
      precacheImage(
          const AssetImage('assets/images/background_setting.png'), context),
      precacheImage(
          const AssetImage('assets/images/background_statistic.png'), context),
    ];

    // 모든 프리캐싱 Future가 완료될 때까지 대기
    await Future.wait(precacheFutures);

    FlutterNativeSplash.remove();
  }
}
