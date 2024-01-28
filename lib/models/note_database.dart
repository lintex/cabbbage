import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xiao_note/models/note.dart';

class NoteDatabase extends GetxController {
  static late Isar isar;

  // 初始化数据库
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
    debugPrint("Isar初始化成功！");
  }

  final List currentNotes = [].obs;

  // 添加数据
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));
    debugPrint("写入成功！");

    fetchNotes();
  }

  // 读取数据
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    debugPrint("读取成功！");
  }

  // 修改数据
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      debugPrint("修改成功！");
      await fetchNotes();
    }
  }

  // 删除数据
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    debugPrint("删除成功！");
    fetchNotes();
  }
  //
  //
}
