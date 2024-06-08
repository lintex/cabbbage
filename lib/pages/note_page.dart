import 'package:cabbbage/components/my_card.dart';
import 'package:cabbbage/components/my_float_action_button.dart';
import 'package:cabbbage/pages/notePage/new_note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/models/database.dart';

// 笔记页面

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // ? 此处不能使用Obx包裹ListView，必须使用GetBuilder
      // 使用SliverAppBar，标题可以隐藏

      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("笔记"),
          centerTitle: true,
          floating: true,
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

      floatingActionButton: const MyFloatActionButton(toPage: NewNotePage()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
