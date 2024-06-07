import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 5, 35, 5),
      child: Expanded(
          child: Divider(
        thickness: 0.5,
        color: Colors.grey[400],
      )),
    );
  }
}
