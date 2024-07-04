import 'package:cabbbage/components/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:cabbbage/components/my_grid_tile.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MyAppBar(title: "全部功能"),
      body: GradientBackground(
        gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: const [
              0.3,
              0.5,
              0.7,
              0.9
            ],
            colors: [
              Colors.lightGreen.shade300,
              Colors.lightGreen.shade500,
              Colors.lightGreen.shade700,
              Colors.lightGreen.shade900,
            ]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 500,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Column(//
                    children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "主要功能",
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
                        onPressed: () => Get.toNamed('/todo'),
                        icon: Icons.check_box_outlined,
                      ),
                      MyGridTile(
                        title: '笔记',
                        onPressed: () => Get.toNamed('/note'),
                        icon: Icons.article_outlined,
                      ),
                      MyGridTile(
                        title: '管理',
                        onPressed: () => Get.toNamed('/manage'),
                        icon: Icons.manage_accounts_outlined,
                      ),
                    ],
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
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
                        onPressed: () => Get.toNamed('/marathon'),
                        icon: Icons.run_circle_outlined,
                      ),
                      MyGridTile(
                        title: '配速计算器',
                        onPressed: () => Get.toNamed('/pace'),
                        icon: Icons.calculate_outlined,
                      ),
                      MyGridTile(
                        title: '课程表',
                        onPressed: () => Get.toNamed('/timeTable'),
                        icon: Icons.calendar_month_outlined,
                      ),
                      MyGridTile(
                        title: '尺子',
                        onPressed: () => Get.toNamed('ruler'),
                        icon: Icons.format_align_left,
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
