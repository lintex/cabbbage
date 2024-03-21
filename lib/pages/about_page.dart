import 'package:flutter/material.dart';
import 'package:xiao_note/components/my_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "关于"),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 100,
            ),
            const Text("又卷又菜的APP"),
            Image.asset(
              "assets/images/about.jpg",
              width: 200,
            ),
          ],
        ));
  }
}
