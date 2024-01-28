import 'package:flutter/material.dart';

class MyTimetableColumnCell extends StatelessWidget {
  const MyTimetableColumnCell({
    super.key,
    required this.week,
    required this.date,
  });
  final String week;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 5),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(week),
          Text(
            date,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
