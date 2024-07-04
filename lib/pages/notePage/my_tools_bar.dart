import 'package:cabbbage/models/database.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyToolsBar extends StatelessWidget {
  const MyToolsBar({super.key, required this.controller, required this.noteId});
  final TextEditingController controller;
  final int noteId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              controller.text = '🔲 ${controller.text}';
            },
            icon: const Icon(Icons.check_box_outlined)),
        IconButton(
            onPressed: () {
              String inputText = controller.text;
              String selectText = controller.selection.textInside(inputText);
              int start = controller.selection.start;
              int end = controller.selection.end;
              controller.text =
                  '${inputText.substring(0, start)}**$selectText**${inputText.substring(end)}';
            },
            icon: const Icon(Icons.numbers)),
        IconButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                // _updateSelectedImage(File(pickedImage.path));
                // _saveImagePath(pickedImage.path);
                controller.text = controller.text + pickedImage.path;
              }
            },
            icon: const Icon(Icons.photo_outlined)),
        IconButton(
            onPressed: () {
              String inputText = controller.text;
              String selectText = controller.selection.textInside(inputText);
              int start = controller.selection.start;
              int end = controller.selection.end;
              controller.text =
                  '${inputText.substring(0, start)}`$selectText`${inputText.substring(end)}';
            },
            icon: const Icon(CupertinoIcons.paintbrush)),
        IconButton(
            onPressed: () {
              FlutterClipboard.paste().then((value) {
                // 获取剪贴板数据
                controller.text += value;
              });
              // ? 粘贴后TextField的onChange事件没有触发
            },
            icon: const Icon(Icons.paste_rounded)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.undo_rounded)),
        noteId == 0
            ? const Icon(Icons.favorite)
            : IconButton(
                onPressed: () {
                  Get.find<Database>().updateNote(noteId, controller.text);
                  controller.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.paperplane)),
      ],
    );
  }
}
