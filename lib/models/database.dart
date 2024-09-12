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
    debugPrint("[成功]Isar初始化成功！");
  }
  // ----------------------------------------------
  //  Marathon表相关操作
  // ----------------------------------------------

  // 通过GetX存储比赛列表
  final List allMarathons = [].obs;
  final List stillMarathons = [].obs;
  final List expiredMarathons = [].obs;
  final List noChosenMarathons = [].obs;
  final List currentMarathon = [].obs;

  // 添加比赛
  Future<void> addMarathon(
      String name,
      DateTime time,
      String start,
      String finish,
      String hotel,
      String packet,
      String bibNumber,
      byte isChosen) async {
    final newMarathon = Marathon()
      ..name = name
      ..time = time
      ..start = start
      ..finish = finish
      ..hotel = hotel
      ..packet = packet
      ..bibNumber = bibNumber
      ..isChosen = isChosen;

    await isar.writeTxn(() => isar.marathons.put(newMarathon));
    debugPrint("[成功][Marathon]添加比赛数据成功！");
    update();
    fetchMarathons();
  }

  // 读取马拉松比赛数据
  Future<void> fetchMarathons() async {
    // 获取未过期且还未出签的全部马拉松赛事
    List<Marathon> fetchMarathons = await isar.marathons
        .filter()
        .timeGreaterThan(DateTime.now())
        .not()
        .isChosenEqualTo(2)
        .sortByTime()
        .findAll();
    allMarathons.clear();
    allMarathons.addAll(fetchMarathons);
    // 获取还未到达日期的最近三条记录，首页显示用
    fetchMarathons = await isar.marathons
        .filter()
        .timeGreaterThan(DateTime.now())
        .sortByTime()
        .limit(3)
        .findAll();
    stillMarathons.clear();
    stillMarathons.addAll(fetchMarathons);
    // 获取未中签且还未过期的比赛，比赛助手页面使用
    fetchMarathons = await isar.marathons
        .filter()
        .isChosenEqualTo(2)
        .timeGreaterThan(DateTime.now())
        .sortByTime()
        .findAll();
    noChosenMarathons.clear();
    noChosenMarathons.addAll(fetchMarathons);
    // 获取过期的比赛，比赛助手页面使用
    fetchMarathons = await isar.marathons
        .filter()
        .timeLessThan(DateTime.now())
        .sortByTimeDesc()
        .findAll();
    expiredMarathons.clear();
    expiredMarathons.addAll(fetchMarathons);
    debugPrint("[成功][Marathon]马拉松比赛数据读取成功！");
  }

  // 通过id读取一条马拉松数据
  Future<void> getMarathon(int id) async {
    List<Marathon> fetchMarathons =
        await isar.marathons.where().idEqualTo(id).findAll();
    currentMarathon.clear();
    currentMarathon.addAll(fetchMarathons);
    debugPrint("[成功][Marathon]通过id读取一条Marathon成功！");
  }

  // 修改马拉松比赛数据
  Future<void> updateMarathon(
    int id,
    String name,
    DateTime time,
    String start,
    String finish,
    String hotel,
    String packet,
    String bibNumber,
    byte isChosen,
  ) async {
    final existingMarathon = await isar.marathons.get(id);
    if (existingMarathon != null) {
      existingMarathon
        ..name = name
        ..time = time
        ..start = start
        ..finish = finish
        ..hotel = hotel
        ..packet = packet
        ..bibNumber = bibNumber
        ..isChosen = isChosen;
      await isar.writeTxn(() => isar.marathons.put(existingMarathon));
      debugPrint("[成功][Marathon]马拉松比赛数据修改成功！");
      update();
      fetchMarathons();
    }
  }

  // 删除数据
  Future<void> deleteMarathon(int id) async {
    await isar.writeTxn(() => isar.marathons.delete(id));
    debugPrint("[成功][Marathon]删除马拉松成功！");
    update();
    fetchMarathons();
  }

  // ----------------------------------------------
  //  Notes表相关操作
  // ----------------------------------------------
  final List currentNotes = [].obs;
  final List lastNotes = [].obs;
  final List todos = [].obs;
  final List lastTodos = [].obs;
  final List allNotes = [].obs;

  // 读取Note所有数据，包括笔记待办图片
  Future<void> fetchAllNotes() async {
    List<Note> fetchNotes =
        await isar.notes.where().sortByCreatedTime().limit(50).findAll();
    allNotes.clear();
    allNotes.addAll(fetchNotes);
    debugPrint("[成功][Note]所有类型Note数据读取成功！");
  }

  // 添加Note数据
  Future<void> addNote(String textFromUser, {int cabId = 250}) async {
    final newNote = Note()
      ..text = textFromUser
      ..cabId = cabId;

    await isar.writeTxn(() => isar.notes.put(newNote));
    debugPrint("[成功][Note]添加Note成功！");
    // 必须update不然页面不会更新
    update();
    fetchNotes();
  }

  // 读取Note数据
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes
        .filter()
        .cabIdGreaterThan(249)
        .sortByCabIdDesc()
        .thenByCreatedTimeDesc()
        .limit(50)
        .findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    fetchLastNote();
    fetchTodos();
    fetchAllNotes();
    fetchLastTodos();
    debugPrint("[成功][Note]Note数据读取成功！");
  }

  // 读取最后一条Note数据
  Future<void> fetchLastNote() async {
    // 这个地方不能用Id排序很是困惑，只能用时间倒序取最后一条记录
    List<Note> fetchNotes = await isar.notes
        .filter()
        .cabIdGreaterThan(249)
        .sortByCreatedTimeDesc()
        .limit(5)
        .findAll();
    lastNotes.clear();
    lastNotes.addAll(fetchNotes);
    debugPrint("[成功][Note]最后5条Note读取成功！");
  }

  // 读取Todo数据
  Future<void> fetchTodos() async {
    List<Note> fetchNotes = await isar.notes
        .filter()
        .cabIdLessThan(2)
        .sortByCabId()
        .thenByLastEditedTimeDesc()
        .limit(50)
        .findAll();
    todos.clear();
    todos.addAll(fetchNotes);
    debugPrint("[成功][Todo]Todo信息读取成功！");
  }

  // 读取最后三条Todo数据
  Future<void> fetchLastTodos() async {
    List<Note> fetchNotes = await isar.notes
        .filter()
        .cabIdLessThan(2)
        .sortByCabId()
        .thenByLastEditedTimeDesc()
        .limit(3)
        .findAll();
    lastTodos.clear();
    lastTodos.addAll(fetchNotes);
    debugPrint("[成功][Todo]最后三条Todo读取成功！");
  }

  // 修改数据
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote
        ..text = newText
        ..lastEditedTime = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("[成功][Note]数据修改成功！");
      update();
      fetchNotes();
    }
  }

  // 置顶note
  Future<void> setTopNote(int id) async {
    changeCabId(id, 255);
    debugPrint("[成功][Note]置顶成功！");
  }

  // 取消置顶note
  Future<void> cancelTopNote(int id) async {
    changeCabId(id, 250);
    debugPrint("[成功][Note]取消置顶成功！");
  }

  // 改变CabId切换类型，待办完成也是在这里修改cabId
  Future<void> changeCabId(int id, int newCabId) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote
        ..cabId = newCabId
        ..lastEditedTime = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("[成功][Note]CabId切换为$newCabId！");
      update();
      fetchNotes();
    }
  }

  // 删除数据
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    debugPrint("[成功][Note]note删除成功！");
    update();
    fetchNotes();
  }
}
