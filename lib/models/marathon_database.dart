import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xiao_note/models/marathon.dart';
import 'package:xiao_note/models/note.dart';

class MarathonDatabase extends GetxController {
  static late Isar marathonIsar;

  // 初始化数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    marathonIsar =
        await Isar.open([MarathonSchema, NoteSchema], directory: dir.path);
    debugPrint("Marathon Isar初始化成功！");
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

    await marathonIsar.writeTxn(() => marathonIsar.marathons.put(newMarathon));
    debugPrint("Marathon Isar写入成功！");

    fetchMarathons();
  }

  // 读取数据
  Future<void> fetchMarathons() async {
    List<Marathon> fetchMarathons =
        await marathonIsar.marathons.where().sortByTime().findAll();
    AllMarathons.clear();
    AllMarathons.addAll(fetchMarathons);
    debugPrint("Marathon Isar读取成功！");
  }

  // 修改数据
  Future<void> updateMarathon(int id, String name, DateTime time, String start,
      String finish, String hotel) async {
    final existingMarathon = await marathonIsar.marathons.get(id);
    if (existingMarathon != null) {
      existingMarathon
        ..name = name
        ..time = time
        ..start = start
        ..finish = finish
        ..hotel = hotel;
      await marathonIsar
          .writeTxn(() => marathonIsar.marathons.put(existingMarathon));
      debugPrint("Marathon Isar修改成功！");
      await fetchMarathons();
    }
  }

  // 删除数据
  Future<void> deleteMarathon(int id) async {
    await marathonIsar.writeTxn(() => marathonIsar.marathons.delete(id));
    debugPrint("Marathon Isar删除成功！");
    fetchMarathons();
  }
}
