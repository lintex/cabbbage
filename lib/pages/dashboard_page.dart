import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/components/marquee_widget.dart';
import 'package:xiao_note/components/my_dashboard_tile.dart';
import 'package:xiao_note/components/my_drawer.dart';
import 'package:xiao_note/models/dashboard.dart';
import 'package:xiao_note/models/marathon_database.dart';
import 'package:xiao_note/pages/marathon_page2.dart';
import 'package:xiao_note/tools/tools.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    MarathonDatabase db = Get.put(MarathonDatabase());

    List<String> loopList = [];
    loopList = db.allMarathons
        .map((m) => '${m.name}还有${Tools.diffDays(m.time)}天')
        .toList();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            Dashboard.getTitle(),
            style: const TextStyle(fontSize: 18),
          )),
      drawer: const MyDrawer(),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () => Get.to(() => const MarathonPage2()),
            child: MyDashboardTile(
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
          const MyDashboardTile(
            child: Text("Test"),
          ),
        ],
      ),
    );
  }
}
