import 'package:cabbage/models/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// 初始化Controller读取输入框
final noteTextController = TextEditingController();
// 初始化NoteDatabase
final Database ndb = Get.find();

class NewNotePage extends StatelessWidget {
  const NewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    var roundBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(style: BorderStyle.none));
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "新笔记",
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.close,
                size: 30,
              )),
          actions: [
            // 右边确认按钮右边要空一点
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    // 将输入内容存入数据库
                    ndb.addNote(noteTextController.text);
                    // 清空文本框并返回
                    noteTextController.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done, size: 30)),
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
                // controller: controller,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        noteTextController.text =
                            '🔲 ${noteTextController.text}';
                      },
                      icon: const Icon(Icons.check_box_outlined)),
                  IconButton(
                      onPressed: () {
                        noteTextController.text =
                            '#️ ${noteTextController.text}';
                      },
                      icon: const Icon(Icons.numbers)),
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        final pickedImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedImage != null) {
                          // _updateSelectedImage(File(pickedImage.path));
                          // _saveImagePath(pickedImage.path);
                          noteTextController.text =
                              noteTextController.text + pickedImage.path;
                        }
                      },
                      icon: const Icon(Icons.photo_outlined)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.format_bold)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.alternate_email)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.undo_rounded)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.redo_rounded)),
                ],
              ),
            ],
          ),
        ));
  }
}
