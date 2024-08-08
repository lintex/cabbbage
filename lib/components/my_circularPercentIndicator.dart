import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyCircularPercentIndicator extends StatelessWidget {
  const MyCircularPercentIndicator(
      {super.key,
      required this.value,
      required this.center,
      required this.radius,
      required this.progressColor,
      required this.lineWidth,
      required this.backgroundColor});
  final int value;
  final Widget center;
  final double radius;
  final Color progressColor;
  final Color backgroundColor;
  final double lineWidth;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      animation: true,
      animationDuration: 1200,
      lineWidth: lineWidth,
      percent: 1 - value / 100,
      // center: Text("${marathonStillDays.reduce(min)}天"),
      center: center,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
