import 'package:flutter/material.dart';

class MyTextField2 extends StatelessWidget {
  const MyTextField2(
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
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(style: BorderStyle.none));

    return TextField(
      controller: controller,
      autofocus: true,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        isCollapsed: true, //根据文字大小调整输入框高度
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
        // * border 和 enabledBorder都配置才能实现圆角无边框
        border: roundBorder,
        enabledBorder: roundBorder,
        filled: true, // * 只有filled为true时，下面的fillColor才有效
        fillColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade600, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
