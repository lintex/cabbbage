import 'package:cabbbage/components/my_bottom_sheet.dart';
import 'package:cabbbage/components/my_card_content.dart';
import 'package:cabbbage/components/my_circle_tool_button.dart';
import 'package:cabbbage/components/my_timeline_tile.dart';
import 'package:cabbbage/models/database.dart';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Get.find<Database>();
    TextEditingController controller = TextEditingController();

    return Theme(
      // 这段代码是为了去除persistentFooterButtons顶部一条分割线
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
          appBar: const MyAppBar(title: "时间线"),
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
                  Get.snackbar("success", "图片添加成功！");
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
              onPressed: () => Get.toNamed('/newNote'),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: GetBuilder<Database>(
                init: Database(),
                builder: (db) => ListView.builder(
                      itemCount: db.allNotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final currentNote = db.allNotes[index];
                        return MyTimelineTile(MyCardContent(note: currentNote));
                      },
                    )),
          )),
    );
  }
}
