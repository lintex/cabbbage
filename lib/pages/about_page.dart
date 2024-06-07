import 'package:cabbage/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cabbage/components/my_app_bar.dart';
import 'package:cabbage/components/my_button.dart';
import 'package:cabbage/pages/manage_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle greyText = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontSize: 12,
    );
    TextStyle underlineText = TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
        fontSize: 12,
        decoration: TextDecoration.underline);
    // 读取版本号
    GetStorage box = GetStorage();
    String version = box.read('version') ?? 'null';
    final SettingsController sc = Get.find();
    // 点击次数
    int clickTimes = 1;

    return Scaffold(
        appBar: const MyAppBar(title: "关于"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 40),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 95,
                      ),
                      // 点击7次跳转到管理界面
                      GestureDetector(
                        onTap: () => clickTimes == 7
                            ? Get.to(() => const ManagePage())
                            : clickTimes++,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 70,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("再菜也要用心卷",
                          style: TextStyle(fontFamily: '字语相思体', fontSize: 28)),
                      const SizedBox(height: 15),
                      Obx(() => Text(
                            "开笔记 ${sc.version.value}",
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      MyButton(
                          text: "检查更新",
                          color: Colors.green[300]!,
                          onPressed: () {}),
                      // Image.asset(
                      //   "assets/images/about.jpg",
                      //   width: 200,
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "小西软件 版权所有",
                      style: greyText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Copyright ©️ 2024 SmallWest Software. All rights reserved.",
                      style: greyText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "ICP备案号：鄂B2-20240059-1745A",
                      style: greyText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "用户协议",
                          style: underlineText,
                        ),
                        Text(
                          " · ",
                          style: greyText,
                        ),
                        Text(
                          "隐私政策",
                          style: underlineText,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
