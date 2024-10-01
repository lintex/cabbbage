import 'package:cabbbage/components/medium_sliver_appbar.dart';
import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_settings_tile.dart';
import 'package:cabbbage/components/my_trailing.dart';
import 'package:cabbbage/controllers/settings_controller.dart';
import 'package:cabbbage/theme/theme.dart';
import 'package:clipboard/clipboard.dart';
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
    // 控制子空间显示隐藏
    var isShow = true.obs;
    isShow.value = autoDarkMode.value;
    // SwitchController sxc = Get.put(SwitchController());

    TextEditingController controller = TextEditingController();

    return Scaffold(
      body: CustomScrollView(slivers: [
        // 显示自定义的SliverAppBar
        // const SliverAppBar.medium(
        //   title: Padding(
        //     padding: EdgeInsets.only(left: 10),
        //     child: Text("设置"),
        //   ),
        // ),
        _buildSliverBar(),
        _buildTitleText(),
        _buildSliverSearch(context),
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

Widget _buildSliverBar() {
  const Icon icon = Icon(CupertinoIcons.settings, color: Colors.blue);
  const TextStyle style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  const Text text = Text('Settings', style: style);
  Widget action = IconButton(onPressed: () {}, icon: icon);
  return SliverLayoutBuilder(builder: (_, scs) {
    double factor = (scs.scrollOffset / kToolbarHeight).clamp(0, 1);
    factor = factor < 0.2 ? 0 : factor;
    AppBar header = AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      actions: [action],
      centerTitle: true,
      title: Opacity(opacity: factor, child: text),
    );
    return PinnedHeaderSliver(child: header);
  });
}

Widget _buildTitleText() {
  const TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  const Text text = Text('Settings', style: style);
  return const SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: 12.0, bottom: 8),
      child: text,
    ),
  );
}

Widget _buildSliverSearch(BuildContext context) {
  BoxDecoration decoration = BoxDecoration(
      color: const Color(0xffefeff1), borderRadius: BorderRadius.circular(6));
  Widget prefix = const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Icon(CupertinoIcons.search, size: 20, color: Color(0xff808082)));
  return PinnedHeaderSliver(
      child: ColoredBox(
    color: Theme.of(context).colorScheme.primary,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 12, left: 12),
          child: CupertinoTextField(
            readOnly: true,
            placeholder: '搜索',
            onTap: () {},
            decoration: decoration,
            prefix: prefix,
            style: const TextStyle(fontSize: 14),
            placeholderStyle: const TextStyle(color: Color(0xff808082)),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        const Divider(),
      ],
    ),
  ));
}
