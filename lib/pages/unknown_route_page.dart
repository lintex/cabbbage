import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
                    BetterFeedback.of(context)
                        .show((UserFeedback feedback) async {
                      // draft an email and send to developer
                      final screenshotFilePath =
                          await Tools.writeImageToStorage(feedback.screenshot);

                      final Email email = Email(
                        body: feedback.text,
                        subject: 'Cabbbage Feedback',
                        recipients: ['cabbbage@qq.com'],
                        attachmentPaths: [screenshotFilePath],
                        isHTML: false,
                      );
                      String platformResponse;
                      try {
                        await FlutterEmailSender.send(email);
                        platformResponse = 'success';
                      } catch (error) {
                        debugPrint(error.toString());
                        platformResponse = error.toString();
                      }
                      if (platformResponse == 'success') {
                        Get.snackbar("Thanks", "感谢你的反馈!");
                      }
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
