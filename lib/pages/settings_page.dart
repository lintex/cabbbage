import 'package:cabbage/components/my_bottom_sheet.dart';
import 'package:cabbage/components/my_divider.dart';
import 'package:cabbage/components/my_settings_tile.dart';
import 'package:cabbage/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取 userName
    final SettingsController sc = Get.find();
    // 读取UUID
    GetStorage box = GetStorage();
    String uuid = box.read('uuid');

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
                  trailing: sc.userName.value,
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
              trailing: '${uuid.substring(0, 8)}...',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              trailing: '测试',
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
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
            MySettingsTile(
              title: '测试',
              subtitle: '测试！！！！',
              trailing: '测试',
              onPressed: () {},
            ),
          ]),
        ),
      ]),
    );
  }
}
