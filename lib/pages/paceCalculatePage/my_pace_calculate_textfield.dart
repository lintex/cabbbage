import 'package:flutter/material.dart';

class MyPaceCalculateTextField extends StatelessWidget {
  const MyPaceCalculateTextField(
      {super.key, required this.text, required this.controller});
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (controller.text == "0") {
          controller.text = "";
        }
      },
      onTapOutside: (event) {
        if (controller.text == "") {
          controller.text = "0";
        }
      },

      // onChanged: (value) {
      //   setState(() {
      //     if (int.parse(value) > 6) {
      //       _hourErrorText = value;
      //     } else {
      //       _hourErrorText = '';
      //     }
      //   });
      // },
      controller: controller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.go,

      // errorText:_hourErrorText.isEmpty ? null : "6小时关门"

      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
        // 直接设置border 不起作用
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        labelText: text,
        labelStyle: const TextStyle(color: Colors.black45),
        // hintStyle: const TextStyle(color: Colors.green),
      ),
    );
  }
}
