import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xiao_note/models/note_database.dart';
import 'package:xiao_note/pages/dashboard_page.dart';
import 'package:xiao_note/theme/theme.dart';

Future<void> main() async {
  // 初始化Isar数据库
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(GetMaterialApp(
    title: '白菜笔记',
    debugShowCheckedModeBanner: false,
    theme: lightMode,
    darkTheme: darkMode,
    home: const DashboardPage(),
  ));
}
