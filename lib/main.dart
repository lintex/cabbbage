import 'package:cabbbage/components/my_drawer.dart';
import 'package:cabbbage/controllers/settings_controller.dart';
import 'package:cabbbage/messages.dart';
import 'package:cabbbage/pages/about_page.dart';
import 'package:cabbbage/pages/grid_page.dart';
import 'package:cabbbage/pages/manage_page.dart';
import 'package:cabbbage/pages/marathon_page2.dart';
import 'package:cabbbage/pages/note_page.dart';
import 'package:cabbbage/pages/pace_calculate_page.dart';
import 'package:cabbbage/pages/ruler_page.dart';
import 'package:cabbbage/pages/settings_page.dart';
import 'package:cabbbage/pages/timetable_page.dart';
import 'package:cabbbage/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/pages/dashboard_page.dart';
import 'package:cabbbage/theme/theme.dart';
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
    getPages: [
      GetPage(
        name: '/dashboard',
        page: () => const DashboardPage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/drawer',
        page: () => const MyDrawer(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/settings',
        page: () => const SettingPage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/marathon',
        page: () => const MarathonPage2(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/about',
        page: () => const AboutPage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/grid',
        page: () => const GridPage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/manage',
        page: () => const ManagePage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/note',
        page: () => const NotePage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/calculator',
        page: () => const PaceCalculatePage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/ruler',
        page: () => const RulerPage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/timeTable',
        page: () => const TimetablePage(),
        binding: ControllerBind(),
      ),
      GetPage(
        name: '/welcome',
        page: () => const WelcomePage(),
        binding: ControllerBind(),
      ),
    ],
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

class ControllerBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}

bool isFirstRun() {
  // 判断App是否为第一次运行
  GetStorage box = GetStorage();
  return !box.hasData('isFirstRun');
}
