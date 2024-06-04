import 'package:cabbage/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:cabbage/models/database.dart';
import 'package:cabbage/pages/dashboard_page.dart';
import 'package:cabbage/theme/theme.dart';

// flutter build apk --release
Future<void> main() async {
  // 初始化Isar数据库
  WidgetsFlutterBinding.ensureInitialized();
  await Database.initialize();

  runApp(GetMaterialApp(
    title: '开笔记',
    debugShowCheckedModeBanner: false,
    theme: lightMode,
    darkTheme: darkMode,
    home: const DashboardPage(),

    // 国际化支持
    translations: Messages(), // 你的翻译
    locale: const Locale('zh', 'CN'), // 默认中文
    fallbackLocale: const Locale('en', 'US'), // 中文不存在时，使用英文

    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('zh', 'CH'), //支持列表，中文
      Locale('en', 'US'), //支持列表，英文
    ],
  ));
}
