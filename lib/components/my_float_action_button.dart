import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFloatActionButton extends StatelessWidget {
  const MyFloatActionButton({super.key, required this.toPage});
  final Widget toPage;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (() => Get.to(() => toPage, transition: Transition.downToUp)),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // 关闭阴影
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.primary,
        size: 35,
      ),
    );
  }
}
