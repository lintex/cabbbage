import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/components/my_grid_tile.dart';
import 'package:xiao_note/pages/marathon_page.dart';
import 'package:xiao_note/pages/note_page.dart';
import 'package:xiao_note/pages/pace_calculate_page.dart';
import 'package:xiao_note/pages/ruler_page.dart';
import 'package:xiao_note/pages/timetable_page.dart';
import 'package:xiao_note/theme/theme.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text("全部功能")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                  color: greyBg,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(//
                  children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "学习测试",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "更多>",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true, //这一行不要列表无法显示
                  physics: const NeverScrollableScrollPhysics(), //不要无法滚动
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  crossAxisCount: 4,
                  children: <Widget>[
                    MyGridTile(
                      title: 'Todo',
                      onPressed: () => Get.to(() => const NotePage()),
                      icon: Icons.check_box_outlined,
                    ),
                    MyGridTile(
                      title: '笔记',
                      onPressed: () => Get.to(() => const NotePage()),
                      icon: Icons.notes_rounded,
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                  color: greyBg,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(//
                  children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "实用小工具",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  shrinkWrap: true, //这一行不要列表无法显示
                  physics: const NeverScrollableScrollPhysics(), //不要无法滚动
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  crossAxisCount: 4,
                  children: <Widget>[
                    MyGridTile(
                      title: '马拉松助手',
                      onPressed: () => Get.to(() => const MarathonPage()),
                      icon: Icons.run_circle_outlined,
                    ),
                    MyGridTile(
                      title: '配速计算器',
                      onPressed: () => Get.to(() => const PaceCalculatePage()),
                      icon: Icons.calculate_outlined,
                    ),
                    MyGridTile(
                      title: '课程表',
                      onPressed: () => Get.to(() => TimetablePage()),
                      icon: Icons.calendar_month_outlined,
                    ),
                    MyGridTile(
                      title: '尺子',
                      onPressed: () => Get.to(() => const RulerPage()),
                      icon: Icons.linear_scale,
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
