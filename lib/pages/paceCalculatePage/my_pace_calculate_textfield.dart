import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      onChanged: (value) {
        if (value.isNotEmpty && RegExp(r'^\d+$').hasMatch(value)) {
          if (int.parse(value) > 59) {
            controller.text = "59";
          }
        } else {
          controller.text = '';
          Get.snackbar("error", "只能输入数字！");
        }
      },
      controller: controller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.go,

      // errorText:_hourErrorText.isEmpty ? null : "6小时关门"

      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
        // 直接设置border 不起作用
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        labelText: text,
        labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        // hintStyle: const TextStyle(color: Colors.green),
      ),
    );
  }
}
