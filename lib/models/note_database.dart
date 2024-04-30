import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cabbage/models/note.dart';

class Database extends GetxController {
  static late Isar noteIsar;
  // 初始化数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    noteIsar = await Isar.open([NoteSchema], directory: dir.path);
    debugPrint("Note Isar初始化成功！");
  }

  final List currentNotes = [].obs;

  // 添加数据
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await noteIsar.writeTxn(() => noteIsar.notes.put(newNote));
    debugPrint("noteIsar写入成功！");

    fetchNotes();
  }

  // 读取数据
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await noteIsar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    debugPrint("noteIsar读取成功！");
  }

  // 修改数据
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await noteIsar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await noteIsar.writeTxn(() => noteIsar.notes.put(existingNote));
      debugPrint("noteIsar修改成功！");
      await fetchNotes();
    }
  }

  // 删除数据
  Future<void> deleteNote(int id) async {
    await noteIsar.writeTxn(() => noteIsar.notes.delete(id));
    debugPrint("noteIsar删除成功！");
    fetchNotes();
  }
  //
  //
}
