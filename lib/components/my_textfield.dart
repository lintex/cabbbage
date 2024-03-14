import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    //this.labelText = ""
  });
  final TextEditingController controller;
  final String hintText;
  //final String labelText;

  @override
  Widget build(BuildContext context) {
    var roundBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(style: BorderStyle.none));

    return TextField(
      controller: controller,
      autofocus: true,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        isCollapsed: true, //根据文字大小调整输入框高度
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
        // * border 和 enabledBorder都配置才能实现圆角无边框
        border: roundBorder,
        enabledBorder: roundBorder,
        filled: true, // * 只有filled为true时，下面的fillColor才有效
        fillColor: const Color.fromARGB(255, 230, 230, 230),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 83, 83, 83)),
        //labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
