import 'package:cabbbage/components/empty_listview.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_text_divider.dart';
import 'package:cabbbage/models/database.dart';
import 'package:cabbbage/pages/marathonPage/my_marathon_list_tile.dart';
// 这个版本的马拉松助手采用数据库存储，方便排序及修改

class MarathonPage2 extends StatelessWidget {
  const MarathonPage2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Database db = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '马拉松比赛助手',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
        actions: [
          // 【按钮】添加比赛信息
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () => Get.toNamed('/newMarathon'),
                icon: const Icon(
                  Icons.add,
                  size: 30,
                )),
          )
        ],
      ),
      body: EmptyListView(
        items: db.allMarathons,
        onPressed: () => Get.toNamed('/newMarathon'),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(shrinkWrap: true, children: <Widget>[
            Flex(direction: Axis.horizontal, children: <Widget>[
              //这一行Flex不要，会报错“Incorrect use of ParentDataWidget.”
              Expanded(
                child: GetBuilder<Database>(
                  builder: (db) => ListView.builder(
                    shrinkWrap: true, //这一行不要列表无法显示
                    physics: const NeverScrollableScrollPhysics(), //不要无法滚动
                    itemCount: db.allMarathons.length,
                    itemBuilder: (BuildContext context, int index) {
                      final marathon = db.allMarathons[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed('/marathonDetail',
                            arguments: db.allMarathons[index]),
                        child: MyMarathonListTile(marathon: marathon),
                      );
                    },
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 30,
            ),
            const MyTextDivider(text: "🏃‍♀️跑起来就有风"),
            const SizedBox(
              height: 80,
            ),
          ]),
        ),
      ),
    );
  }
}
