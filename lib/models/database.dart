import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xiao_note/models/marathon.dart';
import 'package:xiao_note/models/note.dart';

class Database extends GetxController {
  static late Isar isar;

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

    fetchMarathons();
  }

  // 读取数据
  Future<void> fetchMarathons() async {
    List<Marathon> fetchMarathons =
        await isar.marathons.where().sortByTime().findAll();
    allMarathons.clear();
    allMarathons.addAll(fetchMarathons);
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
      await fetchMarathons();
    }
  }

  // 删除数据
  Future<void> deleteMarathon(int id) async {
    await isar.writeTxn(() => isar.marathons.delete(id));
    debugPrint("Marathon Isar删除成功！");
    fetchMarathons();
  }

  // ----------------------------------------------
  //  Notes表相关操作
  // ----------------------------------------------
  final List currentNotes = [].obs;

  // 添加数据
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));
    debugPrint("noteIsar写入成功！");

    fetchNotes();
  }

  // 读取数据
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    debugPrint("noteIsar读取成功！");
  }

  // 修改数据
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("noteIsar修改成功！");
      await fetchNotes();
    }
  }

  // 删除数据
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    debugPrint("noteIsar删除成功！");
    fetchNotes();
  }
}
