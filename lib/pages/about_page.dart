import 'package:flutter/material.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "关于"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 30),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 70,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("一个又卷又菜的APP",
                    style: TextStyle(fontFamily: '字语相思体', fontSize: 28)),
                const SizedBox(height: 15),
                const Text(
                  "1.0.1",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                    text: "检查更新", color: Colors.green[300]!, onPressed: () {})
                // Image.asset(
                //   "assets/images/about.jpg",
                //   width: 200,
                // ),
              ],
            ),
          ),
        ));
  }
}
