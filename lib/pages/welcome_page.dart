import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  text: "进入程序",
                  color: Colors.lightGreen[300],
                  onPressed: () {
                    GetStorage box = GetStorage();
                    box.write('isFirstRun', false);
                    // TODO 每次更新重写版本号
                    box.write('version', '240704');
                    box.write('buildNumber', 13);
                    box.write('buildName', '0.1.3');

                    if (!box.hasData('userName')) {
                      box.write('userName', 'Guest');
                    }
                    // 生成UUID
                    if (!box.hasData('uuid')) {
                      box.write('uuid', Tools.getUUID());
                    }

                    if (!box.hasData('autoDarkMode')) {
                      box.write('autoDarkMode', true);
                    }
                    if (!box.hasData('isDarkMode')) {
                      box.write('isDarkMode', false);
                    }

                    Get.offNamed('/dashboard');
                  }),
            ],
          ),
        ));
  }
}
