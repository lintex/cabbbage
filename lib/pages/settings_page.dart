import 'package:cabbbage/components/medium_sliver_appbar.dart';
import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_settings_tile.dart';
import 'package:cabbbage/components/my_trailing.dart';
import 'package:cabbbage/controllers/settings_controller.dart';
import 'package:cabbbage/theme/theme.dart';
import 'package:clipboard/clipboard.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// class SwitchController extends GetxController {
//   RxBool isFirstRun = true.obs;
//   void isFirstRunToggle() => isFirstRun.value = !isFirstRun.value;
// }

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取 userName
    final SettingsController sc = Get.find();
    // 读取UUID
    GetStorage box = GetStorage();
    String uuid = box.read('uuid');
    bool isFirstRun = box.read('isFirstRun');
    var autoDarkMode = true.obs;
    autoDarkMode.value = box.read('autoDarkMode');
    bool isDarkMode = box.read('isDarkMode');
    // 控制子空间显示隐藏
    var isShow = true.obs;
    isShow.value = autoDarkMode.value;
    // SwitchController sxc = Get.put(SwitchController());

    TextEditingController controller = TextEditingController();

    return Scaffold(
      body: CustomScrollView(slivers: [
        const MediumSliverAppBar(
          title: "设置",
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Obx(() => MySettingsTile(
                  title: '昵称',
                  trailing: MyTrailing(text: sc.userName.value),
                  onPressed: () {
                    Get.bottomSheet(MyBottomSheet(
                      title: '设置昵称',
                      text: sc.userName.value,
                      controller: controller,
                      onPressed: () {
                        GetStorage box = GetStorage();
                        box.write('userName', controller.text);
                        sc.setUserName(controller.text);
                        debugPrint(sc.userName.value);
                        Get.back();
                        Get.snackbar("success", "昵称已设置为：${controller.text}");
                      },
                    ));
                  },
                )),
            MySettingsTile(
              title: 'UUID',
              subtitle: '系统自动生成',
              trailing: MyTrailing(text: '${uuid.substring(0, 8)}...'),
              onPressed: () {
                FlutterClipboard.copy(uuid)
                    .then((value) => debugPrint('uuid is copied'));
                Get.snackbar("success", "uuid已复制到剪贴板！");
              },
            ),
            MySettingsTile(
              title: '第一次登录',
              subtitle: '会重置部分系统设置',
              trailing: ValueBuilder<bool?>(
                initialValue: isFirstRun,
                builder: (value, update) => Switch.adaptive(
                  value: value!,
                  onChanged: (flag) => update(flag),
                  activeColor: Colors.green,
                ),
                onUpdate: (value) {
                  box.write('isFirstRun', !isFirstRun);
                  debugPrint('autoDarkMode:${!isFirstRun}');
                },
                // onDispose: () => print("Widget unmounted"),
              ),
              onPressed: () {},
            ),
            MySettingsTile(
              title: '自动切换黑夜模式',
              subtitle: '更随系统自动切换模式',
              trailing: ValueBuilder<bool?>(
                initialValue: autoDarkMode.value,
                builder: (value, update) => Switch(
                  value: value!,
                  onChanged: (flag) => update(flag),
                  activeColor: Colors.green,
                ),
                onUpdate: (value) {
                  isShow.value = !autoDarkMode.value;
                  if (autoDarkMode.value == false) {
                    Future.delayed(const Duration(milliseconds: 300))
                        .then((val) {
                      debugPrint('延时300毫秒');
                      autoDarkMode.value = !autoDarkMode.value;
                    });
                  } else {
                    autoDarkMode.value = !autoDarkMode.value;
                  }

                  box.write('autoDarkMode', autoDarkMode.value);
                  debugPrint('autoDarkMode:${autoDarkMode.value}');
                },
                // onDispose: () => print("Widget unmounted"),
              ),
              onPressed: () {},
            ),
            Obx(() => Offstage(
                  offstage: autoDarkMode.value,
                  child: AnimatedOpacity(
                    opacity: isShow.value ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: MySettingsTile(
                      title: '黑夜模式',
                      subtitle: '手动切换黑夜和白天模式',
                      trailing: ValueBuilder<bool?>(
                        initialValue: isDarkMode,
                        builder: (value, update) => Switch(
                          value: value!,
                          onChanged: (flag) => update(flag),
                          activeColor: Colors.lightGreen,
                        ),
                        onUpdate: (value) {
                          isDarkMode = !isDarkMode;
                          box.write('isDarkMode', isDarkMode);
                          debugPrint('isDarkMode:$isDarkMode');
                          isDarkMode
                              ? Get.changeTheme(darkMode)
                              : Get.changeTheme(lightMode);
                        },
                        // onDispose: () => print("Widget unmounted"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                )),
            MySettingsTile(
              title: '系统管理',
              subtitle: '系统参数设置',
              onPressed: () => Get.toNamed('/manage'),
            ),
            Container(
              height: 500,
            ),
          ]),
        ),
      ]),
    );
  }
}
