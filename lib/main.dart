import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:xiao_note/models/marathon_database.dart';
import 'package:xiao_note/pages/dashboard_page.dart';
import 'package:xiao_note/theme/theme.dart';

Future<void> main() async {
  // 初始化Isar数据库
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: 这个地方不能初始化两次，导致note页面用不成
  // await NoteDatabase.initialize();
  await MarathonDatabase.initialize();

  runApp(GetMaterialApp(
    title: '白菜助手',
    debugShowCheckedModeBanner: false,
    theme: lightMode,
    darkTheme: darkMode,
    home: const DashboardPage(),

    // 国际化支持
    locale: const Locale('zh', 'CH'), //默认是中文
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
