import 'dart:ffi';

import 'package:flutter/material.dart';

class MyTimetableRowCell extends StatelessWidget {
  MyTimetableRowCell({
    super.key,
    required this.num,
  });
  final int num;
  final List classTime = [
    {"num": 1, "startTime": "08:00", "endTime": "08:45"},
    {"num": 2, "startTime": "08:55", "endTime": "09:40"},
    {"num": 3, "startTime": "10:10", "endTime": "10:55"},
    {"num": 4, "startTime": "11:05", "endTime": "12:00"},
    {"num": 5, "startTime": "14:30", "endTime": "15:15"},
    {"num": 6, "startTime": "15:25", "endTime": "16:10"},
    {"num": 7, "startTime": "16:20", "endTime": "17:05"},
  ];
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    bool isInTimeScale(int num) {
      String nowDateStr =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      String startTimeStr =
          "$nowDateStr ${classTime[num - 1]["startTime"]}"; // 开始时间字符串（格式为HH:mm）
      String endTimeStr = "$nowDateStr ${classTime[num - 1]["endTime"]}";

      DateTime startTime = DateTime.parse(startTimeStr); // 将开始时间转换成DateTime对象
      DateTime endTime = DateTime.parse(endTimeStr); // 将结束时间转换成DateTime对象

      if (now.isAfter(startTime) && now.isBefore(endTime)) {
        return true;
        //return const Color.fromARGB(255, 52, 131, 252);
      } else {
        return false;
        //return Theme.of(context).colorScheme.inversePrimary;
      }
    }

    return Container(
      alignment: Alignment.center,
      color: isInTimeScale(num)
          ? const Color.fromARGB(255, 222, 239, 255)
          : Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Text(
            num.toString(),
            style: TextStyle(
                color: isInTimeScale(num)
                    ? const Color.fromARGB(255, 52, 131, 252)
                    : Theme.of(context).colorScheme.inversePrimary),
          ),
          Text(
            classTime[num - 1]["startTime"],
            style: TextStyle(
                fontSize: 10,
                color: isInTimeScale(num)
                    ? const Color.fromARGB(255, 52, 131, 252)
                    : Theme.of(context).colorScheme.inversePrimary),
          ),
          Text(
            classTime[num - 1]["endTime"],
            style: TextStyle(
                fontSize: 10,
                color: isInTimeScale(num)
                    ? const Color.fromARGB(255, 52, 131, 252)
                    : Theme.of(context).colorScheme.inversePrimary),
          ),
        ],
      ),
    );
  }
}
