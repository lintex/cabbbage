import 'package:cabbbage/components/empty_listview.dart';

import 'package:cabbbage/components/my_app_bar.dart';
import 'package:cabbbage/components/my_card.dart';
import 'package:cabbbage/components/my_float_action_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbbage/models/database.dart';

// 笔记页面

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Get.find();
    return Scaffold(
      // ? 此处不能使用Obx包裹ListView，必须使用GetBuilder
      // 使用SliverAppBar，标题可以隐藏
      appBar: const MyAppBar(title: "笔记"),
      body: EmptyListView(
        items: db.currentNotes,
        onPressed: () => Get.toNamed('/newNote'),
        child: GetBuilder<Database>(
            init: Database(),
            builder: (db) => ListView.builder(
                  itemCount: db.currentNotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentNote = db.currentNotes[index];
                    return MyCard(note: currentNote);
                  },
                )),
      ),

      floatingActionButton:
          MyFloatActionButton(onPressed: () => Get.toNamed('/newNote')),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
