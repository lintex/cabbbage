import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_card_content.dart';
import 'package:cabbbage/components/my_circle_tool_button.dart';
import 'package:cabbbage/pages/dashboardPage/my_dashboard_marathon_tile.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_dashboard_tile.dart';
import 'package:cabbbage/components/my_drawer.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:image_picker/image_picker.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Get.put(Database());
    // 获取马拉松数据，显示还未过期三条记录
    db.fetchMarathons();
    TextEditingController controller = TextEditingController();
    // 读取最后一条note，读取数据存储在db.lastNote，已经是obs
    db.fetchLastNote();

    return Theme(
      // 这段代码是为了去除persistentFooterButtons顶部一条分割线
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              Tools.getTitle(),
              style: const TextStyle(fontSize: 18),
            )),
        drawer: const MyDrawer(),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          // 选择图片按钮
          MyCircleToolButton(
            icon: Icons.image_outlined,
            onPressed: () async {
              final pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                // _updateSelectedImage(File(pickedImage.path));
                // _saveImagePath(pickedImage.path);
                debugPrint('pickedImage:${pickedImage.path}');
                db.addNote(pickedImage.path, cabId: 8);
                Get.back();
              }
            },
          ),
          // 添加todo按钮
          MyCircleToolButton(
            icon: Icons.check_box_outlined,
            onPressed: () {
              Get.bottomSheet(MyBottomSheet(
                title: '添加待办',
                text: '',
                controller: controller,
                onPressed: () {
                  db.addNote(controller.text, cabId: 0);
                  controller.clear();
                  Get.back();
                },
              ));
            },
          ),
          // 剪贴板按钮
          MyCircleToolButton(
            icon: Icons.paste_rounded,
            onPressed: () {
              FlutterClipboard.paste().then((value) {
                if (value.trim() == '') {
                  Get.snackbar("error", "剪贴板内容为空！");
                } else {
                  db.addNote(value);
                  Get.snackbar("success", "笔记快捷添加成功！");
                }
              });
            },
          ),
          MyCircleToolButton(
            icon: CupertinoIcons.add,
            onPressed: () {},
          ),
        ],
        body: Obx(
          () => Column(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/marathon'),
                child: MyDashboardTile(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                    child: Column(
                        children: db.stillMarathons
                            .map((m) => MyDashboardMarathonTile(marathon: m))
                            .toList()),
                  ),
                ),
              ),
              MyDashboardTile(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('hello'.tr),
                ),
              ),
              MyDashboardTile(
                child: SizedBox(
                  height: 200,
                  child: Obx(() => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: db.lastNotes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 200,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color:
                                    const Color.fromARGB(255, 241, 240, 231)),
                            child: MyCardContent(note: db.lastNotes[index]),
                          );
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
