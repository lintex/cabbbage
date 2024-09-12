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
    // 显示和折叠过期马拉松比赛
    var showExpiredMarathon = true.obs;
    var noChosenMarathon = true.obs;
    // 控制子空间显示隐藏
    var isShow = true.obs;
    isShow.value = showExpiredMarathon.value;
    var isShow2 = true.obs;
    isShow2.value = noChosenMarathon.value;
    // 动画控制过期比赛前的箭头旋转，这个地方不用0.5的话会乱转
    var turns = 0.5.obs;
    var turns2 = 0.5.obs;

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
              height: 20,
            ),
            ExpiredMarathonTitle(
                title: '未中签比赛',
                turns: turns2,
                isShow: isShow2,
                showMarathon: noChosenMarathon,
                count: db.noChosenMarathons.length.toString()),
            ExpiredMarathonList(
              offstage: noChosenMarathon,
              isShow: isShow2,
              marathons: db.noChosenMarathons,
            ),
            const SizedBox(
              height: 20,
            ),
            ExpiredMarathonTitle(
                title: '已过期比赛',
                turns: turns,
                isShow: isShow,
                showMarathon: showExpiredMarathon,
                count: db.expiredMarathons.length.toString()),
            ExpiredMarathonList(
              offstage: showExpiredMarathon,
              isShow: isShow,
              marathons: db.expiredMarathons,
            ),
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

class ExpiredMarathonList extends StatelessWidget {
  const ExpiredMarathonList({
    super.key,
    required this.offstage,
    required this.isShow,
    required this.marathons,
  });

  final RxBool offstage;
  final RxBool isShow;
  final List<dynamic> marathons;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Offstage(
          offstage: offstage.value,
          child: AnimatedOpacity(
            opacity: isShow.value ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Flex(direction: Axis.horizontal, children: <Widget>[
              //这一行Flex不要，会报错“Incorrect use of ParentDataWidget.”
              Expanded(
                child: GetBuilder<Database>(
                  builder: (db) => ListView.builder(
                    shrinkWrap: true, //这一行不要列表无法显示
                    physics: const NeverScrollableScrollPhysics(), //不要无法滚动
                    itemCount: marathons.length,
                    itemBuilder: (BuildContext context, int index) {
                      final marathon = marathons[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed('/marathonDetail',
                            arguments: marathons[index]),
                        child: MyMarathonListTile(marathon: marathon),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

class ExpiredMarathonTitle extends StatelessWidget {
  const ExpiredMarathonTitle({
    super.key,
    required this.turns,
    required this.isShow,
    required this.showMarathon,
    required this.count,
    required this.title,
  });
  final String title;
  final RxDouble turns;
  final RxBool isShow;
  final RxBool showMarathon;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: GestureDetector(
        onTap: () {
          //让箭头往返转，而不是循环转 // 实现箭头icon旋转
          if (turns.value < 1) {
            turns.value += 1 / 2;
          } else {
            turns.value -= 1 / 2;
          }
          isShow.value = !showMarathon.value;
          if (showMarathon.value == false) {
            Future.delayed(const Duration(milliseconds: 300)).then((val) {
              debugPrint('延时300毫秒');
              showMarathon.value = !showMarathon.value;
            });
          } else {
            showMarathon.value = !showMarathon.value;
          }
        },
        child: Row(
          children: [
            // 点击时上下箭头切换，并使用动画
            Obx(() => AnimatedRotation(
                  turns: turns.value,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                )),
            const SizedBox(
              width: 3,
            ),
            Text(
              title,
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              count,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
