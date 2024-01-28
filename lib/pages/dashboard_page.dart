import 'package:flutter/material.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_drawer.dart';
import 'package:xiao_note/models/dashboard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Dashboard.getTitle()),
      body: const Center(),
      // 抽屉菜单
      drawer: const MyDrawer(),
    );
  }
}
