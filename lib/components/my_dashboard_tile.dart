import 'package:flutter/material.dart';

class MyDashboardTile extends StatelessWidget {
  const MyDashboardTile({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary,
      ),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: child,
    );
  }
}
