import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/components/my_card_content.dart';
import 'package:cabbbage/components/my_divider.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/models/note.dart';
import 'package:cabbbage/pages/notePage/edit_note_page.dart';
import 'package:cabbbage/theme/theme.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 60,
        width: double.infinity,
        //alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(20, 12, 20, 10),
        padding: const EdgeInsets.fromLTRB(15, 8, 8, 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          //border: Border.all(width: 1),
          borderRadius: BorderRadius.all(Radius.circular(11)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2.0, 2.0),
              blurRadius: 10.0,
            )
          ],
          // gradient: const LinearGradient(
          //   colors: [Colors.red, Colors.orange],
          // ),
        ),
        //transform: Matrix4.rotationZ(0.02)
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => EditNotePage(note: note)),
              onLongPress: () {
                Get.bottomSheet(Container(
                  padding: const EdgeInsets.all(25),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: MyButton(
                              text: "分享", onPressed: () => Get.back())),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          child: MyButton(
                              text: "复制",
                              onPressed: () {
                                FlutterClipboard.copy(note.text).then((value) =>
                                    debugPrint(
                                        'The contents of the note have been copied！'));
                                Get.back();
                                Get.snackbar("success", "笔记内容已复制到剪贴板！");
                              })),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          child: MyButton(
                              text: "删除",
                              textColor: Colors.red[300],
                              onPressed: () {
                                Get.find<Database>().deleteNote(note.id);
                                Get.back();
                                Get.snackbar("success", "${note.text}删除成功！");
                              })),
                      const MyDivider(),
                      SizedBox(
                          width: double.infinity,
                          child: MyButton(
                              text: "取消", onPressed: () => Get.back())),
                    ],
                  ),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: MyCardContent(note: note),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    note.cabId == 255
                        ? const PopupMenuItem(
                            value: "cancelSetTop",
                            child: Text("取消置顶"),
                          )
                        : const PopupMenuItem(
                            value: "setTop",
                            child: Text("置顶"),
                          ),
                    const PopupMenuItem(
                      value: "share",
                      child: Text("分享"),
                    ),
                  ];
                },
                onSelected: (Object object) {
                  switch (object) {
                    case "setTop":
                      ndb.setTopNote(note.id);
                      Get.snackbar("success", "笔记置顶成功！");
                      break;
                    case "cancelSetTop":
                      ndb.cancelTopNote(note.id);
                      Get.snackbar("success", "笔记取消置顶成功！");
                      break;
                    case "share":
                      // 分享笔记
                      break;
                    default:
                  }
                },
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide.none,
                ),
                // 下面只能用child，不能用icon不然会有默认边距，而且去不掉
                child: note.cabId == 255
                    ? Icon(
                        Icons.push_pin,
                        color: grey,
                        size: 15,
                      )
                    : Icon(
                        Icons.more_vert,
                        color: grey,
                        size: 15,
                      ),
              ),
            ),
          ],
        ));
  }
}
