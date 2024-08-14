import 'package:cabbbage/components/my_button.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Get.find();

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
                    // 写入马拉松默认数据
                    if (db.allMarathons.isEmpty) {
                      db.addMarathon('2024北京马拉松', DateTime(2024, 10, 27, 7, 30),
                          '天安门广场', '鸟巢', '', '', '', 0);
                      db.addMarathon('2024上海马拉松', DateTime(2024, 12, 1, 7, 30),
                          '', '', '', '', '', 0);
                      db.addMarathon('2024广州马拉松', DateTime(2024, 12, 8, 7, 30),
                          '', '', '', '', '', 0);
                    }
                    // 写入笔记note默认数据
                    if (db.allMarathons.isEmpty) {
                      db.addNote(
                          '人生就是场体验，请尽兴点！把烦心事都丢掉，腾出地方来装鲜花，夜光，银河，星光和你爱的人。');
                      db.addNote('教育之道无他，唯爱和榜样而已。真正觉醒的家庭，只改变自己，不改变孩子。');
                      db.addNote('谁终将声震人间，必长久深自缄默。谁终将点燃闪电，必长久如云漂泊。');
                    }
                    Get.offNamed('/dashboard');
                  }),
            ],
          ),
        ));
  }
}
