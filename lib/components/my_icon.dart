import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  const MyIcon(
    this.icon, {
    super.key,
    this.color = Colors.grey,
  });
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
