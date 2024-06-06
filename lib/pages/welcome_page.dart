import 'package:cabbage/components/my_button.dart';
import 'package:cabbage/pages/dashboard_page.dart';
import 'package:cabbage/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome")),
        body: Center(
          child: MyButton(
              text: "进入程序",
              onPressed: () {
                GetStorage box = GetStorage();
                box.write('isFirstRun', false);
                box.write('version', '0.0.9.240606');
                box.write('userName', 'Guest');
                // 生成UUID
                box.write('uuid', Tools.getUUID());
                // TODO 初始化数据库数据，添加测试数据
                Get.off(const DashboardPage());
              }),
        ));
  }
}
