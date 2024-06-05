import 'package:cabbage/components/my_card.dart';
import 'package:cabbage/components/my_float_action_button.dart';
import 'package:cabbage/pages/notePage/new_note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbage/components/my_app_bar.dart';
import 'package:cabbage/models/database.dart';

// 日记页面

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: const MyAppBar(title: "笔记"),
      // ? 此处不能使用Obx包裹ListView，必须使用GetBuilder

      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("笔记"),
          floating: true,
          pinned: false,
          snap: true,
        ),
        GetBuilder<Database>(
            init: Database(),
            builder: (db) => SliverList.builder(
                  itemCount: db.currentNotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentNote = db.currentNotes[index];
                    return MyCard(note: currentNote);
                  },
                )),
      ]),
      // GetBuilder<Database>(
      //     init: Database(),
      //     builder: (db) => ListView.builder(
      //           itemCount: db.currentNotes.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             final note = db.currentNotes[index];
      //             return MyCard(content: note.text);
      //           },
      //         )),

      floatingActionButton: const MyFloatActionButton(toPage: NewNotePage()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
