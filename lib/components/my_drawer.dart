import 'package:cabbbage/components/my_icon.dart';
import 'package:cabbbage/controllers/settings_controller.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化SettingsController
    final sc = Get.put(SettingsController());
    // 读取版本号
    GetStorage box = GetStorage();
    sc.userName.value = box.read('userName');
    sc.version.value = box.read('version');
    sc.buildName.value = box.read('buildName');
    sc.buildNumber.value = box.read('buildNumber');

    return Drawer(
      width: 250,
      //backgroundColor: greyBg,
      shadowColor: Colors.lightGreen[300],
      surfaceTintColor: Colors.lightGreen[300],
      child: Container(
        color: Theme.of(context).colorScheme.background,
        // 使用Container控制边距
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed('/settings'),
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
                    leading: const MyIcon(
                      Icons.space_dashboard_outlined,
                      color: Colors.lightBlue,
                    ),
                    title: const Text("仪表盘"),
                    onTap: () => Get.back(),
                  ),
                  ListTile(
                    leading: const MyIcon(
                      Icons.insights_outlined,
                      color: Colors.blue,
                    ),
                    title: const Text("日记"),
                    onTap: () => Get.toNamed('/timeline'),
                  ),
                  ListTile(
                    leading: const MyIcon(
                      CupertinoIcons.doc_text,
                      color: Colors.green,
                    ),
                    title: const Text("笔记 "),
                    onTap: () => Get.toNamed('/note'),
                  ),
                  ListTile(
                    leading: const MyIcon(
                      Icons.check_box_outlined,
                      color: Colors.lightGreen,
                    ),
                    title: const Text("待办"),
                    onTap: () => Get.toNamed('/todo'),
                  ),
                  ListTile(
                    // leading: const Icon(Icons.scatter_plot_outlined),
                    leading: const MyIcon(
                      Icons.apps_rounded,
                      color: Colors.indigo,
                    ),
                    title: const Text("全部功能"),
                    onTap: () => Get.toNamed('/grid'),
                  ),
                  ListTile(
                    leading: const MyIcon(
                      CupertinoIcons.gear_alt,
                      color: Colors.teal,
                    ),
                    title: const Text("设置"),
                    onTap: () => Get.toNamed('/settings'),
                  ),
                  ListTile(
                    leading: const MyIcon(
                      CupertinoIcons.ellipses_bubble,
                      color: Colors.cyan,
                    ),
                    title: const Text("反馈"),
                    onTap: () {
                      BetterFeedback.of(context)
                          .show((UserFeedback feedback) async {
                        // draft an email and send to developer
                        final screenshotFilePath =
                            await Tools.writeImageToStorage(
                                feedback.screenshot);

                        final Email email = Email(
                          body: feedback.text,
                          subject: 'Cabbbage Feedback',
                          recipients: ['cabbbage@qq.com'],
                          attachmentPaths: [screenshotFilePath],
                          isHTML: false,
                        );

                        String platformResponse;
                        try {
                          await FlutterEmailSender.send(email);
                          platformResponse = 'success';
                        } catch (error) {
                          debugPrint(error.toString());
                          platformResponse = error.toString();
                        }
                        if (platformResponse == 'success') {
                          Get.snackbar("Thanks", "感谢你的反馈!");
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () => Get.toNamed('/about'),
                child: Obx(() => Text(
                      "Version: ${sc.buildName.value}.${sc.version.value}",
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
