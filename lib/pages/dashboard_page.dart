import 'package:cabbbage/components/my_circle_tool_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_dashboard_tile.dart';
import 'package:cabbbage/components/my_drawer.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/tools/tools.dart';

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

    return Theme(
      // 这段代码是为了去除persistentFooterButtons顶部一条分割线
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              Tools.getTitle(),
              style: const TextStyle(fontSize: 18),
            )),
        drawer: const MyDrawer(),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          MyCircleToolButton(
            icon: Icons.image_outlined,
            onPressed: () {},
          ),
          MyCircleToolButton(
            icon: Icons.check_box_outlined,
            onPressed: () {},
          ),
          MyCircleToolButton(
            icon: Icons.paste_rounded,
            iconSize: 24,
            onPressed: () {},
          ),
          MyCircleToolButton(
            icon: Icons.add_rounded,
            iconSize: 32,
            onPressed: () {},
          ),
        ],
        body: Obx(
          () => Column(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/marathon'),
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
                          .toList()),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed('note'),
                child: MyDashboardTile(
                  child: Obx(() => Text(db.lastNote.value)),
                ),
              ),
              MyDashboardTile(
                child: Text('hello'.tr),
              ),
              MyDashboardTile(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 200,
                        height: 100,
                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.secondary),
                        child: Center(child: Text("data$index")),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
