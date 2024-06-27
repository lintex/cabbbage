import 'package:flutter/material.dart';

class MyTextFieldWithLabel extends StatelessWidget {
  const MyTextFieldWithLabel(
      {super.key,
      required this.controller,
      this.hintText = '',
      this.labelText = ''});
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    var roundBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(style: BorderStyle.none));

    return TextField(
      controller: controller,
      autofocus: true,
      cursorColor: Colors.lightGreen.shade700,
      enableInteractiveSelection: false, //不允许复制粘贴，避免安卓出现水滴状图标
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
        labelText: labelText,
        labelStyle:
            TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
