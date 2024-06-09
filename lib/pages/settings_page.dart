import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_settings_tile.dart';
import 'package:cabbbage/components/my_trailing.dart';
import 'package:cabbbage/controllers/settings_controller.dart';
import 'package:cabbbage/theme/theme.dart';
import 'package:flutter/cupertino.dart';
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
    // SwitchController sxc = Get.put(SwitchController());

    return Scaffold(
      //appBar: MyAppBar(title: "设置"),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          pinned: true,
          expandedHeight: 120,
          flexibleSpace: LayoutBuilder(builder: (context, constraints) {
            var top = constraints.biggest.height;
            // print(top);
            return FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1.4,
              stretchModes: const [
                StretchMode.fadeTitle,
              ],

              // 要设置titlePadding不然无法居中，默认start：72
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 72, bottom: 16),
              title: top < 130
                  ? const Text("设置")
                  : Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(left: 0),
                      child: const Text("个人信息"),
                    ),
            );
          }),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(
              height: 20,
            ),
            Obx(() => MySettingsTile(
                  title: '昵称',
                  trailing: MyTrailing(text: sc.userName.value),
                  onPressed: () {
                    Get.bottomSheet(MyBottomSheet(
                      title: '设置昵称',
                      text: sc.userName.value,
                    ));
                  },
                )),
            MySettingsTile(
              title: 'UUID',
              subtitle: '系统自动生成',
              trailing: MyTrailing(text: '${uuid.substring(0, 8)}...'),
              onPressed: () {},
            ),
            MySettingsTile(
              title: '第一次登录',
              trailing: ValueBuilder<bool?>(
                initialValue: isFirstRun,
                builder: (value, update) => Switch(
                  value: value!,
                  onChanged: (flag) => update(flag),
                  activeColor: Colors.green,
                ),
                onUpdate: (value) {
                  box.write('isFirstRun', !isFirstRun);
                  debugPrint('autoDarkMode:${!isFirstRun}');
                },
                onDispose: () => print("Widget unmounted"),
              ),
              onPressed: () {},
            ),
            MySettingsTile(
              title: '自动切换黑暗模式',
              trailing: ValueBuilder<bool?>(
                initialValue: autoDarkMode.value,
                builder: (value, update) => Switch(
                  value: value!,
                  onChanged: (flag) => update(flag),
                  activeColor: Colors.green,
                ),
                onUpdate: (value) {
                  autoDarkMode.value = !autoDarkMode.value;
                  box.write('autoDarkMode', autoDarkMode.value);
                  debugPrint('autoDarkMode:${autoDarkMode.value}');
                },
                onDispose: () => print("Widget unmounted"),
              ),
              onPressed: () {},
            ),
            Obx(() => Offstage(
                  offstage: autoDarkMode.value,
                  child: MySettingsTile(
                    title: '黑暗模式',
                    trailing: ValueBuilder<bool?>(
                      initialValue: isDarkMode,
                      builder: (value, update) => Switch(
                        value: value!,
                        onChanged: (flag) => update(flag),
                        activeColor: Colors.green,
                      ),
                      onUpdate: (value) {
                        isDarkMode = !isDarkMode;
                        isDarkMode
                            ? Get.changeTheme(darkMode)
                            : Get.changeTheme(lightMode);
                      },
                      onDispose: () => print("Widget unmounted"),
                    ),
                    onPressed: () {},
                  ),
                )),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: const MyTrailing(text: '测试'),
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: const MyTrailing(text: '测试'),
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: const MyTrailing(text: '测试'),
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: const MyTrailing(text: '测试'),
              onPressed: () {},
            ),
          ]),
        ),
      ]),
    );
  }
}
