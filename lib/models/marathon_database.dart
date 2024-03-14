import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xiao_note/models/marathon.dart';

class MarathonDatabase extends GetxController {
  static late Isar isar;

  // 初始化数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([MarathonSchema], directory: dir.path);
    debugPrint("Isar初始化成功！");
  }

  // 通过GetX存储比赛列表
  final List AllMarathons = [].obs;

  // 添加比赛
  Future<void> addMarathon(String name, DateTime time, String start,
      String finish, String hotel) async {
    final newMarathon = Marathon()
      ..name = name
      ..time = time
      ..start = start
      ..finish = finish
      ..hotel = hotel;

    await isar.writeTxn(() => isar.marathons.put(newMarathon));
    debugPrint("写入成功！");

    fetchMarathons();
  }

  // 读取数据
  Future<void> fetchMarathons() async {
    List<Marathon> fetchMarathons =
        await isar.marathons.where().sortByTime().findAll();
    AllMarathons.clear();
    AllMarathons.addAll(fetchMarathons);
    debugPrint("读取成功！");
  }

  // 修改数据
  Future<void> updateMarathon(int id, String name, DateTime time, String start,
      String finish, String hotel) async {
    final existingMarathon = await isar.marathons.get(id);
    if (existingMarathon != null) {
      existingMarathon
        ..name = name
        ..time = time
        ..start = start
        ..finish = finish
        ..hotel = hotel;
      await isar.writeTxn(() => isar.marathons.put(existingMarathon));
      debugPrint("修改成功！");
      await fetchMarathons();
    }
  }

  // 删除数据
  Future<void> deleteMarathon(int id) async {
    await isar.writeTxn(() => isar.marathons.delete(id));
    debugPrint("删除成功！");
    fetchMarathons();
  }
  //
  //
}
