import 'package:cabbbage/pages/marathonPage/edit_marathon_page.dart';
import 'package:cabbbage/pages/marathonPage/marathon_detail_page.dart';
import 'package:cabbbage/pages/marathonPage/new_marathon_page.dart';
import 'package:cabbbage/pages/todo_page.dart';

import 'pages/timeline_page.dart';
import 'package:get/get.dart';

import 'components/my_drawer.dart';
import 'controllers/settings_controller.dart';
import 'models/database.dart';
import 'pages/about_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/grid_page.dart';
import 'pages/manage_page.dart';
import 'pages/marathon_page2.dart';
import 'pages/note_page.dart';
import 'pages/pace_calculate_page.dart';
import 'pages/ruler_page.dart';
import 'pages/settings_page.dart';
import 'pages/timetable_page.dart';
import 'pages/welcome_page.dart';

class ControllerBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => Database());
  }
}

class Routes {
  static final pages = [
    GetPage(
      name: '/dashboard',
      page: () => const DashboardPage(),
      binding: ControllerBind(),
      // middlewares: ,
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/timeline',
      page: () => const TimelinePage(),
      binding: ControllerBind(),
      // middlewares: ,
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/todo',
      page: () => const TodoPage(),
      binding: ControllerBind(),
      // middlewares: ,
      transition: Transition.cupertino,
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
      name: '/newMarathon',
      page: () => NewMarathonPage(),
      binding: ControllerBind(),
    ),
    GetPage(
      name: '/editMarathon',
      page: () => EditMarathonPage(),
      binding: ControllerBind(),
    ),
    GetPage(
      name: '/marathonDetail',
      page: () => const MarathonDetailPage(),
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
      name: '/pace',
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
    GetPage(
      name: '/welcome',
      page: () => const WelcomePage(),
      binding: ControllerBind(),
    ),
  ];
}
