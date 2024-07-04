import 'package:cabbbage/components/my_read_more_text.dart';
import 'package:cabbbage/models/note.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';
import 'package:get/get.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Note note = Get.arguments;

    return Scaffold(
        appBar: const MyAppBar(title: "NoteDetailPage"),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyReadMoreText(
                note.text,
                trimLines: 15,
              ),
            ],
          ),
        ));
  }
}
