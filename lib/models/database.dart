import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cabbbage/models/marathon.dart';
import 'package:cabbbage/models/note.dart';

class Database extends GetxController {
  static late Isar isar;
  Database() {
    // 这里什么都不用写
    fetchNotes();
  }
  // 初始化数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([MarathonSchema, NoteSchema], directory: dir.path);
    debugPrint("Isar初始化成功！");
  }
  // ----------------------------------------------
  //  Marathon表相关操作
  // ----------------------------------------------

  // 通过GetX存储比赛列表
  final List allMarathons = [].obs;
  final List stillMarathons = [].obs;
  final List currentMarathon = [].obs;

  // 添加比赛
  Future<void> addMarathon(String name, DateTime time, String start,
      String finish, String hotel, String packet) async {
    final newMarathon = Marathon()
      ..name = name
      ..time = time
      ..start = start
      ..finish = finish
      ..hotel = hotel
      ..packet = packet;

    await isar.writeTxn(() => isar.marathons.put(newMarathon));
    debugPrint("Marathon Isar写入成功！");
    update();
    fetchMarathons();
  }

  // 读取数据
  Future<void> fetchMarathons() async {
    List<Marathon> fetchMarathons =
        await isar.marathons.where().sortByTime().findAll();
    allMarathons.clear();
    allMarathons.addAll(fetchMarathons);
    // 获取还未到达日期的最近三条记录
    fetchMarathons = await isar.marathons
        .filter()
        .timeGreaterThan(DateTime.now())
        .sortByTime()
        .limit(3)
        .findAll();
    stillMarathons.clear();
    stillMarathons.addAll(fetchMarathons);
    debugPrint("Marathon Isar读取成功！");
  }

  // 通过id读取一条马拉松数据
  Future<void> getMarathon(int id) async {
    List<Marathon> fetchMarathons =
        await isar.marathons.where().idEqualTo(id).findAll();
    currentMarathon.clear();
    currentMarathon.addAll(fetchMarathons);
    debugPrint("通过id读取Marathon成功！");
  }

  // 修改数据
  Future<void> updateMarathon(
    int id,
    String name,
    DateTime time,
    String start,
    String finish,
    String hotel,
    String packet,
  ) async {
    final existingMarathon = await isar.marathons.get(id);
    if (existingMarathon != null) {
      existingMarathon
        ..name = name
        ..time = time
        ..start = start
        ..finish = finish
        ..hotel = hotel
        ..packet = packet;
      await isar.writeTxn(() => isar.marathons.put(existingMarathon));
      debugPrint("Marathon Isar修改成功！");
      update();
      fetchMarathons();
    }
  }

  // 删除数据
  Future<void> deleteMarathon(int id) async {
    await isar.writeTxn(() => isar.marathons.delete(id));
    debugPrint("Marathon Isar删除成功！");
    update();
    fetchMarathons();
  }

  // ----------------------------------------------
  //  Notes表相关操作
  // ----------------------------------------------
  final List currentNotes = [].obs;
  final lastNote = ''.obs;

  // 添加数据
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()
      ..text = textFromUser
      ..createdTime = DateTime.now();

    await isar.writeTxn(() => isar.notes.put(newNote));
    debugPrint("noteIsar写入成功！");
    // 必须update不然页面不会更新
    update();
    fetchNotes();
  }

  // 读取数据
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes
        .where()
        .sortByCabIdDesc()
        .thenByCreatedTimeDesc()
        .findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    fetchLastNote();
    debugPrint("noteIsar读取成功！");
  }

  // 读取最后一条Note数据
  Future<void> fetchLastNote() async {
    // 这个地方不能用Id排序很是困惑，只能用时间倒序取最后一条记录
    List<Note> fetchNotes =
        await isar.notes.where().sortByCreatedTimeDesc().limit(1).findAll();
    lastNote.value = fetchNotes[0].text;
    debugPrint("noteIsar读取成功！内容为${fetchNotes[0].text}");
  }

  // 修改数据
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote
        ..text = newText
        ..lastEditedTime = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("noteIsar修改成功！");
      update();
      fetchNotes();
    }
  }

  // 置顶note
  Future<void> setTopNote(int id) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.cabId = 255;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("note置顶成功！");
      update();
      fetchNotes();
    }
  }

  // 取消置顶note
  Future<void> cancelTopNote(int id) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.cabId = 0;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("note取消置顶成功！");
      update();
      fetchNotes();
    }
  }

  // 删除数据
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    debugPrint("noteIsar删除成功！");
    update();
    fetchNotes();
  }
}
