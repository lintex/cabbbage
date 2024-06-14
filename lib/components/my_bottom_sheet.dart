import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet(
      {super.key,
      required this.title,
      required this.text,
      required this.onPressed,
      required this.controller});
  final String title, text;
  final void Function() onPressed;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      height: 220,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: controller,
            text: text,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: MyButton(text: "取消", onPressed: () => Get.back())),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: MyButton(
                      text: "确定",
                      color: Colors.lightGreen[700],
                      textColor: Colors.white,
                      onPressed: onPressed)),
            ],
          ),
        ],
      ),
    );
  }
}
