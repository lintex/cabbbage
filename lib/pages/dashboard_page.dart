import 'package:flutter/material.dart';
import 'package:xiao_note/components/marquee_widget.dart';
import 'package:xiao_note/components/my_dashboard_tile.dart';
import 'package:xiao_note/components/my_drawer.dart';
import 'package:xiao_note/models/dashboard.dart';
import 'package:xiao_note/theme/theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> loopList = [
      "第一条消息",
      "第二条消息",
      "第三条消息",
      "第四条消息",
    ];
    return Scaffold(
      backgroundColor: greyBg,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: greyBg,
          title: Text(
            Dashboard.getTitle(),
            style: const TextStyle(fontSize: 18),
          )),
      drawer: const MyDrawer(),
      body: ListView(
        children: [
          MyDashboardTile(
              child: SizedBox(
            height: 20,
            child: MarqueeWidget(
              //子Item构建器
              itemBuilder: (BuildContext context, int index) {
                String itemStr = loopList[index];
                //通常可以是一个 Text文本
                return Text(itemStr);
              },
              //循环的提示消息数量
              count: loopList.length,
            ),
          )),
          const MyDashboardTile(
            child: Text("Test"),
          ),
          const MyDashboardTile(
            child: Text("Test"),
          ),
          const MyDashboardTile(
            child: Text("Test"),
          ),
          const MyDashboardTile(
            child: Text("Test"),
          ),
        ],
      ),
    );
  }
}
