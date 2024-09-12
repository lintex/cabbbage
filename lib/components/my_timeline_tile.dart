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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12)),
            color: Theme.of(context).colorScheme.primary),
        child: child);
  }
}
