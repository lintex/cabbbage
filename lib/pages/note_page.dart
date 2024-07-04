import 'package:cabbbage/components/gradient_background.dart';
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
    return Scaffold(
      // ? 此处不能使用Obx包裹ListView，必须使用GetBuilder
      // 使用SliverAppBar，标题可以隐藏

      body: GradientBackground(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightGreen.shade50,
              Colors.lightGreen.shade200,
            ]),
        child: CustomScrollView(slivers: [
          const SliverAppBar(
            title: Text(
              "笔记",
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            floating: true,
            // pinned: true,
            backgroundColor: Colors.transparent,
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
      ),

      floatingActionButton:
          MyFloatActionButton(onPressed: () => Get.toNamed('/newNote')),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
