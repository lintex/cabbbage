import 'package:cabbage/components/my_float_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbage/components/my_app_bar.dart';
import 'package:cabbage/components/my_text_divider.dart';
import 'package:cabbage/models/marathon.dart';
import 'package:cabbage/models/database.dart';
import 'package:cabbage/pages/marathonPage/marathon_detail_page.dart';
import 'package:cabbage/pages/marathonPage/my_marathon_list_tile.dart';
import 'package:cabbage/pages/marathonPage/new_marathon_page.dart';
// 这个版本的马拉松助手采用数据库存储，方便排序及修改

class MarathonPage2 extends StatefulWidget {
  const MarathonPage2({
    super.key,
  });

  @override
  State<MarathonPage2> createState() => _MarathonPage2State();
}

class _MarathonPage2State extends State<MarathonPage2> {
  @override
  initState() {
    super.initState();
    // 页面打开时读取所有赛事信息
    read();
  }

  // 初始化Controller读取输入框
  final textController = TextEditingController();
  // 使用Get.put()实例化你的类，使其对当下的所有子路由可用
  Database db = Get.put(Database());
  // 读取所有比赛信息
  void read() {
    db.fetchMarathons();
  }

  // 修改比赛信息
  void update(Marathon marathon) {
    textController.text = marathon.name;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("更新比赛数据"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    db.updateMarathon(marathon.id, textController.text,
                        DateTime.now(), "起点", "终点", "酒店", "领物点");
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("更新"),
                ),
              ],
            ));
  }

  // 删除比赛
  void delete(int id) {
    db.deleteMarathon(id);
  }

  @override
  Widget build(BuildContext context) {
    // read(); // 修改后界面不更新，不知道怎么回事
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
          // 【按钮】修改比赛信息
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(shrinkWrap: true, children: <Widget>[
          Flex(direction: Axis.horizontal, children: <Widget>[
            //这一行Flex不要，会报错“Incorrect use of ParentDataWidget.”
            Expanded(
              child: Obx(() => ListView.builder(
                    shrinkWrap: true, //这一行不要列表无法显示
                    physics: const NeverScrollableScrollPhysics(), //不要无法滚动
                    itemCount: db.allMarathons.length,
                    itemBuilder: (BuildContext context, int index) {
                      final marathon = db.allMarathons[index];
                      return GestureDetector(
                        onTap: () => Get.to(
                            () => MarathonDetailPage(marathon: marathon)),
                        child: MyMarathonListTile(marathon: marathon),
                      );
                    },
                  )),
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
      // floatingActionButton: MyFloatActionButton(toPage: NewMarathonPage()),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
