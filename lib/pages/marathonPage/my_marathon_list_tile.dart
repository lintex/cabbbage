import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:xiao_note/models/marathon.dart';
import 'package:xiao_note/models/marathon_database.dart';
import 'package:xiao_note/pages/marathonPage/edit_marathon_page.dart';

class MyMarathonListTile extends StatelessWidget {
  MyMarathonListTile({super.key, required this.marathon});
  // 使用Get找到主页面使用的Controller
  final MarathonDatabase db = Get.find();
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
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          const SizedBox(
            width: 8,
          ),
          // 修改按钮
          SlidableAction(
            onPressed: (e) {
              // 跳转到修改信息页面
              Get.to(() => EditMarathonPage(marathon: marathon));
            },
            icon: Icons.edit,
            backgroundColor: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(
            width: 8,
          ),
          // 删除按钮
          SlidableAction(
            onPressed: (e) {
              delete(marathon.id);
            },
            icon: Icons.delete,
            backgroundColor: Colors.red.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 2,
                  offset: const Offset(1.0, 1.0),
                ),
              ],
              borderRadius: BorderRadius.circular(12),
              //根据天数改变背景色
              color: DateTime.parse(marathon.time.toString())
                          .difference(DateTime.now())
                          .inDays <
                      0
                  ? Colors.grey[200]
                  : Theme.of(context).colorScheme.primary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 显示马拉松名称
                  Text(
                    marathon.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "霞鹜文楷",
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // 显示马拉松举办时间和地点
                  Text(
                    "${marathon.time?.month.toString()}月${marathon.time?.day.toString()}日 ${marathon.time?.hour.toString()}:${marathon.time?.minute.toString().padLeft(2, '0')} | ${marathon.start}",
                    // .toString().padLeft(2, '0')
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "霞鹜文楷",
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    DateTime.parse(marathon.time.toString())
                                .difference(DateTime.now())
                                .inDays <
                            0
                        ? "过了"
                        : "还有",
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    (DateTime.now().difference(marathon.time!).inDays.abs() + 1)
                        .toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "天",
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
