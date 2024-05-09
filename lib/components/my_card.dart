// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 60,
        width: double.infinity,
        //alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(20, 12, 20, 10),
        padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
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
        child: Text(
          content,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: '霞鹜文楷',
              //fontWeight: FontWeight.bold,
              color: Colors.black),
        ));
  }
}
