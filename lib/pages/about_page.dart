import 'package:flutter/material.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle greyText = const TextStyle(
      color: Colors.black54,
      fontSize: 12,
    );
    TextStyle underlineText = const TextStyle(
        color: Colors.black54,
        fontSize: 12,
        decoration: TextDecoration.underline);
    return Scaffold(
        appBar: const MyAppBar(title: "关于"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 30),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 95,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: 70,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("再菜也要用心卷",
                          style: TextStyle(fontFamily: '字语相思体', fontSize: 28)),
                      const SizedBox(height: 15),
                      const Text(
                        "卷心菜 0.0.1",
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyButton(
                          text: "检查更新",
                          color: Colors.green[300]!,
                          onPressed: () {}),
                      // Image.asset(
                      //   "assets/images/about.jpg",
                      //   width: 200,
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "小西软件 版权所有",
                      style: greyText,
                    ),
                    Text(
                      "Copyright ©️ 2024 SmallWest Software. All rights reserved.",
                      style: greyText,
                    ),
                    Text(
                      "ICP备案号：鄂B2-20240059-1745A",
                      style: greyText,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "用户协议",
                          style: underlineText,
                        ),
                        Text(
                          " · ",
                          style: greyText,
                        ),
                        Text(
                          "隐私政策",
                          style: underlineText,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}