import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputTextField extends StatelessWidget {
  const MyInputTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.text = '',
    this.focusNode,
    // this.labelText = ''
  });
  final TextEditingController controller;
  final String hintText;
  final String text;
  final FocusNode? focusNode;
  // final String labelText;

  @override
  Widget build(BuildContext context) {
    // var roundBorder = OutlineInputBorder(
    //   borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1),
    //   borderRadius: BorderRadius.circular(16),
    //   // borderSide: const BorderSide(style: BorderStyle.none)
    // );
    var noneBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    );
    // 设置初始文本
    if (text != '') {
      controller.text = text;
      // 将光标移动到文本的末尾
      controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: controller.text.length,
      ));
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      // autofocus: true,
      minLines: 1,
      maxLines: 5,
      cursorColor: Colors.lightGreen.shade700,
      // enableInteractiveSelection: false, //不允许复制粘贴，避免安卓出现水滴状图标

      decoration: InputDecoration(
        isCollapsed: true, //根据文字大小调整输入框高度
        contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        // * border 和 enabledBorder都配置才能实现圆角无边框
        border: noneBorder,
        enabledBorder: noneBorder,
        filled: true, // * 只有filled为true时，下面的fillColor才有效
        fillColor: Theme.of(context).colorScheme.primary,
        focusedBorder: noneBorder,
        suffixIcon: GestureDetector(
            child: const Icon(Icons.paste_rounded),
            onTap: () {
              FlutterClipboard.paste().then((value) {
                if (value.trim() == '') {
                  Get.snackbar("error", "剪贴板内容为空！");
                } else {
                  controller.text = value.trim();
                  Get.snackbar("success", "笔记快捷添加成功！",
                      duration: const Duration(seconds: 1));
                }
              });
            }),
        // hitText 和 labelText 同时存在有些问题
        hintText: hintText,
        hintStyle:
            TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        // labelText: labelText,
        // labelStyle:
        //     TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
