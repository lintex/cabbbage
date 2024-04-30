import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cabbage/components/my_app_bar.dart';
import 'package:cabbage/components/my_button.dart';
import 'package:cabbage/components/my_textfield.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                controller: versionController,
                hintText: '输入版本号',
                labelText: '版本号',
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  text: '保存',
                  onPressed: () {
                    box.write('version', versionController.text);
                    Get.snackbar('', "新版本号 ${versionController.text} 写入成功！");
                    // var snackBar = SnackBar(
                    //   content: Text('✅成功：新版本号 ${versionController.text} 写入成功！'),
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  })
            ],
          ),
        ));
  }
}
