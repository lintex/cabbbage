import 'package:cabbbage/models/marathon.dart';
import 'package:cabbbage/tools/tools.dart';
import 'package:flutter/material.dart';

class MyDashboardMarathonTile extends StatelessWidget {
  const MyDashboardMarathonTile({super.key, required this.marathon});
  final Marathon marathon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        SizedBox(
          width: 40,
          child: Text(
            textAlign: TextAlign.right,
            Tools.diffDays(marathon.time!),
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'DigitalNumbers',
            ),
          ),
        ),
        Text(
          ' 天 距离 ',
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        Text(marathon.name)
      ]),
    );
  }
}
