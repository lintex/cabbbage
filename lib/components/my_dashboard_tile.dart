import 'package:flutter/material.dart';

class MyDashboardTile extends StatelessWidget {
  const MyDashboardTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      height: 80,
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
    );
  }
}
