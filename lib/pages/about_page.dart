import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:cabbbage/components/my_button.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
// 读取系统版本号

Future<String> getAppVersion() async {
  final info = await PackageInfo.fromPlatform();
  // 读取版本号
  GetStorage box = GetStorage();
  String version = box.read('version');
  return '${info.version}.$version';
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle greyText = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
      fontSize: 12,
    );
    TextStyle underlineText = TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
        fontSize: 12,
        decoration: TextDecoration.underline);

    // final SettingsController sc = Get.find();

    // 点击次数
    int clickTimes = 1;

    return Scaffold(
        appBar: const MyAppBar(title: "关于"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 40),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 95,
                      ),
                      // 点击7次跳转到管理界面
                      GestureDetector(
                        onTap: () => clickTimes == 7
                            ? Get.toNamed('/manage')
                            : clickTimes++,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 70,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("再菜也要用心卷",
                          style: TextStyle(fontFamily: '字语相思体', fontSize: 28)),
                      const SizedBox(height: 15),
                      // 通过FutureBuilder执行异步方法，获取版本号
                      FutureBuilder(
                        future: getAppVersion(), // 启动异步方法
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // 如果数据已经获取完成，显示数据
                            if (snapshot.hasData) {
                              return Text(
                                "开笔记 ${snapshot.data}",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              // 如果有错误，显示错误信息
                              return Text('发生错误: ${snapshot.error}');
                            }
                          }
                          // 数据获取过程中显示的加载提示
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyButton(
                          text: "检查更新",
                          color: Colors.lightGreen,
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
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Copyright ©️ 2024 SmallWest Software. All rights reserved.",
                      style: greyText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "ICP备案号：鄂B2-20240059-1745A",
                      style: greyText,
                    ),
                    const SizedBox(
                      height: 5,
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
