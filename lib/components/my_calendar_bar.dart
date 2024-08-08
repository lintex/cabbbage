import 'package:flutter/material.dart';

class MyCalendarBar extends StatelessWidget {
  const MyCalendarBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          MyCalendarBarTile(
            number: "20",
            text: 'Mon',
          ),
          MyCalendarBarTile(
            number: "21",
            text: '二',
          ),
          MyCalendarBarTile(
            number: "22",
            text: '三',
          ),
          MyCalendarBarTile(
            number: "23",
            text: '四',
          ),
          MyCalendarBarTile(
            number: "24",
            text: '五',
          ),
          MyCalendarBarTile(
            number: "25",
            text: '六',
          ),
          MyCalendarBarTile(
            number: "26",
            text: '日',
          ),
          MyCalendarBarTile(
            number: "27",
            text: '一',
          ),
        ],
      ),
    );
  }
}

class MyCalendarBarTile extends StatelessWidget {
  const MyCalendarBarTile(
      {super.key, required this.number, required this.text});
  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(text, style: const TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}
