import 'package:cabbage/messages.dart';
import 'package:cabbage/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:cabbage/models/database.dart';
import 'package:cabbage/pages/dashboard_page.dart';
import 'package:cabbage/theme/theme.dart';
import 'package:get_storage/get_storage.dart';

// flutter build apk --release --build-number=10 --build-name="0.1.0"
// flutter build apk --help
Future<void> main() async {
  // 初始化Isar数据库
  WidgetsFlutterBinding.ensureInitialized();
  await Database.initialize();
  // 初始化GetStorage，不然读取不到配置信息
  await GetStorage.init();

  runApp(GetMaterialApp(
    title: '开笔记',
    debugShowCheckedModeBanner: false,
    theme: lightMode,
    darkTheme: darkMode,
    // 第一次运行程序，显示欢迎界面
    home: isFirstRun() ? const WelcomePage() : const DashboardPage(),

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

bool isFirstRun() {
  // 判断App是否为第一次运行，进入欢迎界面
  GetStorage box = GetStorage();
  return box.read('isFirstRun') ?? true;
  // if (isFirstRun) {
  //   debugPrint("App第一次运行");
  //   Get.to(const WelcomePage());
  // } else {
  //   debugPrint("App不是第一次运行");
  // }
}
