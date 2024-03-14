import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_text_divider.dart';
import 'package:xiao_note/models/marathon.dart';
import 'package:xiao_note/models/marathon_database.dart';
import 'package:xiao_note/pages/marathonPage/marathon_controller.dart';
import 'package:xiao_note/pages/marathonPage/my_floating_action_button.dart';
import 'package:xiao_note/pages/marathonPage/my_marathon_list_tile.dart';
import 'package:xiao_note/pages/marathonPage/new_marathon_page.dart';
// 这个版本的马拉松助手采用数据库存储，方便排序及修改
// TODO: 添加删除数据，页面不更新

class MarathonPage2 extends StatefulWidget {
  const MarathonPage2({
    super.key,
  });

  @override
  State<MarathonPage2> createState() => _MarathonPage2State();
}

class _MarathonPage2State extends State<MarathonPage2> {
  @override
  void initState() {
    super.initState();
    // 页面打开时读取所有赛事信息
    read();
  }

  // 初始化Controller读取输入框
  final textController = TextEditingController();
  // 初始化MarathonDatabase
  MarathonDatabase db = MarathonDatabase();

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
                        DateTime.now(), "起点", "终点", "酒店");
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
    return Scaffold(
      appBar: const MyAppBar(title: "马拉松助手"),
      body: Obx(() => ListView.builder(
            itemCount: db.AllMarathons.length,
            itemBuilder: (BuildContext context, int index) {
              final marathon = db.AllMarathons[index];
              return MyMarathonListTile(marathon: marathon);
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: (() =>
            Get.to(() => NewMarathonPage(), transition: Transition.downToUp)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
