import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_button.dart';

class ManagePage extends StatelessWidget {
  const ManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 读取版本号
    GetStorage box = GetStorage();

    final versionController = TextEditingController();
    versionController.text = box.read('version') ?? '';

    return Scaffold(
        appBar: const MyAppBar(title: "管理页面"),
        body: Column(
          children: [
            TextField(
              controller: versionController,
            ),
            MyButton(
                text: '保存',
                onPressed: () {
                  box.write('version', versionController.text);
                  Get.snackbar('注意⚠️', "新版本号${versionController.text}写入✅成功！");
                })
          ],
        ));
  }
}
