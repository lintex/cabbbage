import 'package:feedback/feedback.dart';
import 'package:flutter/widgets.dart';
import 'messages.dart';
import 'pages/unknown_route_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'models/database.dart';
import 'theme/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'routes.dart';

// flutter build apk --release --build-number=10 --build-name="0.1.0"
// flutter build apk --help
// flutter install --release
Future<void> main() async {
  // 定义错误界面
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              details.exception.toString(),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            )
          ],
        ),
      ),
    );
  };
  // 初始化Isar数据库
  WidgetsFlutterBinding.ensureInitialized();
  await Database.initialize();
  // 初始化GetStorage，不然读取不到配置信息
  await GetStorage.init();

  runApp(BetterFeedback(
    child: GetMaterialApp(
      title: '开笔记',
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      theme: GetStorage().read('isDarkMode') == true ? darkMode : lightMode,
      darkTheme: darkMode,
      // 第一次运行程序，显示欢迎界面
      // home: isFirstRun() ? const WelcomePage() : const DashboardPage(),
      initialRoute: isFirstRun() ? '/welcome' : '/dashboard',
      // 404页面
      unknownRoute:
          GetPage(name: '/notFound', page: () => const UnknownRoutePage()),
      // 中间件
      // routingCallback: (routing) {
      //   if (routing?.current == '/welcome') {
      //     // openAds();
      //   }
      // },
      // 路由配置表
      getPages: Routes.pages,
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
    ),
  ));
}

bool isFirstRun() {
  // 判断App是否为第一次运行
  GetStorage box = GetStorage();
  return !box.hasData('isFirstRun') || // 运行welcome后失效
      (box.read('buildNumber') ?? 0) < 13 || // TODO 每次发布改为最新build-number
      // 判断是否为新版本重现安装，数字为build-number
      box.read('isFirstRun') == true; // 通过设置页面设置
}
