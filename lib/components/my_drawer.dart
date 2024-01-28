import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/pages/dashboard_page.dart';
import 'package:xiao_note/pages/grid_page.dart';
import 'package:xiao_note/pages/note_page.dart';
import 'package:xiao_note/theme/theme.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: greyBg,
      child: Container(
        color: greyBg,
        // 使用Container控制边距
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Text(
                "lintex",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.space_dashboard_outlined),
              title: const Text("仪表盘"),
              onTap: () => Get.to(() => const DashboardPage()),
            ),
            ListTile(
              leading: const Icon(Icons.notes),
              title: const Text("日记"),
              onTap: () => Get.to(() => const NotePage()),
            ),
            ListTile(
              leading: const Icon(Icons.check_box_outlined),
              title: const Text("待办"),
              onTap: () => Get.to(() => const NotePage()),
            ),
            ListTile(
              leading: const Icon(Icons.scatter_plot_outlined),
              title: const Text("全部功能"),
              onTap: () => Get.to(() => const GridPage()),
            )
          ],
        ),
      ),
    );
  }
}
