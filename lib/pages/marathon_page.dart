import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/components/my_text_divider.dart';
import 'package:xiao_note/pages/marathonPage/marathon_controller.dart';
import 'package:xiao_note/pages/marathonPage/my_floating_action_button.dart';
import 'package:xiao_note/theme/theme.dart';

class MarathonPage extends StatelessWidget {
  const MarathonPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MarathonController mc = Get.put(MarathonController());
    //mc.readData();

    return Obx(() => Scaffold(
        backgroundColor: bg,
        floatingActionButton: const MyFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        appBar: const MyAppBar(title: "马拉松助手"),
        //判断是否有数据
        body: mc.marathonList.isEmpty
            ? const Center(
                child: Text("还没有添加数据"),
              )
            : ListView(
                children: [
                  for (var m in mc.marathonList)
                    Container(
                      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                      child: Slidable(
                        endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              // 修改按钮
                              SlidableAction(
                                onPressed: (e) {
                                  mc.marathonList.remove(m);
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
                                  mc.marathonList.remove(m);
                                  mc.writeData();
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
                                  color: Colors.grey.shade300,
                                  blurRadius: 2,
                                  offset: const Offset(1.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                              //根据天数改变背景色
                              color: DateTime.parse(m["date"])
                                          .difference(DateTime.now())
                                          .inDays <
                                      0
                                  ? Colors.grey[200]
                                  : blueBg),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 显示马拉松名称
                                  Text(
                                    "${m["name"]}",
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
                                    "${DateTime.parse(m["date"]).year.toString()}年${DateTime.parse(m["date"]).month.toString()}月${DateTime.parse(m["date"]).day.toString()}日 | ${m["location"]}",
                                    // .toString().padLeft(2, '0')
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "霞鹜文楷",
                                        color: Colors.grey[800]),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    DateTime.parse(m["date"])
                                                .difference(DateTime.now())
                                                .inDays <
                                            0
                                        ? "过了"
                                        : "还有",
                                    style: const TextStyle(
                                        fontSize: 9, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateTime.parse(m["date"])
                                        .difference(DateTime.now())
                                        .inDays
                                        .abs()
                                        .toString(),
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "天",
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  const MyTextDivider(text: "跑起来就有风"),
                  const SizedBox(height: 50),
                ],
              )));
  }
}
