import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/pages/grid_page.dart';
import 'package:xiao_note/pages/note_page.dart';
import 'package:xiao_note/pages/ruler_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: greyBg,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        // 使用Container控制边距
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  "lintex",
                  style: TextStyle(fontSize: 25, fontFamily: "方正大标宋"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.space_dashboard_outlined),
                    title: const Text("仪表盘"),
                    onTap: () => Get.back(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.insights_outlined),
                    title: const Text("时刻"),
                    onTap: () => Get.to(() => const NotePage()),
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.doc_text),
                    title: const Text("文章"),
                    onTap: () => Get.to(() => const NotePage()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.check_box_outlined),
                    title: const Text("待办"),
                    onTap: () => Get.to(() => const NotePage()),
                  ),
                  ListTile(
                    // leading: const Icon(Icons.scatter_plot_outlined),
                    leading: const Icon(CupertinoIcons.circle_grid_3x3),
                    title: const Text("全部功能"),
                    onTap: () => Get.to(() => const GridPage()),
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.gear_alt),
                    title: const Text("设置"),
                    onTap: () => Get.to(() => const GridPage()),
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.ellipses_bubble),
                    title: const Text("反馈"),
                    onTap: () => Get.to(() => const GridPage()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Version: 2024.3.6.8",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
