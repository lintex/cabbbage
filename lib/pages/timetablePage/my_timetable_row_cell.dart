import 'package:flutter/material.dart';

class MyTimetableRowCell extends StatelessWidget {
  const MyTimetableRowCell({
    super.key,
    required this.num,
    required this.startTime,
    required this.endTime,
  });
  final String num;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(num),
          Text(
            startTime,
            style: TextStyle(fontSize: 10),
          ),
          Text(
            endTime,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
