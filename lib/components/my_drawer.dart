import 'package:cabbage/controllers/settings_controller.dart';
import 'package:cabbage/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cabbage/pages/about_page.dart';
import 'package:cabbage/pages/grid_page.dart';
import 'package:cabbage/pages/note_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化SettingsController
    final sc = Get.put(SettingsController());
    // 读取版本号
    GetStorage box = GetStorage();
    sc.version.value = box.read('version');
    sc.userName.value = box.read('userName');

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
              onTap: () => Get.to(() => const SettingPage()),
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Obx(() => Text(
                      sc.userName.value,
                      style: const TextStyle(fontSize: 25, fontFamily: "方正大标宋"),
                    )),
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
                    title: const Text("笔记 "),
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
                    onTap: () => Get.to(() => const SettingPage()),
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
              child: GestureDetector(
                onTap: () => Get.to(() => const AboutPage()),
                child: Obx(() => Text(
                      "Version: ${sc.version.value}",
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade400),
                    )),
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
