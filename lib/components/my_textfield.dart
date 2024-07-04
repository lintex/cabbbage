import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.text = '',
    // this.labelText = ''
  });
  final TextEditingController controller;
  final String hintText;
  final String text;
  // final String labelText;

  @override
  Widget build(BuildContext context) {
    var roundBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(style: BorderStyle.none));
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
      autofocus: true,
      minLines: 1,
      maxLines: 5,
      cursorColor: Colors.lightGreen.shade700,
      // enableInteractiveSelection: false, //不允许复制粘贴，避免安卓出现水滴状图标

      decoration: InputDecoration(
        isCollapsed: true, //根据文字大小调整输入框高度
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
        // * border 和 enabledBorder都配置才能实现圆角无边框
        border: roundBorder,
        enabledBorder: roundBorder,
        filled: true, // * 只有filled为true时，下面的fillColor才有效
        fillColor: Theme.of(context).colorScheme.primary,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreen, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
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
