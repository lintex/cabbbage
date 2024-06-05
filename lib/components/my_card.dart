// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cabbage/models/note.dart';
import 'package:cabbage/pages/notePage/edit_note_page.dart';
import 'package:cabbage/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => EditNotePage(note: note)),
      child: Container(
          //height: 60,
          width: double.infinity,
          //alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(20, 12, 20, 10),
          padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(11)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2.0, 2.0),
                blurRadius: 10.0,
              )
            ],
            // gradient: const LinearGradient(
            //   colors: [Colors.red, Colors.orange],
            // ),
          ),
          //transform: Matrix4.rotationZ(0.02)
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  // Row里面的Text要包在Expanded里面，不然不换行
                  note.text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: '霞鹜文楷',
                      //fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              note.cabId == 255
                  ? Icon(
                      Icons.push_pin,
                      color: grey,
                      size: 15,
                    )
                  : Icon(
                      Icons.more_vert,
                      color: grey,
                      size: 15,
                    )
            ],
          )),
    );
  }
}
