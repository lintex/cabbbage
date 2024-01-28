import 'package:flutter/material.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_dashboard_tile.dart';
import 'package:xiao_note/components/my_drawer.dart';
import 'package:xiao_note/models/dashboard.dart';
import 'package:xiao_note/theme/theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBg,
      appBar: MyAppBar(title: Dashboard.getTitle()),
      drawer: const MyDrawer(),
      body: ListView(
        children: [
          MyDashboardTile(),
          MyDashboardTile(),
          MyDashboardTile(),
          MyDashboardTile(),
          MyDashboardTile(),
        ],
      ),
    );
  }
}
