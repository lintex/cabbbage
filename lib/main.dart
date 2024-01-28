import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/models/note_database.dart';
import 'package:xiao_note/pages/dashboard_page.dart';

Future<void> main() async {
  // 初始化Isar数据库
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(GetMaterialApp(
    title: '小西笔记',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      useMaterial3: true,
    ),
    home: const DashboardPage(),
  ));
}
