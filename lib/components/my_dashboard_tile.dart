import 'package:flutter/material.dart';

class MyDashboardTile extends StatelessWidget {
  const MyDashboardTile({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: child,
    );
  }
}
