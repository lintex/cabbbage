import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// 创建业务逻辑类
class MarathonController extends GetxController {
  List marathonList = [].obs;
  // 连接到数据库box
  final GetStorage box = GetStorage();
  //构造函数里面读取数据
  MarathonController() {
    if (box.read("MARATHONLIST") == null) {
      debugPrint("${box.read("MARATHONLIST")}读取数据数据为空");
      initData();
      writeData();
    } else {
      readData();
    }
  }
  void readData() {
    marathonList.addAll(box.read("MARATHONLIST"));
    //marathonList.addAll(jsonDecode(box.read("MARATHONLIST")));
    debugPrint("$marathonList读取数据......");
  }

  // 第一次运行APP初始化数据
  void initData() {
    marathonList.addAll([
      {
        "name": "2024苏州环金鸡湖半程马拉松",
        "location": "金鸡湖",
        "date": "2024-03-10 00:00:00.000"
      },
      {
        "name": "2024武汉马拉松",
        "location": "武汉",
        "date": "2024-04-24 00:00:00.000"
      },
      {
        "name": "2024郑开马拉松",
        "location": "郑州",
        "date": "2024-03-31 00:00:00.000"
      },
      {
        "name": "2024四川眉山仁寿半程马拉松",
        "location": "四川眉山",
        "date": "2024-02-25 00:00:00.000"
      },
      {
        "name": "2024陕西杨凌马拉松",
        "location": "杨凌农科城",
        "date": "2024-04-14 00:00:00.000"
      },
      {
        "name": "2024上海半程马拉松",
        "location": "陆家嘴",
        "date": "2024-04-21 00:00:00.000"
      },
      {
        "name": "2024北京半程马拉松",
        "location": "天安门广场",
        "date": "2024-04-21 00:00:00.000"
      },
    ]);
    debugPrint("数据初始化成功......");
  }
  //   marathonList.sort(
  //   (a, b) => a["date"].compareTo(b["date"]),
  // );

  // 更新数据
  void writeData() {
    //debugPrint(marathonList.toString());
    box.write("MARATHONLIST", marathonList);
    //box.write("MARATHONLIST", jsonEncode(marathonList));
    debugPrint("$marathonList写入成功!");
  }
}
