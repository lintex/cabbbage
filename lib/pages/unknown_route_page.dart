import 'package:cabbbage/components/my_button.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:get/get.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "路由错误"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.remove_circle_outline_rounded,
                size: 80,
                color: Colors.lightGreen.shade700,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                '页面不存在',
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                  child: Text(
                    "点击反馈",
                    style: TextStyle(color: Colors.lightGreen.shade900),
                  ),
                  onPressed: () {
                    BetterFeedback.of(context).show((UserFeedback feedback) {
                      // Do something with the feedback
                    });
                  }),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                text: "返回",
                onPressed: () => Get.back(),
                color: Colors.lightGreen.shade200,
              ),
            ],
          ),
        ));
  }
}
