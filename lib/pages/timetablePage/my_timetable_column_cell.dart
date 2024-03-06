import 'package:flutter/material.dart';

class MyTimetableColumnCell extends StatelessWidget {
  const MyTimetableColumnCell({
    super.key,
    required this.weekday,
  });
  final int weekday;

  @override
  Widget build(BuildContext context) {
    getDate(int weekday) {
      // DateTime now = DateTime(2024, 3, 11);
      DateTime now = DateTime.now();
      int nowWeekday = now.weekday;
      return "${now.month}/${now.day - (nowWeekday - weekday)}";
    }

    getTextColor(int weekday) {
      DateTime now = DateTime.now();
      int nowWeekday = now.weekday;
      if (weekday == nowWeekday) {
        return Colors.blue;
      } else {
        return Colors.black;
      }
    }

    List chWeekList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
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
