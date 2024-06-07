import 'package:cabbage/components/my_button.dart';
import 'package:cabbage/components/my_textfield.dart';
import 'package:cabbage/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key, required this.title, required this.text});
  final String title, text;
  @override
  Widget build(BuildContext context) {
    // 获取 controller 保存 userName
    // 初始化SettingsController
    final SettingsController sc = Get.find();
    final controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      height: 220,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: controller,
            text: text,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: MyButton(text: "取消", onPressed: () => Get.back())),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: MyButton(
                      text: "确定",
                      color: Colors.lightGreen[700],
                      textColor: Colors.white,
                      onPressed: () {
                        GetStorage box = GetStorage();
                        box.write('userName', controller.text);
                        sc.setUserName(controller.text);
                        print(sc.userName.value);
                        Get.back();
                        Get.snackbar("success", "昵称已设置为：${controller.text}");
                      })),
            ],
          ),
        ],
      ),
    );
  }
}
