import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/models/note.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_tools_bar.dart';

// 初始化Controller读取输入框
final noteTextController = TextEditingController();
// 初始化NoteDatabase
final Database ndb = Get.find();

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    noteTextController.text = note.text;
    var roundBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(style: BorderStyle.none));
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "修改笔记",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 30,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: "top",
                      child: Row(
                        children: [
                          Icon(Icons.publish_outlined),
                          Text("置顶"),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "share",
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined),
                          Text("分享"),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "copy",
                      child: Row(
                        children: [
                          Icon(Icons.copy_rounded),
                          Text("复制内容"),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "save",
                      child: Row(
                        children: [
                          Icon(Icons.save_outlined),
                          Text("保存"),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline),
                          Text("删除"),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (Object object) {
                  switch (object) {
                    case 'top':
                      ndb.setTopNote(note.id);
                      Get.snackbar("success", "笔记置顶成功！");
                      break;
                    case 'copy':
                      FlutterClipboard.copy(noteTextController.text)
                          .then((value) => debugPrint('copied'));
                      Get.snackbar("success", "笔记内容复制成功！");
                      break;
                    case 'save':
                      ndb.updateNote(note.id, noteTextController.text);
                      noteTextController.clear();
                      Navigator.pop(context);
                      break;
                    case 'delete':
                      ndb.deleteNote(note.id);
                      noteTextController.clear();
                      Navigator.pop(context);
                      break;
                  }
                },
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide.none,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              TextField(
                controller: noteTextController,
                autofocus: true,
                minLines: 5,
                maxLines: 10,
                onChanged: (v) {
                  // 输入改变时将内容存入数据库
                  ndb.updateNote(note.id, v);
                },
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  isCollapsed: true, //根据文字大小调整输入框高度
                  contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  // * border 和 enabledBorder都配置才能实现圆角无边框
                  border: roundBorder,
                  enabledBorder: roundBorder,
                  filled: true, // * 只有filled为true时，下面的fillColor才有效
                  fillColor: Theme.of(context).colorScheme.primary,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green.shade200, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  // hitText 和 labelText 同时存在有些问题
                  hintText: "现在的想法是...",
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  // labelText: labelText,
                  // labelStyle:
                  //     TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
              MyToolsBar(noteTextController: noteTextController),
            ],
          ),
        ));
  }
}
