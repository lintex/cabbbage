import 'package:cabbbage/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/components/my_textfield2.dart';

class ManagePage extends StatelessWidget {
  const ManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 读取版本号
    GetStorage box = GetStorage();
    final SettingsController sc = Get.find();

    final versionController = TextEditingController();
    versionController.text = box.read('version') ?? '';
    final buildNameController = TextEditingController();
    buildNameController.text = box.read('buildName') ?? '';
    final buildNumberController = TextEditingController();
    buildNumberController.text = box.read('buildNumber').toString();

    return Scaffold(
        appBar: const MyAppBar(title: "管理页面"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFieldWithLabel(
                controller: versionController,
                hintText: '输入版本号',
                labelText: 'version',
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextFieldWithLabel(
                controller: buildNameController,
                hintText: '输入版本号',
                labelText: 'buildName',
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextFieldWithLabel(
                controller: buildNumberController,
                hintText: '输入版本号',
                labelText: 'buildNumber',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                        text: '保存',
                        color: Colors.lightGreen,
                        onPressed: () {
                          box.write('version', versionController.text);
                          box.write('buildName', buildNameController.text);
                          box.write('buildNumber', buildNumberController);
                          sc.setNewVersion(
                              versionController.text,
                              buildNameController.text,
                              int.parse(buildNumberController.text));
                          Get.snackbar('Success', "新版本号 写入成功！");
                        }),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MyButton(
                        text: '返回',
                        onPressed: () {
                          Get.back();
                        }),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
