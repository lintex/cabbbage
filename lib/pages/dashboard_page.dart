import 'package:flutter/material.dart';
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
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: greyBg,
          title: Text(
            Dashboard.getTitle(),
            style: const TextStyle(fontSize: 18),
          )),
      drawer: const MyDrawer(),
      body: ListView(
        children: const [
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
