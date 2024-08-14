import 'package:flutter/material.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile(
    this.child, {
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary),
        child: child);
  }
}
