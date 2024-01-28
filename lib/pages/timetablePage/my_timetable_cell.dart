import 'package:flutter/material.dart';

class MyTimetableCell extends StatelessWidget {
  const MyTimetableCell({
    super.key,
    this.className = "",
    this.bgColor,
    this.textColor,
    this.location = "",
    this.teacher = "",
  });
  final String className;
  final Color? bgColor;
  final Color? textColor;
  final String location;
  final String teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.symmetric(vertical: 8),
      //height: 60,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          // 几班上课
          Text(
            className,
            style: TextStyle(color: textColor, fontSize: 12),
          ),
          // 教室位置
          Text(
            location == "" ? "" : "@$location",
            style: TextStyle(color: textColor, fontSize: 10),
          ),
          // 班主任名字
          Text(
            teacher,
            style: TextStyle(color: textColor, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
