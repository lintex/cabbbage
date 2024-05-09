import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbage/components/marquee_widget.dart';
import 'package:cabbage/components/my_dashboard_tile.dart';
import 'package:cabbage/components/my_drawer.dart';
import 'package:cabbage/models/marathon.dart';

import 'package:cabbage/models/database.dart';
import 'package:cabbage/pages/marathon_page2.dart';
import 'package:cabbage/pages/note_page.dart';
import 'package:cabbage/tools/tools.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Get.put(Database());
    // 获取马拉松数据，显示还未过期三条记录
    db.fetchMarathons();
    List loopList = [].obs;
    debugPrint("列表长度为：${db.stillMarathons.length}");
    loopList = db.stillMarathons;

    // 读取最后一条note，读取数据存储在db.lastNote，已经是obs
    db.fetchLastNote();

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              Tools.getTitle(),
              style: const TextStyle(fontSize: 18),
            )),
        drawer: const MyDrawer(),
        body: Obx(
          () => ListView(
            children: [
              GestureDetector(
                onTap: () => Get.to(() => const MarathonPage2()),
                child: MyDashboardTile(
                  child: Column(
                      children: loopList
                          .map((m) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          textAlign: TextAlign.right,
                                          Tools.diffDays(m.time!),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'DigitalNumbers',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' 天 距离 ',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                      ),
                                      Text(m.name)
                                    ]),
                              ))
                          .toList()

                      // if (loopList.isNotEmpty) ...[
                      //   // Marathon m = loopList[index];
                      //   //设置所有子控件字体样式
                      //   DefaultTextStyle(
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         color:
                      //             Theme.of(context).colorScheme.inversePrimary),
                      //     //循环显示还有多少天
                      //     child: Row(
                      //       children: [
                      //         Text("${m.name}还有"),
                      //         Text(
                      //           Tools.diffDays(m.time!),
                      //           style: const TextStyle(
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         const Text("天")
                      //       ],
                      //     ),
                      //   )
                      // ] else ...[
                      //   DefaultTextStyle(
                      //       style: TextStyle(
                      //           fontSize: 16,
                      //           color: Theme.of(context)
                      //               .colorScheme
                      //               .inversePrimary),
                      //       child: const Row(children: [Text("最近没有马拉松比赛...")]))
                      // ]

                      ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => const NotePage()),
                child: MyDashboardTile(
                  child: Obx(() => Text(db.lastNote.value)),
                ),
              ),
              const MyDashboardTile(
                child: Text("Test"),
              ),
              const MyDashboardTile(
                child: Text("Test"),
              ),
              const MyDashboardTile(
                child: Text("Test"),
              ),
            ],
          ),
        ));
  }
}
