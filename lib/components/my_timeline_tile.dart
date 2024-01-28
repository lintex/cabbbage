import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast});
  final bool isFirst;
  final bool isLast;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,

        //线条样式风格设置
        beforeLineStyle: LineStyle(
            color: isPast ? Colors.deepPurple : Colors.deepPurple.shade200),
        indicatorStyle: IndicatorStyle(
            color: isPast ? Colors.deepPurple : Colors.deepPurple.shade200,
            width: 40,
            iconStyle: IconStyle(
                iconData: Icons.done,
                color: isPast ? Colors.white : Colors.deepPurple.shade200)),
        endChild: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: isPast ? Colors.deepPurple : Colors.deepPurple.shade200,
              borderRadius: BorderRadius.circular(8)),
          child: const Text(
            "hahahhhahaha",
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
