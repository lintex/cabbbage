import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyCircularPercentIndicator extends StatelessWidget {
  const MyCircularPercentIndicator(
      {super.key,
      required this.value,
      required this.center,
      required this.radius,
      required this.progressColor});
  final int value;
  final Widget center;
  final double radius;
  final Color progressColor;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      animation: true,
      animationDuration: 1200,
      lineWidth: 8.0,
      percent: 1 - value / 100,
      // center: Text("${marathonStillDays.reduce(min)}天"),
      center: center,
      progressColor: progressColor,
      backgroundColor: Colors.lightGreen.shade200,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
