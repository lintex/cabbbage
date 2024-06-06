import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbage/components/my_text_divider.dart';
import 'package:cabbage/models/database.dart';
import 'package:cabbage/pages/marathonPage/marathon_detail_page.dart';
import 'package:cabbage/pages/marathonPage/my_marathon_list_tile.dart';
import 'package:cabbage/pages/marathonPage/new_marathon_page.dart';
// 这个版本的马拉松助手采用数据库存储，方便排序及修改

class MarathonPage2 extends StatelessWidget {
  const MarathonPage2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Get.to(() => NewMarathonPage()),
                icon: const Icon(
                  Icons.add,
                  size: 30,
                )),
          )
        ],
      ),
      body: SizedBox(
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
                      onTap: () => Get.to(
                          () => MarathonDetailPage(
                                index: index,
                              ),
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
    );
  }
}
