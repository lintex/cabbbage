import 'package:cabbbage/components/my_badge.dart';
import 'package:cabbbage/pages/marathonPage/marathon_func.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:cabbbage/models/marathon.dart';
import 'package:cabbbage/models/database.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyMarathonListTile extends StatelessWidget {
  MyMarathonListTile({super.key, required this.marathon});
  // 使用Get找到主页面使用的Controller
  final Database db = Get.find();
  final Marathon marathon;
  // 读取所有比赛信息
  void read() {
    db.fetchMarathons();
  }

  // 删除比赛
  void delete(int id) {
    db.deleteMarathon(id);
  }

  @override
  Widget build(BuildContext context) {
    // 还剩多少天
    int stillDays = marathon.time!.difference(DateTime.now()).inDays.abs();
    int stillMinutes = marathon.time!.difference(DateTime.now()).inMinutes;
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          // 删除按钮
          SlidableAction(
            onPressed: (e) {
              delete(marathon.id);
            },
            icon: Icons.highlight_remove_rounded,
            backgroundColor: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //根据天数改变背景色
              color: stillMinutes < 0
                  ? Theme.of(context).colorScheme.primary
                  : marathon.isChosen != 2 // 根据是否中签改变背景色
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.error),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 显示马拉松名称及中签状态，“未报名”状态不显示文字
                      chosenState(marathon.isChosen) == '未报名'
                          ? _marathonName()
                          : MyBadge(
                              isChosen: marathon.isChosen,
                              child: _marathonName()),

                      const SizedBox(
                        height: 5,
                      ),
                      // 显示马拉松举办时间和地点
                      Text(
                        getDateAndLocation(marathon.time!,
                            marathon.start == '' ? '' : ' | ${marathon.start}'),
                        style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                  // 右侧还有多少天
                  _stillDays(stillMinutes, stillDays),
                ],
              ),
              // 进度指示条
              _marathonPercentIndicator(stillMinutes, stillDays, context),
            ],
          ),
        ),
      ),
    );
  }

  Text _marathonName() {
    return Text(
      marathon.name,
      style: const TextStyle(
          fontSize: 16, fontFamily: "霞鹜文楷", fontWeight: FontWeight.bold),
    );
  }

  // 右侧还有多少天
  Row _stillDays(int stillMinutes, int stillDays) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          stillMinutes < 0 ? "过了" : "还有",
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          stillDays == 0
              ? marathon.time!
                  .difference(DateTime.now())
                  .inHours
                  .abs()
                  .toString()
              : Tools.diffDays(marathon.time!),
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          stillDays == 0 ? "小时" : "天",
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  // 进度指示条
  Container _marathonPercentIndicator(
      int stillMinutes, int stillDays, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      child: LinearPercentIndicator(
        lineHeight: 6.0,
        percent: stillMinutes < 0
            ? 0
            : (stillDays < 100 ? 1 - (stillDays / 100) : 0),
        animation: true,
        //isRTL: true, // 从右向左调转方向
        animationDuration: 1200,
        padding: const EdgeInsets.all(0),
        backgroundColor: Theme.of(context).colorScheme.primary,
        // 根据是否中签改变进度条颜色
        progressColor: marathon.isChosen == 2
            ? Theme.of(context).colorScheme.onError
            : Theme.of(context).colorScheme.onPrimaryContainer,
        barRadius: const Radius.circular(5),
      ),
    );
  }
}
