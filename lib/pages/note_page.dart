import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_note/components/my_app_bar.dart';
import 'package:xiao_note/models/note.dart';
import 'package:xiao_note/models/note_database.dart';

// 日记页面

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    super.initState();
    // 程序启动时读取数据，下方自定义函数通过NoteDatabase读取数据
    readNotes();
  }

  // 初始化Controller读取输入框
  final textController = TextEditingController();
  // 初始化NoteDatabase
  final NoteDatabase ndb = NoteDatabase();

  // 新建一条note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // 存到数据库
                    ndb.addNote(textController.text);
                    // 清空文本框并返回
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("确定"),
                )
              ],
            ));
  }

  // 读取所有notes
  void readNotes() {
    ndb.fetchNotes();
  }

  // 修改note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Update Note"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    ndb.updateNote(note.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                ),
              ],
            ));
  }

  // 删除note
  void deleteNote(int id) {
    ndb.deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //final noteDatabase = context.watch<NoteDatabase>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MyAppBar(title: "日记"),
      // ? Obx包裹ListView，应有更好解决方案
      body: Obx(() => ListView.builder(
            itemCount: ndb.currentNotes.length,
            itemBuilder: (BuildContext context, int index) {
              final note = ndb.currentNotes[index];
              return ListTile(
                title: Text(note.text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
