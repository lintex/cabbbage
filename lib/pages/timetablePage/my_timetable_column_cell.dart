import 'package:flutter/material.dart';

class MyTimetableColumnCell extends StatelessWidget {
  MyTimetableColumnCell({
    super.key,
    required this.weekday,
  });
  final int weekday;
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    getDate(int weekday) {
      // DateTime now = DateTime(2024, 3, 11);

      int nowWeekday = now.weekday;
      return "${now.month}/${now.day - (nowWeekday - weekday)}";
    }

    getTextColor(int weekday) {
      int nowWeekday = now.weekday;
      if (weekday == nowWeekday) {
        return const Color.fromARGB(255, 52, 131, 252);
      } else {
        return Theme.of(context).colorScheme.inversePrimary;
      }
    }

    List chWeekList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
      color: now.weekday == weekday
          ? const Color.fromARGB(255, 222, 239, 255)
          : Theme.of(context).colorScheme.background,
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            chWeekList[weekday - 1],
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: getTextColor(weekday)),
          ),
          Text(
            getDate(weekday),
            style: TextStyle(fontSize: 10, color: getTextColor(weekday)),
          ),
        ],
      ),
    );
  }
}
